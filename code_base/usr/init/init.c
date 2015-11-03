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
#define UNUSED(x) (x) = (x)

#define MALLOC_BUFSIZE (1UL<<20)
#define BUFSIZE 32L * 1024 * 1024
#define SAFE_VADDR (1UL<<25)

#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)
#define CLIENT_LIMIT 			(1<<26)*10			


static uint32_t next_client = 0;
static struct lmp_chan client_channels[2048];
struct bootinfo *bi;
static coreid_t my_core_id;
static struct lmp_chan channel ;
static size_t client_limits[2048];

static void recv_handler(void *arg) 
{
	debug_printf("recv_handler: Got a message!\n");
		
	errval_t err;
	struct lmp_chan *lc = arg;
	struct lmp_recv_msg msg = LMP_RECV_MSG_INIT;
	struct capref cap;
	
	err = lmp_chan_recv(lc, &msg, &cap);
	if (err_is_fail(err) && lmp_err_is_transient(err)) {
		lmp_chan_register_recv(lc,get_default_waitset(),
							MKCLOSURE(recv_handler, arg));
	}

	int message_length = msg.buf.msglen;
	debug_printf("recv_handler: Received length = %d\n", message_length);	
	
//	for (int i=0 ; i<message_length; i++) 
//		debug_printf("msg->words[%d] = 0x%lx\n",i,msg.words[i]);	

	//Make Sure that a valid operation was requested
	assert(message_length != 0);
	
	int string_length = message_length - 1;
	char message_string[string_length * 4];

	switch (msg.words[0]) {
		case 0: // Connect
			if (capref_is_null(cap)) 
				debug_printf("recv_handler: Client did not provided us a valid endpoint!\n");
			else {
				debug_printf("recv_handler: Will register client with client id = %d and slot in cap = %d\n", next_client, cap.slot);
				lmp_chan_init(client_channels + next_client);
				client_channels[next_client].remote_cap = cap;
				client_limits[next_client] = 0;
				lmp_chan_send1(client_channels + next_client , LMP_SEND_FLAGS_DEFAULT, NULL_CAP, next_client);
				next_client++;
				}
			break;
		case 1: ; // Send String
			for (int i = 0; i<string_length; i++){
				uint32_t * word = (uint32_t *) (message_string + i*4);
				*word = msg.words[i+1];   
			}	
			debug_printf("recv_handler: String received : %s\n", message_string);
			break;
		case 2: ;// Request Ram Capability
			uint32_t client_id = msg.words[1];
			struct lmp_chan client_channel = client_channels[client_id];
			size_t size_requested = msg.words[2];	
			struct capref returned_cap;
		
			if (pow(2,size_requested) + client_limits[client_id] > CLIENT_LIMIT) {
				debug_printf("recv_handle: Client with id =%d exceeded its available limit!\n", client_id);		
				returned_cap = NULL_CAP;			
			}
			else {
				err = ram_alloc(&returned_cap, size_requested); 
				if (err_is_fail(err)) {
					returned_cap = NULL_CAP;	
				}
			}
			
			err = lmp_chan_send0(&client_channel, LMP_SEND_FLAGS_DEFAULT, returned_cap);	 
		    if (err_is_fail(err))
				DEBUG_ERR(err, "recv_handler: Error in sending cap back to the client!\n");					
			break;
	}
	
	lmp_chan_register_recv(lc, get_default_waitset(),
			MKCLOSURE(recv_handler, arg));
	
	err = lmp_chan_alloc_recv_slot(lc);
	if (err_is_fail(err)) {
		DEBUG_ERR(err,"Failed in new receiving slot allocation!\n");
	}	
}


int main(int argc, char *argv[])
{
    errval_t err;

    /* Set the core id in the disp_priv struct */
    err = invoke_kernel_get_core_id(cap_kernel, &my_core_id);
    assert(err_is_ok(err));
    disp_set_core_id(my_core_id);

    debug_printf("init: invoked as:");
    for (int i = 0; i < argc; i++) {
       printf(" %s", argv[i]);
    }
    printf("\n");

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
    
	// TODO (milestone 4): Implement a system to manage the device memory
    // that's referenced by the capability in TASKCN_SLOT_IO in the task
    // cnode. Additionally, export the functionality of that system to other
    // domains by implementing the rpc call `aos_rpc_get_dev_cap()'.
    debug_printf("initialized dev memory management\n");

    // TODO (milestone 3) STEP 2:
    // get waitseti --> get_default_waitset()
    // allocate lmp chan --> 
    // init lmp chan --> lmp_chan_init
    /* make local endpoint available -- this was minted in the kernel in a way
     * such that the buffer is directly after the dispatcher struct and the
     * buffer length corresponds DEFAULT_LMP_BUF_WORDS (excluding the kernel 
     * sentinel word).
     */
	struct waitset* ws = get_default_waitset();  	
	
	lmp_chan_init(&channel);
	
	channel.local_cap =  cap_initep;
	
	err = lmp_endpoint_setup(0, DEFAULT_LMP_BUF_WORDS,  &channel.endpoint);
	if (err_is_fail(err)) {
		debug_printf("Error in seting up the endpoint..\n");	
		abort();
	}

	err = lmp_chan_alloc_recv_slot(&channel);
	if (err_is_fail(err)) {
		debug_printf("Error in allocating receiver slot!\n");
		abort();
	}

	struct event_closure recv_handler_init = {
        .handler = recv_handler,
        .arg = &channel,
    };

	err = lmp_chan_register_recv(&channel,ws, recv_handler_init);
	if (err_is_fail(err)) {
		debug_printf("Error in registering the channel..\n");	
		abort();
	}
	
	// allocate slot for incoming capabilites
    // register receive handler 
    // go into messaging main loop
 	debug_printf("Entering main messaging loop...\n");	
	while(true) {
		err = event_dispatch(get_default_waitset());
		if (err_is_fail(err)) {
			DEBUG_ERR(err, "in main event_dispatch loop");
			return EXIT_FAILURE;
		}		
	}


   return EXIT_SUCCESS;
}
