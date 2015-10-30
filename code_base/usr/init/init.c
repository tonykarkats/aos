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

#define UNUSED(x) (x) = (x)

#define MALLOC_BUFSIZE (1UL<<20)
#define BUFSIZE 32L * 1024 * 1024
#define SAFE_VADDR (1UL<<25)

#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)

static uint32_t next_client = 0;
static struct capref client_endpoints[2048];
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
	
	//for (int i=0 ; i<message_length; i++) 
	//	debug_printf("msg->words[%d] = 0x%lx\n",i,msg.words[i]);	
	
	char message_string[msg.buf.msglen * 4];
	for (int i = 0; i<message_length; i++){
		uint32_t * word = (uint32_t *) (message_string + i*4);
		*word = msg.words[i];   
	}	
	
	if (message_length != 0) 
		debug_printf("recv_handler: String received : %s\n", message_string);
	
	// Bootstraping ...
	if (message_length == 0) {
		if (capref_is_null(cap)) 
			debug_printf("recv_handler: Client did not provided us a valid endpoint!\n");
		else {
			debug_printf("recv_handler: Will register client with client id = %d\n", next_client);
			client_endpoints[next_client] = cap;
			client_limits[next_client] = 0;
			lmp_ep_send1(cap, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, next_client);
			next_client++;
		}
	}
	else {		// Requesting memory
		client_id = msg.words[0];
		uint32_t size_requested = msg.words[1];	
		if 	


	}
	

	lmp_chan_register_recv(lc, get_default_waitset(),
			MKCLOSURE(recv_handler, arg));
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
