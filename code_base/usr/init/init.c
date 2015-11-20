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
#include "omap_uart.h"
#include <barrelfish/thread_sync.h>
#include <spawndomain/spawndomain.h>
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
static struct lmp_chan channel ;
static struct serial_ring_buffer ring;


static errval_t bootstrap_domain(char *name, struct spawninfo *domain_si)
{
	errval_t err;
	char prefix[12] = "armv7/sbin/";	

	char * module_name = strcat(prefix, name);
	
	err = spawn_load_with_bootinfo(domain_si, bi, module_name, my_core_id);
	if (err_is_fail(err)) {
		debug_printf("spawn_load_with_bootinfo: ERROR!\n");
		return err;
	}

	err = spawn_run(domain_si);
	if (err_is_fail(err)) {
		debug_printf("bootstrap_domain: Error in spawn run!\n");
		return err;
	}

	err = spawn_free(domain_si);
	
	return SYS_ERR_OK;
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

	lc->remote_cap = cap;

	int message_length = msg.buf.msglen;
	
	int string_length = message_length - 1;
	char message_string[string_length * 4];
		
	uint32_t rpc_operation = msg.words[0];
	assert(message_length != 0);

	lmp_chan_register_recv(lc, get_default_waitset(),
			MKCLOSURE(recv_handler, arg));
	err = lmp_chan_alloc_recv_slot(lc);
	if (err_is_fail(err)) {
		DEBUG_ERR(err,"Failed in new receiving slot allocation!\n");
	}	
	

	switch (rpc_operation) {
		case AOS_RPC_SEND_STRING: ; // Send String
			// debug_printf("recv_handler: AOS_RPC_SEND_STRING from endpoint %d\n", cap.slot);
			serial_putstring(BLUE);
	
			for (int i = 0; i<string_length; i++){
				uint32_t * word = (uint32_t *) (message_string + i*4);
				*word = msg.words[i+1];   
			}	
			
			serial_putstring(message_string);
	
		    // debug_printf("Message string = %s\n", message_string);	
			err = lmp_chan_send0(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP);
			if (err_is_fail(err))
				DEBUG_ERR(err,"recv_handler: Error in sending acknowledgment of send string back to client!\n");	
			
			serial_putstring(RESET);
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
				
			err = lmp_chan_send0(lc, LMP_SEND_FLAGS_DEFAULT, returned_cap);	 
		    if (err_is_fail(err))
				DEBUG_ERR(err, "recv_handler: Error in sending cap back to the client!\n");					
			break;

		case AOS_RPC_PUT_CHAR: ;
			// debug_printf("recv_handler: AOS_RPC_PUT_CHAR from endpoint %d\n", cap.slot);
			serial_putstring(BLUE);

			char out_c = (char) msg.words[1];
			
			serial_putchar(out_c);

			serial_putstring(RESET);
			break;

		case AOS_RPC_GET_CHAR: ;
			// debug_printf("recv_handler: AOS_RPC_GET_CHAR from endpoint %d\n", lc->remote_cap.slot);
			serial_putstring(BLUE);

			char in_c;
			while(1) {
				char * ret_char = read_from_ring(&ring, &in_c);
				if (ret_char != NULL)
					break;
			}
				
			if (in_c != 13)
				serial_putchar(in_c);
			else { 
				serial_putchar('\n');
				in_c = '\n';
			}
				
			err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, in_c);
			if (err_is_fail(err)) {
				DEBUG_ERR(err,"recv_handler: Can not send character back to client!\n");
			}	

			serial_putstring(RESET); 
			break;
		case AOS_RPC_PROC_SPAWN:;
			domainid_t d_id;
			
			for (int i = 0; i<string_length; i++){
				uint32_t * word = (uint32_t *) (message_string + i*4);
				*word = msg.words[i+1];   
			}	
				
			// debug_printf("recv_handler: Received request for spawn for elf32 %s\n", message_string);
		
		 	struct spawninfo si;	
			err = bootstrap_domain(message_string, &si);
			if (err_is_fail(err)) {
				debug_printf("recv_handler: Can not spawn process for the client! \n");
				d_id = -1;	
			}
			else 
				d_id = si.domain_id;

			 debug_printf("recv_handler: Spawned domain with id %zu!\n", si.domain_id);
			
			lc = &channel;
			err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, d_id);
			if (err_is_fail(err)) {
				DEBUG_ERR(err,"recv_handler: Can not send domain id back to the client!\n");
			}		
	
			break;
		case AOS_RPC_PROC_GET_NAME:;
			break;
		case AOS_RPC_PROC_GET_PIDS:
			;
			break;
	}
}

static errval_t setup_channel(void) {

	errval_t err;
	struct waitset* ws = get_default_waitset();  	
	
	lmp_chan_init(&channel);
	
	// Create our endpoint to self
	err = cap_retype(cap_selfep, cap_dispatcher, ObjType_EndPoint, 0);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Failed to create our endpoint to self");
		abort();
	}

	endpoint_create(FIRSTEP_BUFLEN, &channel.local_cap, 
					&channel.endpoint);
	if (err_is_fail(err)) {
		debug_printf("Error in creating endpoint!\n");
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

	err = cap_copy(cap_initep, channel.local_cap);
	if (err_is_fail(err)) {
		debug_printf("Error in copying endpoint to cap_initep\n");	
		abort();
	}
		
	return SYS_ERR_OK;	
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
	
	debug_printf("initialized dev memory management\n");

	uint64_t size   = 0x1000;
	uint64_t offset = 0x8020000;
	void * vbuf;	
	err = paging_map_frame(get_current_paging_state(),&vbuf, 0x1000, cap_io, &offset, &size);
	if (err_is_fail(err)) {
		debug_printf("CAN not map dev frame");
		abort();
	}

	uart_initialize((lvaddr_t)vbuf);
	debug_printf("initialized uart!\n");

	initialize_ring(&ring);

	struct thread *serial_polling_thread = thread_create( poll_serial_thread, &ring);
	serial_polling_thread = serial_polling_thread;

	err = setup_channel();
   	assert(err_is_ok(err));


	debug_printf("Spawning memeater!\n"); 
	struct spawninfo mem_si;
	err = bootstrap_domain("memeater", &mem_si);
	assert(err_is_ok(err));

	
	//debug_printf("Spawning led_on!\n");
	//struct spawninfo l_si;
	//err = bootstrap_domain("led_on", &l_si);
	//assert(err_is_ok(err));
	
	//debug_printf("Spawning led_off\n");
	//struct spawninfo loff_si;
	//err = bootstrap_domain("led_off", &loff_si);
	//assert(err_is_ok(err));
	
	//err = spawn_run(&mem_si);	
	//err = spawn_run(&l_si);	
	//err = spawn_run(&loff_si);	

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

