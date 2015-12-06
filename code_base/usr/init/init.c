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
#include <stdlib.h>
#include <string.h>
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
#define NAME_MEMEATER "armv7/sbin/memeater"
#include "../../lib/spawndomain/arch.h"

#include <elf/elf.h>
#define INPUT_BUF_SIZE 4096
#define MALLOC_BUFSIZE (1UL<<20)
#define BUFSIZE 32L * 1024 * 1024
#define SAFE_VADDR (1UL<<25)
#define MAP_ADDR 0x6400000

#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)
#define CLIENT_LIMIT 			(1<<26)*10			

#define BLUE "\033[1m\033[31m"
#define RESET "\033[0m"

static struct mm dev_mm;

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

errval_t get_devframe(struct capref * ret, size_t * retlen, lpaddr_t start_addr, size_t length)
{
	errval_t err;

	//genpaddr_t ret_base;
	//err = mm_alloc_range(&dev_mm, length, start_addr, 0x8000000, ret, &ret_base);
	err = mm_realloc_range( &dev_mm, length, start_addr,ret);
	if (err_is_fail(err)) {
		debug_printf("get_dev_frame: can not allocate range for device!\n");
		return MM_ERR_DEVICE_ALLOC;
	}
	*retlen = ((0x80000000 - start_addr) < length) ? (0x80000000 - start_addr) : length;

	return SYS_ERR_OK;
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
				
				strcpy( spawned_process_requested, (char *) received_message.words);

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

				strcpy(spawned_process, (char *) received_message.words);
				
				if (success_spawn != 0) {
					thread_mutex_lock(&process_list_lock);
					pr_head = insert_process_node(pr_head, success_spawn, spawned_process, true, NULL_CAP, NULL_CAP);
					thread_mutex_unlock(&process_list_lock);
				}
					
			    debug_printf("core-1 returned to us spawned response with response %d and name %s!\n", success_spawn, spawned_process);
				pseudo_lock = success_spawn;
	
				break;
			case(SPAWNED_PROCESS_TERMINATED_RESPONSE): ;
				// Received that a remote domain terminated! Act...
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

				strcpy(message_string, (char *) received_message.words);

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

	// debug_printf("recv_handler initiating! With slot = %zu\n", cap.slot);

	//struct frame_identity fid;
	//err = invoke_frame_identify( cap, &fid);
	//assert(err_is_ok(err));
	
	lc->remote_cap = cap;

	int message_length = msg.buf.msglen;
	
	int string_length = message_length - 1;
	char message_string[32];
		
	uint32_t rpc_operation = msg.words[0];
	assert(message_length != 0);

	lmp_chan_register_recv( lc, get_default_waitset(), MKCLOSURE(recv_handler, arg));
	err = lmp_chan_alloc_recv_slot(lc);
 	if (err_is_fail(err))
	{
		DEBUG_ERR(err,"Failed in new receiving slot allocation!\n");
	}	

	//debug_printf("Entering switch!\n");	
	uint32_t buffer[38];
	
	switch (rpc_operation) {
		case AOS_RPC_GET_DID: ;
			
			for (int i = 0; i<string_length; i++){
				uint32_t * word = (uint32_t *) (message_string + i*4);
				*word = msg.words[i+1];   
			}	
			
			// debug_printf("Domain with name %s requested its id!\n", message_string); 
			domainid_t requested_did;
			requested_did = get_did_by_name(pr_head, message_string); 
			
			err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, (uint32_t) requested_did);
			if (err_is_fail(err))
				DEBUG_ERR(err,"recv_handler: Error in sending did back to the process!\n");	

			cap_destroy(cap);
			break;		
		case AOS_RPC_SEND_STRING: ; // Send String
			// debug_printf("recv_handler: AOS_RPC_SEND_STRING from endpoint %d\n", cap.slot);
	
			for (int i = 0; i<string_length; i++){
				uint32_t * word = (uint32_t *) (message_string + i*4);
				*word = msg.words[i+1];   
			}	
			
			serial_putstring(message_string);
	
		    // debug_printf("Message string = %s\n", message_string);	
			//err = lmp_chan_send0(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP);
			//if (err_is_fail(err)) {
			//	DEBUG_ERR(err,"recv_handler: Error in sending acknowledgment of send string back to client!\n");	
			//}	
			
			cap_destroy(cap);
			break;

		case AOS_RPC_GET_RAM_CAP: ;// Request Ram Capability
			size_t size_requested = msg.words[1];	
			struct capref returned_cap;

			// debug_printf("recv_handler: Requested for size %d\n", size_requested );	
		
			err = ram_alloc(&returned_cap, size_requested); 
			if (err_is_fail(err)) {
				debug_printf("recv_handler: Failed to allocate ram capability for client\n");
				returned_cap = NULL_CAP;	
			}
				
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
			domainid_t d_id;
			char *token;
			char *next_token;
			bool background;

			for (int i = 0; i < string_length-1 ; i++){
				uint32_t * word = (uint32_t *) (message_string + i*4);
				*word = msg.words[i+2];   
			}	

			uint32_t core = msg.words[1];
	
			debug_printf("Will spawn %s at core %zu\n", message_string, core);
			token = strtok(message_string, " ");
			
			if (core == 1) {
				
				// Spawn domain at core-1					
				global_did++;
			
				struct ump_message core_1_msg;
				core_1_msg.type = SPAWNED_PROCESS_REQUEST;
				core_1_msg.util_word = global_did;
				strcpy((char *) core_1_msg.words, message_string);
				
				pseudo_lock = -1;

				write_to_core_1(core_1_msg);				
	
				while(pseudo_lock == -1);	
				
				// Report back to shell that process was spawned
				err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, pseudo_lock);
				if (err_is_fail(err)) {
					DEBUG_ERR(err,"recv_handler: Can not send domain id back to the client!\n");
				}	
			}
			else {
				// Spawn domain at own core! 
				next_token = strtok(NULL, " ");
				
				if (next_token == NULL)
					background = false;
				else if (strcmp(next_token, "&"))
					background = false;
				else 
					background = true;
			
			 	struct spawninfo si;	
				struct capref disp_frame;
				global_did++;
	
				err = bootstrap_domain(token, &si, bi, my_core_id, &disp_frame, global_did);
				if (err_is_fail(err)) {
					debug_printf("recv_handler: Can not spawn process for the client! \n");
					d_id = 0;	
				}
				else {
					d_id = global_did;	
					thread_mutex_lock(&process_list_lock);
					pr_head = insert_process_node(pr_head, d_id, token, background, cap, disp_frame);
					thread_mutex_unlock(&process_list_lock);
				}
				
				err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, d_id);
				if (err_is_fail(err)) {
					DEBUG_ERR(err,"recv_handler: Can not send domain id back to the client!\n");
				}		
			}

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
				//debug_printf("Added to list %d\n", temp->d_id);
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
		
		//	debug_printf("Received request for %p and %lu\n", paddr, length);	
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
	
			cap_destroy(terminated_process->client_endpoint);
			cap_destroy(terminated_process->dispatcher_frame);
			
			free(terminated_process->name);
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
	err = initialize_mem_serv();
    if (err_is_fail(err)) {
        DEBUG_ERR(err, "Failed to init memory server module");
        abort();
    }

	static struct range_slot_allocator devframes_allocator;
    err = range_slot_alloc_init(&devframes_allocator, 1024, NULL);
    if (err_is_fail(err)) {
        return err_push(err, LIB_ERR_SLOT_ALLOC_INIT);
    }
	
	err = mm_init(&dev_mm, ObjType_DevFrame,
                  0x40000000,  30,
                  1, slab_default_refill, slot_alloc_dynamic,
                  &devframes_allocator, false);
    if (err_is_fail(err)) {
        return err_push(err, MM_ERR_MM_INIT);
    }

	err = mm_add(&dev_mm, cap_io, 30, 0x40000000);
	if (err_is_fail(err)) {
		debug_printf("Error in adding device frame to device memory manager!\n");
		abort();
	}

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

	map_aux_core_registers();

	spawn_second_core(bi);

 	poll_for_core();

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

/*
	debug_printf("Spawning memeater!\n"); 
	struct spawninfo mem_si;
	struct capref disp_frame;

	err = bootstrap_domain("memeater", &mem_si, bi, my_core_id, &disp_frame, global_did);

	pr_head = insert_process_node(pr_head, global_did, "memeater", false, NULL_CAP, disp_frame);
	global_did++;
	
	print_nodes(pr_head);	
	assert(err_is_ok(err));
*/

	debug_printf("Spawning mmchs!\n"); 
	struct spawninfo mem_si;
	struct capref disp_frame;

	err = bootstrap_domain("mmchs", &mem_si, bi, my_core_id, &disp_frame, global_did);

	pr_head = insert_process_node(pr_head, global_did, "mmchs", false, NULL_CAP, disp_frame);
	global_did++;

	while(true) {
		err = event_dispatch(get_default_waitset());
		if (err_is_fail(err)) {
			DEBUG_ERR(err, "in main event_dispatch loop");
			return EXIT_FAILURE;
		}		
	}

    return EXIT_SUCCESS;
}

