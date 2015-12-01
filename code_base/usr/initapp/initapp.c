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
#include <barrelfish/omap_uart.h>
#include <barrelfish/thread_sync.h>
#include <spawndomain/spawndomain.h>
#include <barrelfish/thread_sync.h>
#include <barrelfish/proc.h>
#include <barrelfish/boot.h>
#include <barrelfish/cross_core.h>

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

struct bootinfo *bi;
static coreid_t my_core_id;
struct serial_ring_buffer ring_b;
struct serial_capref_ring_buffer ring_c;
struct thread_cond char_cond;
struct thread_cond capref_cond;

struct process_node* pr_head;

int global_did = 1;


errval_t get_devframe(struct capref * ret, size_t * retlen, lpaddr_t start_addr, size_t length)
{
	*ret = cap_io; 
	*retlen = length;
	return SYS_ERR_OK;
}

static int cross_core_thread_1(void *arg) 
{
	errval_t err;

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

				debug_printf("Received spawn for domain %s with did %zu\n", message_string, spawned_domain);
			 		
				uint32_t util_word;
				struct spawninfo si;	
				struct capref disp_frame;	
				err = bootstrap_domain(message_string, &si, bi, my_core_id, &disp_frame, spawned_domain);
				if (err_is_fail(err)) {
					util_word = 0;	
				}
				else {
					util_word = 1;
				}
				
				struct ump_message returned_message;
				returned_message.type      = SPAWNED_PROCESS_RESPONSE;
				returned_message.util_word = util_word;

				write_to_core_0(returned_message);					
					
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

	lc->remote_cap = cap;

	int message_length = msg.buf.msglen;
	
	int string_length = message_length - 1;
	char message_string[32];
		
	uint32_t rpc_operation = msg.words[0];
	assert(message_length != 0);

	lmp_chan_register_recv(lc, get_default_waitset(),
			MKCLOSURE(recv_handler, arg));
	err = lmp_chan_alloc_recv_slot(lc);
	if (err_is_fail(err)) {
		DEBUG_ERR(err,"Failed in new receiving slot allocation!\n");
	}	

	//debug_printf("Entering switch!\n");	
	
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
	
			struct ump_message message_for_core_0;

			message_for_core_0.type = SERIAL_PUT_STRING;
			for (int i = 0 ; i < 8 ; i++) 
				message_for_core_0.words[i] = msg.words[i];
			
			write_to_core_0(message_for_core_0);
	
			cap_destroy(cap);
			break;

		case AOS_RPC_GET_RAM_CAP: ;// Request Ram Capability
			// debug_printf("recv_handler: AOS_RPC_GET_RAM_CAP from endpoint %d\n", cap.slot);
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
			
			struct ump_message message;
			message.type = SERIAL_PUT_CHAR;
			message.words[0] = out_c;
	
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
		case AOS_RPC_TERMINATING:;
			domainid_t exiting_did = msg.words[1];
			int exit_status = msg.words[2];

			struct ump_message returned_mess;
		
			returned_mess.type = SPAWNED_PROCESS_TERMINATED_RESPONSE;
			return_mess.util_word = exiting_did;
			return_mess.word[0] = exit_status;
			
			write_to_core_0(return_mess);

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


	debug_printf("Signaling core-0 that we are up!\n");
	map_aux_core_registers();
	void * buf;
	
	err = map_shared_frame(&buf, true);
	signal_core_0();
	
	cross_core_thread_1(NULL);
	
	struct ump_message t;
	t.type = SERIAL_PUT_CHAR;
	*(char *) t.words = 'c';

	write_to_core_0(t);
	write_to_core_0(t);
	write_to_core_0(t);
	write_to_core_0(t);
		
	strcpy((char *) t.words, "abc");
	t.type = SERIAL_PUT_STRING;
	write_to_core_0(t);	
	
	//while(1);	
	
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

	debug_printf("Entering main messaging loop...");	
	while(true) {
		err = event_dispatch(get_default_waitset());
		if (err_is_fail(err)) {
			DEBUG_ERR(err, "in main event_dispatch loop");
			return EXIT_FAILURE;
		}		
	}

    return EXIT_SUCCESS;
}

