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

#define INPUT_BUF_SIZE 4096
#define MALLOC_BUFSIZE (1UL<<20)
#define BUFSIZE 32L * 1024 * 1024
#define SAFE_VADDR (1UL<<25)

#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)
#define CLIENT_LIMIT 			(1<<26)*10			

#define BLUE "\033[1m\033[31m"
#define RESET "\033[0m"

struct bootinfo *bi;
static coreid_t my_core_id;
static struct lmp_chan channel ;
static struct serial_ring_buffer ring;


static errval_t spawn_setup_vspace(struct spawninfo *si)
{
    errval_t err;

    /* Create pagecn */
    si->pagecn_cap = (struct capref){.cnode = si->rootcn, .slot = ROOTCN_SLOT_PAGECN};
    err = cnode_create_raw(si->pagecn_cap, &si->pagecn, PAGE_CNODE_SLOTS, NULL);
    if (err_is_fail(err)) {
        return err_push(err, SPAWN_ERR_CREATE_PAGECN);
    }

    /* Init pagecn's slot allocator */

    // XXX: satisfy a peculiarity of the single_slot_alloc_init_raw API
    size_t bufsize = SINGLE_SLOT_ALLOC_BUFLEN(PAGE_CNODE_SLOTS);
    void *buf = malloc(bufsize);
    assert(buf != NULL);

    err = single_slot_alloc_init_raw(&si->pagecn_slot_alloc, si->pagecn_cap,
                                     si->pagecn, PAGE_CNODE_SLOTS,
                                     buf, bufsize);
    if (err_is_fail(err)) {
        return err_push(err, LIB_ERR_SINGLE_SLOT_ALLOC_INIT_RAW);
    }

    // Create root of pagetable
    err = si->pagecn_slot_alloc.a.alloc(&si->pagecn_slot_alloc.a, &si->vtree);
    if (err_is_fail(err)) {
        return err_push(err, LIB_ERR_SLOT_ALLOC);
    }

    // top-level table should always live in slot 0 of pagecn
    assert(si->vtree.slot == 0);

    err = vnode_create(si->vtree, ObjType_VNode_ARM_l1);
    if (err_is_fail(err)) {
         return err_push(err, SPAWN_ERR_CREATE_VNODE);
    }

    err = spawn_paging_init(si, si->vtree);
    if (err_is_fail(err)) {
        return err_push(err, SPAWN_ERR_VSPACE_INIT);
    }

    return SYS_ERR_OK;
}


/**
 * \brief Setup an initial cspace
 *
 * Create an initial cspace layout
 */
static errval_t spawn_setup_cspace(struct spawninfo *si)
{
    errval_t err;
    struct capref t1;

    /* Create root CNode */
    err = cnode_create(&si->rootcn_cap, &si->rootcn, DEFAULT_CNODE_SLOTS, NULL);
    if (err_is_fail(err)) {
        return err_push(err, SPAWN_ERR_CREATE_ROOTCN);
    }

    /* Create taskcn */
    err = cnode_create(&si->taskcn_cap, &si->taskcn, DEFAULT_CNODE_SLOTS, NULL);
    if (err_is_fail(err)) {
        return err_push(err, SPAWN_ERR_CREATE_TASKCN);
    }

    // Mint into rootcn setting the guard
    t1.cnode = si->rootcn;
    t1.slot  = ROOTCN_SLOT_TASKCN;
    err = cap_mint(t1, si->taskcn_cap, 0,
                   GUARD_REMAINDER(2 * DEFAULT_CNODE_BITS));
    if (err_is_fail(err)) {
        return err_push(err, SPAWN_ERR_MINT_TASKCN);
    }

    /* Create slot_alloc_cnode */
    t1.cnode = si->rootcn;
    t1.slot  = ROOTCN_SLOT_SLOT_ALLOC0;
    err = cnode_create_raw(t1, NULL, (1<<SLOT_ALLOC_CNODE_BITS), NULL);
    if (err_is_fail(err)) {
        return err_push(err, SPAWN_ERR_CREATE_SLOTALLOC_CNODE);
    }
    t1.cnode = si->rootcn;
    t1.slot  = ROOTCN_SLOT_SLOT_ALLOC1;
    err = cnode_create_raw(t1, NULL, (1<<SLOT_ALLOC_CNODE_BITS), NULL);
    if (err_is_fail(err)) {
        return err_push(err, SPAWN_ERR_CREATE_SLOTALLOC_CNODE);
    }
    t1.cnode = si->rootcn;
    t1.slot  = ROOTCN_SLOT_SLOT_ALLOC2;
    err = cnode_create_raw(t1, NULL, (1<<SLOT_ALLOC_CNODE_BITS), NULL);
    if (err_is_fail(err)) {
        return err_push(err, SPAWN_ERR_CREATE_SLOTALLOC_CNODE);
    }

	return SYS_ERR_OK;
}

static errval_t bootstrap_services(void) {

	errval_t err;

	struct spawninfo memeater_si;
	
	// Get the module!
	struct mem_region *module = multiboot_find_module(bi, NAME_MEMEATER);
	if (module == NULL) {
		debug_printf("could not find module!\n");
		abort();
		return SPAWN_ERR_FIND_MODULE;
	}

	// Lookup and map the elf image in our vspace!	
	lvaddr_t binary;
	size_t binary_size;
	err = spawn_map_module(module, &binary_size, &binary, NULL);
	if (err_is_fail(err)) {
		debug_printf("could locate and map the elf image!\n");
		abort();
		return SPAWN_ERR_ELF_MAP;
	}

	debug_printf("bootstrap_services: Binary size = %zu and virtual address of binary in init vspace = %p\n", binary_size, binary);
	
	// Initialize cspace of chiild
	err = spawn_setup_cspace(&memeater_si);
	if (err_is_fail(err)) {
		debug_printf("could not setup cspace!\n");
		abort();
		return SPAWN_ERR_SETUP_CSPACE;
	}

	// Set up vspace of the child 
	err = spawn_setup_vspace(&memeater_si);
	if (err_is_fail(err)) {
		debug_printf("could not set up vspace!\n");
		abort();
		return err_push(err, SPAWN_ERR_VSPACE_INIT);
	}

	debug_printf("bootstrap_services: Cspace and Vspace for child are set up!\n");

   	/* Load the image */
    genvaddr_t entry;
    void* arch_info;
    err = spawn_arch_load(&memeater_si, binary, binary_size, &entry, &arch_info);
    if (err_is_fail(err)) {
        return err_push(err, SPAWN_ERR_LOAD);
    }
				    

	return SYS_ERR_OK;
}

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
			
			size_t size_requested = msg.words[1];	
			struct capref returned_cap;

			debug_printf("recv_handler: Requested for size %d\n", size_requested );	
		
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

			serial_putstring(BLUE);

			char out_c = (char) msg.words[1];
			
			serial_putchar(out_c);

			serial_putstring(RESET);
			break;

		case AOS_RPC_GET_CHAR: ;
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
	
	err = bootstrap_services();
    
	while (1);

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

	initialize_ring(&ring);

	struct thread *serial_polling_thread = thread_create( poll_serial_thread, &ring);

	serial_polling_thread = serial_polling_thread;	
	//thread_join(serial_polling_thread, NULL) ;

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
	
	while(true) {
		err = event_dispatch(get_default_waitset());
		if (err_is_fail(err)) {
			DEBUG_ERR(err, "in main event_dispatch loop");
			return EXIT_FAILURE;
		}		
	}


   return EXIT_SUCCESS;
}
