/**
 * \file
 * \brief init process.
 */

/*
 * Copyright (c) 2007, 2008, 2009, 2010, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */
#include "init.h"
#include <barrelfish/mem_serv.h>
#include <stdlib.h>
#include <string.h>
#include <barrelfish/fat32.h>
#include <barrelfish/morecore.h>
#include <barrelfish/dispatcher_arch.h>
#include <barrelfish/debug.h>
#include <barrelfish/lmp_chan.h>
#include <barrelfish/sys_debug.h>
#include <math.h>
#include <barrelfish/aos_rpc.h>
#include <barrelfish/omap_uart.h>
#include <barrelfish/thread_sync.h>
#include <spawndomain/spawndomain.h>
#include <barrelfish/thread_sync.h>
#include <barrelfish/proc.h>
#include <barrelfish/boot.h>
#include <barrelfish/cross_core.h>
#include <mm/mm.h>

#define UNUSED(x) (x) = (x)

#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)


// shared variable between cross-core thread and recv handler
volatile int pseudo_lock;

struct thread_mutex process_list_lock;

struct bootinfo *bi;
static coreid_t my_core_id;
struct serial_ring_buffer ring_b;
struct serial_capref_ring_buffer ring_c;
struct thread_cond char_cond;
struct thread_cond capref_cond;

struct process_node* pr_head;
int global_did = 1000;
int next_fd	   = 1000;

static int boot_thread(void *arg) 
{
	// Spawn process at core-0, update list and answer back to the client...

	errval_t err;
	struct boot_thread_args *args = (struct boot_thread_args *) arg;
	char * mod_name = args->name;
	struct capref client_ep = args->ep;
	int core = args->core;

	
	if (core == 1) {	
		// Spawn domain at core-1					
		global_did++;
	
		struct ump_message core_1_msg;
		core_1_msg.type = SPAWNED_PROCESS_REQUEST;
		core_1_msg.util_word = global_did;
		strcpy((char *) core_1_msg.words, mod_name);
		
		pseudo_lock = -1;

		write_to_core_1(core_1_msg);				

		// Wait on pseudo lock, pseudo lock has the domain-id of the domain spawned	
		while(pseudo_lock == -1);	
			
		// Report back to shell that process was spawned with the domain-id of the domain
		err = lmp_ep_send1(client_ep, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, pseudo_lock);
		if (err_is_fail(err)) {
			DEBUG_ERR(err,"recv_handler: Can not report process creation back to client!\n");
		}

		if (pseudo_lock != 0) {
			err = lmp_ep_send1(client_ep, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, 0);
			if (err_is_fail(err)) {
				DEBUG_ERR(err,"recv_handler: Can not report back to client!\n");
			}
		}			
		
		cap_destroy(client_ep);
	}
	else {

		char prefix[100] = "armv7/sbin/";	
		void *buf = NULL;
		uint32_t len = 0;
	
		char * name = strcat(prefix, mod_name);
	
		debug_printf("Reading module %s binary from SD card.. This might take a while...\n", mod_name);
		
		struct module_node * module = get_module_from_cache(name);
		if (module == NULL) {
			err = read_file(name, &buf, 0, 0, &len, true);
			if (err_is_fail(err)) {
				debug_printf("Could not read module from sd card! Will boot it from kernel\n");
			}	
			else 
				put_module_in_cache( name, buf, len);
		}
		else {
			buf = module->module_data;
			len = module->len; 
		}

		struct spawninfo si;	
		struct capref disp_frame;
		domainid_t d_id;
		
		err = bootstrap_domain(mod_name, &si, bi, my_core_id, &disp_frame, global_did + 1, buf, len);
		if (err_is_fail(err)) {
			debug_printf("boot_thread: Can not spawn process for the client! With error %s\n", err_getstring(err));
			d_id = 0;	
		}
		else {
			thread_mutex_lock(&process_list_lock);
			global_did++;
			d_id = global_did;	
			pr_head = insert_process_node (pr_head, d_id, mod_name, false, client_ep, disp_frame);
			thread_mutex_unlock(&process_list_lock);
		}
		
		err = lmp_ep_send1(client_ep, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, d_id);
		if (err_is_fail(err)) {
			DEBUG_ERR(err,"boot_thread: Can not send domain id back to the client!\n");
		}
	}		

	free(args->name);
	free(args);

	return 0;
}

static int cross_core_thread_0(void *arg) 
{
	errval_t err;	
	void * buf;
	err = map_shared_frame(&buf, false);

	while(1) 
	{

		struct ump_message received_message = read_from_core_0();
		
		int type = received_message.type;
		
		switch(type) {
			case (SPAWNED_PROCESS_REQUEST_PERMISSION_FOR_SPAWN): ;
				// Remote core requests permission to spawn a process!		
				char spawned_process_requested[36];
				
				strncpy(spawned_process_requested, (char *) received_message.words, 36);

				// Always grant permission to remote core for spawning a process locally
				struct ump_message permission_message;
				permission_message.util_word = ++global_did;
				permission_message.type = SPAWNED_PROCESS_RESPONSE_PERMISSION_FOR_SPAWN;
				write_to_core_1(permission_message);
				
				break;			
			case(SPAWNED_PROCESS_RESPONSE): ;				
				// Remote core spawned a domain!				
				char spawned_process[36];
				int success_spawn = received_message.util_word;

				strncpy(spawned_process, (char *) received_message.words, 36);
				
				if (success_spawn != 0) {
					thread_mutex_lock(&process_list_lock);
					pr_head = insert_process_node(pr_head, success_spawn, spawned_process, true, NULL_CAP, NULL_CAP);
					thread_mutex_unlock(&process_list_lock);
				}
					
			    // debug_printf("core-1 returned to us spawned response with response %d and name %s!\n", success_spawn, spawned_process);
				pseudo_lock = success_spawn;
	
				break;
			case(SPAWNED_PROCESS_TERMINATED_RESPONSE): ;
				// Received that a remote domain terminated! Delete process from the list, the other core does the same..
				domainid_t remote_did = received_message.util_word;
				// debug_printf("Domain with id %zu terminated! \n", remote_did);
		
				thread_mutex_lock(&process_list_lock);
				delete_process_node( &pr_head, remote_did, "aaa");
				thread_mutex_unlock(&process_list_lock);

				break;
			
			case(SERIAL_PUT_CHAR): ;
				char received_char = received_message.words[0];
			
				serial_putchar(received_char);
				break;

			case(SERIAL_PUT_STRING): ;
				char message_string[36];

				strncpy(message_string, (char *) received_message.words, 36);

				// debug_printf("Received a string over the cross core channel = %s\n", message_string);				
				serial_putstring(message_string);	
				break;
		}		
	}	

	return 0;
}

static void recv_handler(void *arg) 
{
		
	errval_t err;
	struct lmp_chan *lc = arg;
	struct lmp_recv_msg msg = LMP_RECV_MSG_INIT;
	struct capref cap;

	err = lmp_chan_recv(lc, &msg, &cap);
	if (err_is_fail(err) && lmp_err_is_transient(err)) {
		lmp_chan_register_recv(lc,get_default_waitset(),
							MKCLOSURE(recv_handler, arg));
	}
	
	lmp_chan_register_recv( lc, get_default_waitset(), MKCLOSURE(recv_handler, arg));
	err = lmp_chan_alloc_recv_slot(lc);
 	if (err_is_fail(err))
	{
		DEBUG_ERR(err,"Failed in new receiving slot allocation!\n");
	}	

	if (msg.buf.msglen == 0)  {
		debug_printf("Received an empty message!\n");
		return;
	}

	lc->remote_cap = cap;
	
	// msg.words[0][24-31] holds the rpc operation, msg.words[0][0-24] holds the domain-id from the process talking to us
	// init channel only has channel that all the clients communicate with. Each client is a domain and for each operation
	// transmits each domain-id as mentioned before. The servers (only init in our implementation) hold a list of domains
	// talking to them (process list in our implementation) that keeps all book keeping information regarding the processes.
	char message_string[38];	
	uint32_t buffer[38];	
	uint32_t rpc_operation = msg.words[0] >> 24;
	domainid_t domain_id = (domainid_t) msg.words[0] & 0x00FFFFFF;
	struct process_node * process;
		
	switch (rpc_operation) {
		case AOS_RPC_GET_DID: ;
			
			strncpy(message_string, (char *) msg.words + 4, 32);	
	
			debug_printf("Domain with name %s requested its id!\n", message_string); 
			domainid_t requested_did;
			requested_did = get_did_by_name(pr_head, message_string); 
		
			// Create frame to share with child as shared memory region
			struct capref shared_frame;
			err = get_frame(4096, &shared_frame);
			if (err_is_fail(err)) {
				debug_printf("Can not allocate shared frame!\n");
				shared_frame = NULL_CAP;
			}
		
			thread_mutex_lock(&process_list_lock);	
			process = get_process_node(&pr_head, requested_did, "aa");
			// Map shared frame at child process node
			debug_printf("Mapping shared frame for client!\n");
			err = paging_map_frame( get_current_paging_state(), 
										(void **) &(process->buffer),
										4096, shared_frame, NULL, NULL);

			// Assert some magic value that the other side expects. Sanity check
			for (int byte = 0; byte < 4096; byte++)
				*(process->buffer) = 'M';
			
			if (err_is_fail(err)) {
				debug_printf("Error in mapping the shared frame in our side!\n");
				shared_frame = NULL_CAP;
			}

			process->shared_frame = shared_frame;	
			thread_mutex_unlock(&process_list_lock);
								
			err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, shared_frame, (uint32_t) requested_did);
			if (err_is_fail(err))
				DEBUG_ERR(err,"recv_handler: Error in sending did back to the process!\n");	

			cap_destroy(cap);
			break;		
		case AOS_RPC_SEND_STRING: ; // Send String
			char received_string[4096];
				
			thread_mutex_lock(&process_list_lock);	
			process = get_process_node(&pr_head, domain_id, "aa");
			thread_mutex_unlock(&process_list_lock);	
	
			strncpy(received_string, process->buffer, 4096);		

			serial_putstring(received_string);
			
			err = lmp_chan_send0(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP);
			if (err_is_fail(err))
				DEBUG_ERR(err,"recv_handler: Error in sending string acknowledgement back to client!\n");	
	
			cap_destroy(cap);
			break;

		case AOS_RPC_GET_RAM_CAP: ;// Request Ram Capability
			size_t size_requested = msg.words[1];	
			struct capref returned_cap;
			genpaddr_t retbase;

			// debug_printf("Request for memory from client with %"PRIu32"\n", domain_id);
			// Check if client has exceeded it's memory limit
			// and keep track of the frames allocated from this client.
			thread_mutex_lock(&process_list_lock);	
			process = get_process_node(&pr_head, domain_id, "aa");
			if ((process->memory_consumed + pow(2, size_requested)) > CLIENT_MEMORY_LIMIT) {
				// Client has exceeded its memory limit do not give more memory.
				// debug_printf("Client exceeded it's limit!\n");
				returned_cap = NULL_CAP;
			}
			else {
				// Allocate memory for the client and keep the frame...
				process->memory_consumed += pow(2, size_requested);
		
				err = memserv_alloc(&returned_cap, size_requested, 0, 0, &retbase); 
				if (err_is_fail(err)) {
					debug_printf("recv_handler: Failed to allocate ram capability for client\n");
					returned_cap = NULL_CAP;	
				}
				
				//debug_printf("allocating frame! with base %"PRIu32" and size %" PRIu32 "\n", retbase, size_requested);	
				update_frame_list(process, returned_cap, size_requested, retbase);	
			}	

			thread_mutex_unlock(&process_list_lock);
				
			err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, returned_cap, (uint32_t) size_requested);	 
		    if (err_is_fail(err))
				DEBUG_ERR(err, "recv_handler: Error in sending cap back to the client!\n");					
			
			cap_destroy(cap);
			break;
		case AOS_RPC_PUT_CHAR: ;
			// debug_printf("recv_handler: AOS_RPC_PUT_CHAR from endpoint %d\n", cap.slot);

			char out_c = (char) msg.words[1];	
			serial_putchar(out_c);
			cap_destroy(cap);
			
			break;
		case AOS_RPC_GET_CHAR: ;
			//debug_printf("recv_handler: AOS_RPC_GET_CHAR from endpoint %d\n", lc->remote_cap.slot);
			// serial_putstring(BLUE);

			write_capref_to_ring(&ring_c, &cap);
			thread_cond_signal(&capref_cond);
			
			break;
		case AOS_RPC_PROC_SPAWN:;
			char *token;
			int core = msg.words[1];

			strncpy(message_string, (char *) msg.words + 8, 28);	
			token = strtok(message_string, " ");
			
			struct boot_thread_args* bt = (struct boot_thread_args *) malloc(sizeof(struct boot_thread_args));
			bt->name = malloc(strlen(token));
			bt->ep = cap;
			bt->core = core;
			strcpy(bt->name, token);
					
			//debug_printf("Will spawn %s at core %zu\n", message_string, core);	
			struct thread * _boot_thread = thread_create(boot_thread,bt);
			_boot_thread = _boot_thread;		

			break;
		case AOS_RPC_PROC_GET_NAME:;
			
			//debug_printf("recv_handler: Request for domain name with d_Id = %d\n", msg.words[1]);
			domainid_t did = msg.words[1];
			char * d_name;

			d_name = get_name_by_did(pr_head, did);
			if (d_name == NULL) {
				strcpy( (char *) buffer, "Not Found!");
			}
			else 
				strcpy((char*) buffer, d_name);

			//debug_printf("Will send to client name %s\n", buffer);			
			err = lmp_chan_send(lc , LMP_SEND_FLAGS_DEFAULT, NULL_CAP, 9,
					  buffer[0] , buffer[1],buffer[2],
					  buffer[3], buffer[4],buffer[5],
					  buffer[6], buffer[7],buffer[8]);
			if (err_is_fail(err)) {
				debug_printf("recv_handler: Can not send domain name back to the client!\n");
			}	
		
			cap_destroy(cap);
			break;
		case AOS_RPC_PROC_GET_PIDS:;
			
			memset(buffer, 0, 36);

			struct process_node * temp = pr_head;
			size_t count = 0;
			while (temp != NULL) {
				buffer[count++] = temp->d_id;
				temp = temp->next_pr;
			}					

			err = lmp_chan_send(lc , LMP_SEND_FLAGS_DEFAULT, NULL_CAP, 9,
					  buffer[0] , buffer[1],buffer[2],
					  buffer[3], buffer[4],buffer[5],
					  buffer[6], buffer[7],buffer[8]);
			if (err_is_fail(err)) {
				debug_printf("recv_handler: Can not send pids back to the client!\n");
			}	

			break;
		case AOS_RPC_GET_DEV_CAP:;
			 // debug_printf("recv_handler: Received request for device! \n");		

			lpaddr_t paddr = msg.words[1];
			size_t length = msg.words[2];
		
			// debug_printf("Received request for %p and %lu\n", paddr, length);	
			struct capref dev_cap;
			size_t retlen = 1;	
			err = get_devframe(&dev_cap, &retlen, paddr, length);
			if (err_is_fail(err)) {
				debug_printf("recv_handler: Can not break up device frame!\n");
				dev_cap = NULL_CAP;
			}

			err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, dev_cap, retlen);
			if (err_is_fail(err)) {
				DEBUG_ERR(err,"recv_handler: Can not send dev cap back to the client!\n");
			}
		
			cap_destroy(cap);
			break;
		case AOS_RPC_READ_DIR: ;	 
			// Will list() a directory and will return results to the caller
			char path[512];
	
			thread_mutex_lock(&process_list_lock);	
			process = get_process_node(&pr_head, domain_id, "aa");
			thread_mutex_unlock(&process_list_lock);	

			strcpy(path, process->buffer);
			//debug_printf("Client requests for path %s\n", path);
		
			struct aos_dirent * dirtable = NULL;
			uint32_t size;
	
			err = list(path, &dirtable, &size);
			// debug_printf("LIST returned!\n");
			if (err_is_fail(err)) {
				err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, (uint32_t) -1);
				if (err_is_fail(err)) {
					DEBUG_ERR(err,"recv_handler: Can not send request for listing directory back to the client!\n");
				}
			}
			else {
				memcpy(process->buffer, dirtable, size * sizeof(struct aos_dirent));

				err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, (uint32_t) size);
				if (err_is_fail(err)) {
					DEBUG_ERR(err,"recv_handler: Can not send request for listing directory back to the client!\n");
				}
			}

			free(dirtable);
			cap_destroy(cap);
			break;	
		case AOS_RPC_OPEN_FILE: ;
			char open_file_name[512];
			
			thread_mutex_lock(&process_list_lock);	
			process = get_process_node(&pr_head, domain_id, "aa");
			thread_mutex_unlock(&process_list_lock);	

			strncpy(open_file_name, process->buffer, 512);
			
			struct aos_dirent * temp_dirtable = NULL;
			uint32_t temp_size;
			err = list( open_file_name, &temp_dirtable, &temp_size);

			//debug_printf("Returned type = %" PRIu32 ". Type = %d Will open file %s\n", temp_size, temp_dirtable[0].type , temp_dirtable[0].name);
			// file not found, or a directory or not a file :)
			if (err_is_fail(err) || temp_size != 1 || temp_dirtable[0].type == typeDir) { 
				//debug_printf("no file!\n");
				err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, (uint32_t) -1);
				if (err_is_fail(err)) {
					DEBUG_ERR(err,"recv_handler: Can not send request for open file back to the client!\n");
				}
			}
			else {
				// File exists !
				thread_mutex_lock(&process_list_lock);	
				process = get_process_node(&pr_head, domain_id, "aa");
	
				next_fd ++;
				update_fd_list(process, next_fd, 0, open_file_name);

				//struct file_descriptor_node* n = process->fd_node;
				//while(n != NULL) {
				//	debug_printf("fd = %d name = %s\n", n->fd, n->file_name);
				//	n = n->next_file_descriptor;
				//}
				thread_mutex_unlock(&process_list_lock);	
				
				err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, (uint32_t) next_fd);
				if (err_is_fail(err)) {
					DEBUG_ERR(err,"recv_handler: Can not send request for open file back to the client!\n");
				}
			}

			free(temp_dirtable);
			cap_destroy(cap);
			break;
		case AOS_RPC_READ_FILE: ;
			int read_fd = msg.words[1];
			uint32_t read_pos = msg.words[2];
			uint32_t read_size = msg.words[3];
			int read_response;

			thread_mutex_lock(&process_list_lock);	
			process = get_process_node(&pr_head, domain_id, "aa");
			thread_mutex_unlock(&process_list_lock);	
			
			// debug_printf("Client requests to read file from fd %d at poss %" PRIu32 "\n", read_fd, read_pos);
				
			char * file_name = check_if_fd_exists(process->fd_node, read_fd);
			
			if (!file_name) {
				read_response = -1;
			}
			else {
				void * fbuf;
				if (read_size > 4096)
					read_size = 4096;	
		
				uint32_t ret_size;	
				err = read_file( file_name, &fbuf, read_pos, read_size, &ret_size, false);
				if (err_is_fail(err))
					read_response = -1;	
				else {
					read_response = ret_size;
					if (ret_size != 0)
						memcpy(process->buffer, fbuf, ret_size);	
				}
				
				free(fbuf);
			}

			err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, read_response);
			if (err_is_fail(err)) {
				DEBUG_ERR(err,"recv_handler: Can not send response for read file back to the client!\n");
			}
		
			break;
		case AOS_RPC_CLOSE_FILE: ;
			int close_fd = msg.words[1];
			int close_response;	
			
			thread_mutex_lock(&process_list_lock);	
			process = get_process_node(&pr_head, domain_id, "aa");
			thread_mutex_unlock(&process_list_lock);	

			// debug_printf("Client requests to close file with fd %d\n", fd);	
		
			if (!delete_fd( process, close_fd)) 
				close_response = -1;
			else 
				close_response = 1;

			struct file_descriptor_node* n = process->fd_node;
			while(n != NULL) {
				debug_printf("fd = %d name = %s\n", n->fd, n->file_name);
				n = n->next_file_descriptor;
			}


			err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, close_response);
			if (err_is_fail(err)) {
				DEBUG_ERR(err,"recv_handler: Can not send response for closing file back to the client!\n");
			}

			break;	

		case AOS_RPC_TERMINATING:;
			domainid_t exiting_did = msg.words[1];
			//int exit_status = (int) msg.words[2];		

			thread_mutex_lock(&process_list_lock);
			struct process_node * terminated_process = delete_process_node(&pr_head, exiting_did, "aa");
			thread_mutex_unlock(&process_list_lock);
			
			if (terminated_process == NULL) {
				debug_printf("recv_handler: Received message from unknown process?!\n");
				break;
			}
		
			if (!terminated_process->background) {
				// debug_printf("Sending termination did and status back to the client!\n");
				err = lmp_ep_send1(terminated_process->client_endpoint, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, terminated_process->d_id);
				if (err_is_fail(err)) {
					DEBUG_ERR(err,"recv_handler: Can not send domain id back to the client!\n");
				}	
			}

			// Clears the process node and released the ram used
			// by this child. 
			clear_process_node(terminated_process);
			free(terminated_process);
			
			break;
	}
}

static errval_t setup_channel(struct lmp_chan *channel) {

	errval_t err;
	struct waitset* ws = get_default_waitset();  	

	lmp_chan_init(channel);

	// Create our endpoint to self
	err = cap_retype(cap_selfep, cap_dispatcher, ObjType_EndPoint, 0);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Failed to create our endpoint to self");
		abort();
	}

	endpoint_create(FIRSTEP_BUFLEN, &channel->local_cap, 
					&channel->endpoint);
	if (err_is_fail(err)) {
		debug_printf("Error in creating endpoint!\n");
		abort();
	}

	err = lmp_chan_alloc_recv_slot(channel);
	if (err_is_fail(err)) {
		debug_printf("Error in allocating receiver slot!\n");
		abort();
	}

	struct event_closure recv_handler_init = {
        .handler = recv_handler,
        .arg = channel,
    };

	err = lmp_chan_register_recv(channel,ws, recv_handler_init);
	if (err_is_fail(err)) {
		debug_printf("Error in registering the channel..\n");	
		abort();
	}

	err = cap_copy(cap_initep, channel->local_cap);
	if (err_is_fail(err)) {
		debug_printf("Error in copying endpoint to cap_initep\n");	
		abort();
	}
		
	return SYS_ERR_OK;	
}

int main(int argc, char *argv[])
{
    errval_t err;
	struct lmp_chan channel;

	debug_printf("size of ump_message %d\n", sizeof(struct ump_message));

    /* Set the core id in the disp_priv struct */
    err = invoke_kernel_get_core_id(cap_kernel, &my_core_id);
    assert(err_is_ok(err));
    disp_set_core_id(my_core_id);

	debug_printf("init: invoked as:");
    for (int i = 0; i < argc; i++) {
       debug_printf(" %s", argv[i]);
    }
    debug_printf("\n");

    debug_printf("FIRSTEP_OFFSET should be %zu + %zu\n",
            get_dispatcher_size(), offsetof(struct lmp_endpoint, k));

    // First argument contains the bootinfo location
    bi = (struct bootinfo*)strtol(argv[1], NULL, 10);

    // setup memory serving
    err = initialize_ram_alloc();
    if (err_is_fail(err)) {
        DEBUG_ERR(err, "Failed to init local ram allocator");
        abort();
    }

	debug_printf("initialized local ram alloc\n");
	err = initialize_mem_serv(bi);
    if (err_is_fail(err)) {
        DEBUG_ERR(err, "Failed to init memory server module");
        abort();
    }

	err = init_devserver();
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Failed to init dev server !\n");
		abort();
	}

	// Initialize uart 
	struct capref temp_cap;
	size_t retlen;
	err = get_devframe( &temp_cap, &retlen, 0x48020000, 12);
	if (err_is_fail(err)) {
		debug_printf("Can not get device frame for uart!\n");
		abort();
	}	
	
	void *vbuf;
	err = paging_map_frame_attr(get_current_paging_state(), &vbuf, 0x1000, temp_cap, DEVICE_FLAGS, NULL,NULL);
	if (err_is_fail(err)) {
		debug_printf("Error in mapping uart exiting...\n");
		abort();
	}

	uart_initialize((lvaddr_t)vbuf);
	debug_printf("initialized uart!\n");

	// Initialize aux-core registers 
	err = get_devframe( &temp_cap, &retlen, 0x48281000, 12);
	if (err_is_fail(err)) {
		debug_printf("Can not get device frame for aux core registers!\n");
		abort();
	}	

	err = paging_map_frame_attr(get_current_paging_state(), &vbuf, 0x1000, temp_cap, DEVICE_FLAGS, NULL,NULL);
	if (err_is_fail(err)) {
		debug_printf("Error in mapping uart exiting...\n");
		abort();
	}

	lvaddr_t aux_core_0 = (lvaddr_t) vbuf + 0x800;
	lvaddr_t aux_core_1 = (lvaddr_t) vbuf + 0x804;

	debug_printf("Initializing the fat infrastructure...\n");
	fat32_init();

	// Boot core and wait for signal
	spawn_second_core(bi, aux_core_0, aux_core_1);
 	poll_for_core(aux_core_0);
		
	// Initialize fat-infrastructure
	thread_mutex_init(&process_list_lock);
	struct thread *cross_core_thread = thread_create( cross_core_thread_0, NULL);
	cross_core_thread = cross_core_thread;

	initialize_ring(&ring_b);
	initialize_capref_ring(&ring_c);

	struct ring_arguments args = {
		.r_b = &ring_b,
		.r_c = &ring_c,
		.char_wait_cond = &char_cond,
		.capref_wait_cond = &capref_cond,
	};

	thread_cond_init(&char_cond);
	thread_cond_init(&capref_cond);

	struct thread *serial_polling_thread = thread_create( poll_serial_thread, &args);
	serial_polling_thread = serial_polling_thread;
	
	struct thread * serial_client_thread = thread_create( get_char_thread, &args);
	serial_client_thread = serial_client_thread;
	
	err = setup_channel(&channel);
   	assert(err_is_ok(err));

	
	void *buf = NULL;
	uint32_t len = 0;
	
	/*	
	debug_printf("Reading shell binary from SD card.. This might take a while...\n");
	err = read_file("/armv7/sbin/shell", &buf, 0, 0, &len, true);
	if (err_is_fail(err)) {
		debug_printf("Could not read module from sd card!\n");
	}	
	*/

	struct spawninfo led_si;	
	struct capref dispframe1;
	err = bootstrap_domain("shell", &led_si, bi, my_core_id, &dispframe1, global_did, buf, len);
	pr_head = insert_process_node(pr_head, global_did, "shell", false, NULL_CAP, NULL_CAP);

	assert(err_is_ok(err));
	while(true) {
		err = event_dispatch(get_default_waitset());
		if (err_is_fail(err)) {
			DEBUG_ERR(err, "in main event_dispatch loop");
			return EXIT_FAILURE;
		}		
	}

    return EXIT_SUCCESS;
}

