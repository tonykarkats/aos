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
#include <barrelfish/thread_sync.h>
#include "proc.h"

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
	uint32_t buffer[38];
	
	switch (rpc_operation) {
		case AOS_RPC_SEND_STRING: ; // Send String
			// debug_printf("recv_handler: AOS_RPC_SEND_STRING from endpoint %d\n", cap.slot);
	
			for (int i = 0; i<string_length; i++){
				uint32_t * word = (uint32_t *) (message_string + i*4);
				*word = msg.words[i+1];   
			}	
			
			serial_putstring(message_string);
	
		    // debug_printf("Message string = %s\n", message_string);	
			err = lmp_chan_send0(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP);
			if (err_is_fail(err))
				DEBUG_ERR(err,"recv_handler: Error in sending acknowledgment of send string back to client!\n");	
			
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

			for (int i = 0; i<string_length; i++){
				uint32_t * word = (uint32_t *) (message_string + i*4);
				*word = msg.words[i+1];   
			}	
				
			token = strtok(message_string, " ");
			next_token = strtok(NULL, " ");
				
			if (next_token == NULL)
				background = false;
			else if (strcmp(next_token, "&"))
				background = false;
			else 
				background = true;
			
		 	struct spawninfo si;	
			struct capref disp_frame;
			
			err = bootstrap_domain(token, &si, bi, my_core_id, &disp_frame);
			if (err_is_fail(err)) {
				debug_printf("recv_handler: Can not spawn process for the client! \n");
				debug_printf("address of lc = %p\n", &lc);
				d_id = 0;	
			}
			else {
				debug_printf("token %s address\n", token);
				d_id = global_did;
				global_did++;
				pr_head = insert_process_node(pr_head, d_id, token, background, cap, disp_frame);
			}
				
			err = lmp_chan_send1(lc, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, d_id);
			if (err_is_fail(err)) {
				DEBUG_ERR(err,"recv_handler: Can not send domain id back to the client!\n");
			}		

			//debug_printf("recv_handler: Id sent back to the client!\n");
			// TODO why cap_destroy issues page fault?
			//cap_destroy(cap);
			break;
		case AOS_RPC_PROC_GET_NAME:;
			
			//debug_printf("recv_handler: Request for domain name with d_Id = %d\n", msg.words[1]);
			domainid_t did = msg.words[1];
			char * d_name;

			d_name = get_name_by_did (pr_head, did);
			if (d_name == NULL) {
				memcpy( buffer, "Not Found!", 11);
			}
			else if (strlen(d_name) > 39) {
				memcpy( buffer, d_name, 39);
				* (char *) (buffer + 35) = '\0';
			}
			else 
				memcpy(buffer, d_name, strlen(d_name));

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
			for (int i = 0; i<string_length; i++){
				uint32_t * word = (uint32_t *) (message_string + i*4);
				*word = msg.words[i+1];   
			}	
	
			char name[32];	
			strcpy(name, message_string + 11); 	
				
			struct process_node * terminated_process = delete_process_node(&pr_head, 0, name);
			if (terminated_process == NULL) {
				debug_printf("recv_handler: Received message from unknown process?!\n");
				return;
			}

			err = lmp_ep_send1(terminated_process->client_endpoint, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, terminated_process->d_id);
			if (err_is_fail(err)) {
				DEBUG_ERR(err,"recv_handler: Can not send domain id back to the client!\n");
			}	

			cap_destroy(terminated_process->client_endpoint);
			cap_destroy(terminated_process->dispatcher_frame);
			break;
		case AOS_RPC_KILL:;
			debug_printf("Terminating node with pid = %d\n", msg.words[1]);

			struct process_node * killed_process = delete_process_node(&pr_head, msg.words[1], "");
			if (killed_process == NULL) {
				debug_printf("Process to kill does not exist!\n");
				return;
			}
			
			err = cap_revoke(killed_process->dispatcher_frame);	
			if (err_is_fail(err)) {
				debug_printf("recv_handler: Can not kill process!\n");
				return ;
			}
		
			err = cap_delete(killed_process->dispatcher_frame);	
			if (err_is_fail(err)) {
				debug_printf("recv_handler: Can not destroy capability of domain...!\n");
				return ;
			}

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

	//pr_head = insert_process_node(pr_head, 1,"test1", 1, NULL_CAP, NULL_CAP);
	//pr_head = insert_process_node(pr_head, 2,"test2", 1, NULL_CAP, NULL_CAP);
	//pr_head = insert_process_node(pr_head, 3,"test3", 1, NULL_CAP, NULL_CAP);
	//pr_head = insert_process_node(pr_head, 4,"test4", 1, NULL_CAP, NULL_CAP);

	uint64_t size   = 0x1000;
	uint64_t offset = 0x8020000;
	void * vbuf;	
	err = paging_map_frame(get_current_paging_state(),&vbuf, size, cap_io, &offset, &size);
	if (err_is_fail(err)) {
		debug_printf("CAN not map dev frame");
		abort();
	}

	uart_initialize((lvaddr_t)vbuf);
	debug_printf("initialized uart!\n");

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
	debug_printf("Spawning led_on!\n");
	struct capref disp_frame; 
	struct spawninfo led_si;
	err = bootstrap_domain("led_on", &led_si, bi, my_core_id, &disp_frame);
	assert(err_is_ok(err));
*/
	debug_printf("Spawning memeater!\n"); 
	struct spawninfo mem_si;
	struct capref disp_frame;
	err = bootstrap_domain("memeater", &mem_si, bi, my_core_id, &disp_frame);
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

