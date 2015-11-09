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
#include <dev/omap/omap_uart_dev.h>
#include "omap_uart.h"

#define UNUSED(x) (x) = (x)

#define MALLOC_BUFSIZE (1UL<<20)
#define BUFSIZE 32L * 1024 * 1024
#define SAFE_VADDR (1UL<<25)

#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)
#define CLIENT_LIMIT 			(1<<26)*10			

static volatile lvaddr_t uart3_base;
static volatile lvaddr_t uart3_lsr;
static volatile lvaddr_t uart3_thr;
static volatile lvaddr_t uart3_fcr;
static volatile lvaddr_t uart3_ier;
static volatile lvaddr_t uart3_lcr;

void uart_initialize(lvaddr_t mapped_address){

	uart3_base = mapped_address;
	uart3_thr = mapped_address + 0x00;
	uart3_ier = mapped_address + 0x04;
	uart3_lsr = mapped_address + 0x14;
	uart3_fcr = mapped_address + 0x08;
	uart3_lcr = mapped_address + 0x0C;

	*(char *) uart3_ier = 0;
	*(char *) uart3_fcr = 0xf1;
	*(char *) uart3_lcr = 0x03;
}

void serial_putchar(char c) {

	if (c == '\n')
		serial_putchar('\r');

	while ((!(* (char * ) uart3_lsr )) & 0x20);

	*(char *)uart3_thr = c;
}

char serial_getchar(void) {

	while (!(* (char *) uart3_lsr & 0x01));

	return (char) *(char *) uart3_thr;
}

static char serial_input_buffer[4096];
static int buffer_head = 0;
static int buffer_tail = 0;

static int poll_serial(void) {

	while(1) {
		// TODO
	}	
}

struct bootinfo *bi;
static coreid_t my_core_id;
static struct lmp_chan channel ;

static void recv_handler(void *arg) 
{
		
	errval_t err;
	struct lmp_chan *lc = arg;
	struct lmp_recv_msg msg = LMP_RECV_MSG_INIT;
	struct capref cap;

//	debug_printf("recv_handler: Got a message from channel with local_ep = %d , remote_ep = %d\n", lc->local_cap.slot, lc->remote_cap.slot);

	err = lmp_chan_recv(lc, &msg, &cap);
	if (err_is_fail(err) && lmp_err_is_transient(err)) {
		lmp_chan_register_recv(lc,get_default_waitset(),
							MKCLOSURE(recv_handler, arg));
	}

	int message_length = msg.buf.msglen;
//	debug_printf("recv_handler: Received length = %d\n", message_length);	
	
//	for (int i=0 ; i<message_length; i++) 
//		debug_printf("msg->words[%d] = 0x%lx\n",i,msg.words[i]);	
	
	int string_length = message_length - 1;
	char message_string[string_length * 4];
		
	uint32_t rpc_operation = msg.words[0];
	assert(message_length != 0);
	
	if (!capref_is_null(cap))
		lc->remote_cap = cap;  

	switch (rpc_operation) {
		case AOS_RPC_SEND_STRING: ; // Send String
			for (int i = 0; i<string_length; i++){
				uint32_t * word = (uint32_t *) (message_string + i*4);
				*word = msg.words[i+1];   
			}	
//			debug_printf("recv_handler: String received : %s\n", message_string);
			break;
		case AOS_RPC_GET_RAM_CAP: ;// Request Ram Capability
			
			size_t size_requested = msg.words[1];	
			struct capref returned_cap;
			
			err = ram_alloc(&returned_cap, size_requested); 
			if (err_is_fail(err)) {
//				debug_printf("recv_handler: Failed to allocate ram capability for client\n");
				returned_cap = NULL_CAP;	
			}
				
			err = lmp_chan_send0(lc, LMP_SEND_FLAGS_DEFAULT, returned_cap);	 
		    if (err_is_fail(err))
				DEBUG_ERR(err, "recv_handler: Error in sending cap back to the client!\n");					
			break;
		case AOS_RPC_PUT_CHAR:
			// TODO
			break;
		case 
			// TODO
			break;
	}
	
	
	if (!capref_is_null(cap)) {
		err = lmp_chan_alloc_recv_slot(lc);
		if (err_is_fail(err)) {
			DEBUG_ERR(err,"Failed in new receiving slot allocation!\n");
		}	
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

	uint64_t size   = 0x1000;
	uint64_t offset = 0x8020000;
	void * vbuf;	
	err = paging_map_frame(get_current_paging_state(),&vbuf, 0x1000, cap_io, &offset, &size);
	if (err_is_fail(err)) {
		debug_printf("CAN not map dev frame");
		abort();
	}
	
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

//	char * uart_3_buf = (char *) vbuf;
//	uart_fifo  = uart_3_buf + 0x14;
//	uart_thres = uart_3_buf;
	
	uart_initialize((lvaddr_t)vbuf);

	//debug_printf("thres = %p , fifo = %p \n", uart_thres, uart_fifo);

	serial_putchar('C');
	serial_putchar('O');
	serial_putchar('C');
	serial_putchar('K');
	//serial_putchar('\r');	
	serial_putchar('\n');	
	while(1);

	// allocate slot for incoming capabilites
    // register receive handler 
    // go into messaging main loop


	while(true) {
		err = event_dispatch(get_default_waitset());
		if (err_is_fail(err)) {
			DEBUG_ERR(err, "in main event_dispatch loop");
			return EXIT_FAILURE;
		}		
	}


   return EXIT_SUCCESS;
}
