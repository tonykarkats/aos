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
#include "initapp.h"
#include <stdlib.h>
#include <string.h>
#include <barrelfish/morecore.h>
#include <barrelfish/dispatcher_arch.h>
#include <barrelfish/debug.h>
#include <barrelfish/lmp_chan.h>
#include <barrelfish/sys_debug.h>
#include <math.h>
#include <barrelfish/aos_rpc.h>
#include <barrelfish/thread_sync.h>
#include <spawndomain/spawndomain.h>
#include <barrelfish/thread_sync.h>
#include <barrelfish/proc.h>
#include <barrelfish/boot.h>
#include <barrelfish/cross_core.h>
#include "../../lib/spawndomain/arch.h"
#include <elf/elf.h>
#include <mm/mm.h>

#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)

static volatile int pseudo_lock;
static struct mm dev_mm;
extern struct mm mm_ram;

struct thread_mutex process_list_lock;

struct bootinfo *bi;
static coreid_t my_core_id;
struct thread_cond char_cond;
struct thread_cond capref_cond;
struct process_node* pr_head;
int global_did = 1;

errval_t get_devframe(struct capref * ret, size_t * retlen, lpaddr_t start_addr, size_t length)
{
	errval_t err;

	err = mm_realloc_range( &dev_mm, length, start_addr,ret);
	if (err_is_fail(err)) {
		debug_printf("get_dev_frame: can not allocate range for device!\n");
		return MM_ERR_DEVICE_ALLOC;
	}

	*retlen = ((0x80000000 - start_addr) < length) ? (0x80000000 - start_addr) : length;

	assert(err_is_ok(err));
	
	return SYS_ERR_OK;
}

static int cross_core_thread_1(void *arg) 
{
	errval_t err;

	struct bootinfo * thread_bi = (struct bootinfo *) arg;

	void * buf;
	err = map_shared_frame(&buf, true);

	// Main loop of cross-core thread!	
	while(1) 
	{

		struct ump_message received_message = read_from_core_1();
		
		int type = received_message.type;
		
		switch(type) {
			case(SPAWNED_PROCESS_REQUEST): ;

				char message_string[36];

				for (int i = 0; i<9; i++){
					uint32_t * word = (uint32_t *) (message_string + i*4);
					*word = received_message.words[i];   
				}		
				
				domainid_t spawned_domain = received_message.util_word;

				//debug_printf("cross_core_thread_1: Received spawn for domain %s with did %zu\n", message_string, spawned_domain);
			 		
				uint32_t util_word;
				struct spawninfo si;	
				struct capref disp_frame;	

				thread_mutex_lock(&process_list_lock);	
				pr_head = insert_process_node(pr_head, spawned_domain, message_string, 0, NULL_CAP, NULL_CAP);
				thread_mutex_unlock(&process_list_lock);	
			
				err = bootstrap_domain(message_string, &si, thread_bi, my_core_id, &disp_frame, spawned_domain);
				if (err_is_fail(err)) {
					
					thread_mutex_lock(&process_list_lock);	
					struct process_node * temp = delete_process_node( &pr_head, spawned_domain, "aaa");
					thread_mutex_unlock(&process_list_lock);		
					temp = temp;

					util_word = 0;	
				}
				else {
					util_word = spawned_domain;
				}
			
				// Write response to core-0 !				
				struct ump_message returned_message;
				returned_message.type      = SPAWNED_PROCESS_RESPONSE;
				returned_message.util_word = util_word;
				strcpy( (char *) returned_message.words, message_string);
				
				write_to_core_0(returned_message);					
				break;
		
		case(SPAWNED_PROCESS_RESPONSE_PERMISSION_FOR_SPAWN): ;
			
				int permission = received_message.util_word;
				
				pseudo_lock = permission;
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

	//debug_printf("recv_handler initiating!\n");

	err = lmp_chan_recv(lc, &msg, &cap);
	if (err_is_fail(err) && lmp_err_is_transient(err)) {
		lmp_chan_register_recv(lc,get_default_waitset(),
							MKCLOSURE(recv_handler, arg));
	}

	lmp_chan_register_recv(lc, get_default_waitset(),
			MKCLOSURE(recv_handler, arg));
	err = lmp_chan_alloc_recv_slot(lc);
	if (err_is_fail(err)) {
		DEBUG_ERR(err,"Failed in new receiving slot allocation!\n");
	}	

	lc->remote_cap = cap;

	// msg.words[0][24-31] holds the rpc operation, msg.words[0][0-24] holds the domain-id from the process talking to us
	// init channel only has channel that all the clients communicate with. Each client is a domain and for each operation
	// transmits each domain-id as mentioned before. The servers (only init in our implementation) hold a list of domains
	// talking to them (process list in our implementation) that keeps all book keeping information regarding the processes.
	char message_string[38];	
	uint32_t rpc_operation = msg.words[0] >> 24;
	uint32_t domain_id = msg.words[0] & 0x00FFFFFF;
	
	switch (rpc_operation) {
		case AOS_RPC_GET_DID: ;
				
			strncpy(message_string, (char *) msg.words + 4, 32);	
			// debug_printf("Domain with name %s requested its id!\n", message_string); 
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
			struct process_node * process = get_process_node(&pr_head, requested_did, "aa");
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
		
			strncpy( message_string, (char *) msg.words + 4, 32);	

			//debug_printf("Will send string message_string %s to core-0", message_string);
			struct ump_message message_for_core_0;
			strcpy((char *) message_for_core_0.words, message_string);
			
			message_for_core_0.type = SERIAL_PUT_STRING;
		
			// Using cross core channel for writing characters and strings through UART
			write_to_core_0(message_for_core_0);
	
			cap_destroy(cap);
			break;

		case AOS_RPC_GET_RAM_CAP: ;// Request Ram Capability
			size_t size_requested = msg.words[1];	
			struct capref returned_cap;
	
			// debug_printf("Request for memory from client with %"PRIu32"\n", domain_id);
			// Check if client has exceeded it's memory limit
			// and keep track of the frames allocated from this client.
			thread_mutex_lock(&process_list_lock);	
			process = get_process_node(&pr_head, domain_id, "aa");
			if ((process->memory_consumed + pow(2, size_requested)) > CLIENT_MEMORY_LIMIT) {
				// Client has exceeded its memory limit do not give more memory.
				returned_cap = NULL_CAP;
			}
			else {
				// Allocate memory for the client and keep the frame...
				process->memory_consumed += pow(2, size_requested);
				err = ram_alloc(&returned_cap, size_requested); 
				if (err_is_fail(err)) {
					debug_printf("recv_handler: Failed to allocate ram capability for client\n");
					returned_cap = NULL_CAP;	
				}
					
				//update_frame_list(process, returned_cap, size_requested);	
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
			
			struct ump_message message;
			message.type = SERIAL_PUT_CHAR;
			message.words[0] = out_c;

			// Using cross core channel for writhing characters through UART
			write_to_core_0(message);

			cap_destroy(cap);
			break;

		case AOS_RPC_GET_DEV_CAP:;
			 // debug_printf("recv_handler: Received request for device! \n");		

			lpaddr_t paddr = msg.words[1];
			size_t length = msg.words[2];
			
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
		case AOS_RPC_PROC_SPAWN:;
			
			strncpy(message_string, (char *) msg.words + 8, 28);

			debug_printf("Received request for spawn for %s\n", message_string);
			uint32_t core = msg.words[1];
			if (core != 1) {
				// Domains at core-1 are not allowed to spawn domains at core-0!
				err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, 0);
				if (err_is_fail(err)) {
					DEBUG_ERR(err,"recv_handler: Can not send domain id back to the client!\n");
				}
			}
			else {
				struct ump_message request_for_spawn;
				request_for_spawn.type = SPAWNED_PROCESS_REQUEST_PERMISSION_FOR_SPAWN;
				strcpy( (char *) request_for_spawn.words, message_string);

				write_to_core_0( request_for_spawn);
				
				pseudo_lock = -1;

				while(pseudo_lock == -1) ;				
				
				if (pseudo_lock == 0) {
					// Remote core rejected our request for spawning!
					err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, 0);
					if (err_is_fail(err)) {
						DEBUG_ERR(err,"recv_handler: Can not send domain id back to the client!\n");
					}
				}
				else {
					// Remote core accepted our request for spawning! Value of pseudo_lock is the returned domain-id
					debug_printf("Core-0 responded with did %zu\n", pseudo_lock);
					uint32_t util_word;
					struct spawninfo si;	
					struct capref disp_frame;	

					thread_mutex_lock(&process_list_lock);	
					pr_head = insert_process_node(pr_head, pseudo_lock, message_string, 0, cap, NULL_CAP);
					thread_mutex_unlock(&process_list_lock);	
					
					err = bootstrap_domain(message_string, &si, bi, my_core_id, &disp_frame, pseudo_lock);
					if (err_is_fail(err)) {
						
						thread_mutex_lock(&process_list_lock);	
						struct process_node * temp = delete_process_node( &pr_head, pseudo_lock, "aaa");
						thread_mutex_unlock(&process_list_lock);		
						temp = temp;

						util_word = 0;	
					}
					else {
						util_word = pseudo_lock;
					}
			
					// Write response to core-0 !				
					struct ump_message returned_message;
					returned_message.type      = SPAWNED_PROCESS_RESPONSE;
					returned_message.util_word = util_word;
					strcpy( (char *) returned_message.words, message_string);
				
					write_to_core_0(returned_message);					

					err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, util_word);
					if (err_is_fail(err)) {
						DEBUG_ERR(err,"recv_handler: Can not send domain id back to the client!\n");
					}
			
				}
				
			}
			
			break;
		case AOS_RPC_TERMINATING:;
			domainid_t exiting_did = msg.words[1];
			int exit_status = msg.words[2];
					
				
			thread_mutex_lock(&process_list_lock);	
			struct process_node * terminated_process = delete_process_node(&pr_head, exiting_did, "aa");
			thread_mutex_unlock(&process_list_lock);	
			
			if (terminated_process == NULL) {
				debug_printf("recv_handler: Received message from unknown process?!\n");
				break;
			}

			// Clears the process node and released the ram used
			// by this child. 
			// clear_process_node(terminated_process, mm_ram);
			free(terminated_process);
	
			// Inform core-0 that a process terminated ! 
			struct ump_message returned_mess;	
			returned_mess.type = SPAWNED_PROCESS_TERMINATED_RESPONSE;
			returned_mess.util_word = exiting_did;
			returned_mess.words[0] = exit_status;
			write_to_core_0(returned_mess);

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


	debug_printf("Mapping aux core registers and signaling core-0 that we are up!\n");

	void *vbuf;	
	struct capref temp_cap;
	size_t retlen;
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
	signal_core_0(aux_core_0);


	thread_mutex_init( &process_list_lock);
	struct thread *cross_core_thread = thread_create( cross_core_thread_1, bi);
	cross_core_thread = cross_core_thread;

	err = setup_channel(&channel);
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

