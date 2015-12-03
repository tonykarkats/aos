/**
 * \file
 * \brief Barrelfish library initialization.
 */

/*
 * Copyright (c) 2007, 2008, 2009, 2010, 2011, 2012, 2013 ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#include <stdio.h>
#include <barrelfish/barrelfish.h>
#include <barrelfish/idc.h>
#include <barrelfish/dispatch.h>
#include <barrelfish/curdispatcher_arch.h>
#include <barrelfish/dispatcher_arch.h>
#include <barrelfish_kpi/dispatcher_shared.h>
#include <barrelfish/morecore.h>
#include <barrelfish/monitor_client.h>
#include <barrelfish/nameservice_client.h>
#include <barrelfish/paging.h>
#include <barrelfish_kpi/domain_params.h>
#include <if/monitor_defs.h>
#include <trace/trace.h>
#include <octopus/init.h>
#include "threads_priv.h"
#include "init.h"
#include <barrelfish/aos_rpc.h>
#include <barrelfish/misc.h>
/// Are we the init domain (and thus need to take some special paths)?

static char domain_name[32];
static bool init_domain;

extern size_t (*_libc_terminal_read_func)(char *, size_t);
extern size_t (*_libc_terminal_write_func)(const char *, size_t);
extern void (*_libc_exit_func)(int);
extern void (*_libc_assert_func)(const char *, const char *, const char *, int);

void libc_exit(int);

void libc_exit(int status)
{
	errval_t err;

    // Use spawnd if spawned through spawnd
	// debug_printf("libc_exit: Process exiting!\n");
	err = aos_rpc_terminating(get_init_chan(), disp_get_domain_id(), status);
	if (err_is_fail(err)) {
		sys_print("sending terminating signal to parent failed!\n", 100);
	}
	
	err = cap_revoke(cap_dispatcher);
    if (err_is_fail(err)) {
        sys_print("revoking dispatcher failed in _Exit, spinning!", 100);
        while (1) {}
    }
  
    err = cap_delete(cap_dispatcher);
    sys_print("deleting dispatcher failed in _Exit, spinning!", 100);


    // If we're not dead by now, we wait
    while (1) {}
}

static void libc_assert(const char *expression, const char *file,
                        const char *function, int line)
{
    char buf[512];
    size_t len;

    /* Formatting as per suggestion in C99 spec 7.2.1.1 */
    len = snprintf(buf, sizeof(buf), "Assertion failed on core %d in %.*s: %s,"
                   " function %s, file %s, line %d.\n",
                   disp_get_core_id(), DISP_NAME_LEN,
                   disp_name(), expression, function, file, line);
    sys_print(buf, len < sizeof(buf) ? len : sizeof(buf));
}
static size_t custom_printf(const char *buf, int len) {

	errval_t err;
    //size_t printed = 0;
	char new_buf[len+1];	

	memcpy(new_buf, buf, len);
	
	new_buf[len] = '\0';
	
	struct aos_rpc * init_chan = get_init_chan();
  	
	err = aos_rpc_send_string( init_chan, new_buf);
	if (err_is_fail(err)) 
		debug_printf("Error in custom printf in sending string to serial driver!\n");
	
	
	//for (int i = 0; i < len; i++)
	//	err = aos_rpc_putchar( init_chan, buf[i]);
	

	return len;	
	//return printed;
}

static size_t custom_scanf(char *buf, size_t len) {

	errval_t err;

	struct aos_rpc * init_chan = get_init_chan();

		
 	err = aos_rpc_serial_getchar( init_chan, buf);
	if (err_is_fail(err)) {
		debug_printf("Error in custom scanf!\n");
 		return 0;
	}
	else 
		return 1;
}


static size_t user_space_driver_write(const char *buf, size_t len) {

	if (len) {
		return custom_printf(buf, len);		
	}

	return 0;
}

static size_t user_space_driver_read(char *buf, size_t len) {
	
	if (len) {
		return custom_scanf(buf, len);
	}

	return 0;
}

/*
static size_t syscall_terminal_write(const char *buf, size_t len)
{
    if (len) {
        return sys_print(buf, len);
    }
    return 0;
}

static size_t dummy_terminal_read(char *buf, size_t len)
{
    debug_printf("terminal read NYI! returning %d characters read\n", len);
    return len;
}
*/

/* Set libc function pointers */
void barrelfish_libc_glue_init(void)
{
    // TODO: change these to use the user-space serial driver if possible
    _libc_terminal_read_func = user_space_driver_read;
	_libc_terminal_write_func = user_space_driver_write;
    _libc_exit_func = libc_exit;
    _libc_assert_func = libc_assert;
    
	/* morecore func is setup by morecore_init() */

    // XXX: set a static buffer for stdout
    // this avoids an implicit call to malloc() on the first printf
    static char buf[BUFSIZ];
    setvbuf(stdout, buf, _IOLBF, sizeof(buf));
    static char ebuf[BUFSIZ];
    setvbuf(stderr, ebuf, _IOLBF, sizeof(buf));
}

#if 0
static bool register_w_init_done = false;
static void init_recv_handler(struct aos_chan *ac, struct lmp_recv_msg *msg, struct capref cap)
{
    assert(ac == get_init_chan());
    debug_printf("in libbf init_recv_handler\n");
    register_w_init_done = true;
}
#endif

/** \brief Initialise libbarrelfish.
 *
 * This runs on a thread in every domain, after the dispatcher is setup but
 * before main() runs.
 */

errval_t barrelfish_init_onthread(struct spawn_domain_params *params)
{
    errval_t err;

	// do we have an environment?
    if (params != NULL && params->envp[0] != NULL) {
        extern char **environ;
        environ = params->envp;
    }

	// Get domain name from arguments
	//char * token;
	//char * token_2;
	strcpy(domain_name, params->argv[0]);

    // Init default waitset for this dispatcher
    struct waitset *default_ws = get_default_waitset();
    waitset_init(default_ws);

    // Initialize ram_alloc state
	
	// debug_printf("barrelfish_init_onthread: Setting up fixed ram allocator!\n");
	ram_alloc_init();

    /* All domains use smallcn to initialize */
    err = ram_alloc_set(ram_alloc_fixed);
    if (err_is_fail(err)) {
        return err_push(err, LIB_ERR_RAM_ALLOC_SET);
    }

	// debug_printf("barrelfish_init_onthread: Setting up slot allocator!\n");
    err = slot_alloc_init();
    if (err_is_fail(err)) {
        return err_push(err, LIB_ERR_SLOT_ALLOC_INIT);
    }

    // debug_printf("barrelfish_init_onthread: Initializing our paging!\n");
	err = paging_init();
   	if (err_is_fail(err)) {
        return err_push(err, LIB_ERR_VSPACE_INIT);
    }

	// debug_printf("barrelfish_init_onthread: Initializing our morecore backend!\n");
	err = morecore_init();
   	if (err_is_fail(err)) {
   	    return err_push(err, LIB_ERR_MORECORE_INIT);
   	}

	lmp_endpoint_init();
	
	//set_real_malloc();	
	//debug_printf("seted real malloc for allocations :D");

	// init domains only get partial init
    if (init_domain) {
        return SYS_ERR_OK;
    }

	//debug_printf("Initializing our endpoint with init!\n");

	err = aos_rpc_init(TASKCN_SLOT_REMEP);
	if (err_is_fail(err)) {
		DEBUG_ERR(err,"Error in aos_rpc_init!\n");
		return err_push(err, SYS_ERR_LRPC_SLOT_INVALID);
	}

	domainid_t own_did;
	
	err = aos_rpc_get_did(get_init_chan(), domain_name + 11, &own_did);
	if (err_is_fail(err)) {
		DEBUG_ERR(err,"Error in aos_rpc_init!\n");
		return err_push(err, SYS_ERR_LRPC_SLOT_INVALID);
	}

	disp_set_domain_id(own_did);

	//debug_printf("Setting our local ram allocator to talk with server!\n");
    err = ram_alloc_set(NULL);
    if (err_is_fail(err)) {
    	DEBUG_ERR(err,"Error in ram_alloc_set with server!\n");
	    return err_push(err, LIB_ERR_RAM_ALLOC_SET);
    }
	
  	return SYS_ERR_OK;
}


/**
 *  \brief Initialise libbarrelfish, while disabled.
 *
 * This runs on the dispatcher's stack, while disabled, before the dispatcher is
 * setup. We can't call anything that needs to be enabled (ie. cap invocations)
 * or uses threads. This is called from crt0.
 */
void barrelfish_init_disabled(dispatcher_handle_t handle, bool init_dom_arg);
void barrelfish_init_disabled(dispatcher_handle_t handle, bool init_dom_arg)
{
	// debug_printf("barrelfish_init_disabled: Initializing...\n");
	
    init_domain = init_dom_arg;
    disp_init_disabled(handle);
    thread_init_disabled(handle, init_dom_arg);
}
