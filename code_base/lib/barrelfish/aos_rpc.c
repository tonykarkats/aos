/**
 * \file
 * \brief Implementation of AOS rpc-like messaging
 */

/*
 * Copyright (c) 2013, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#include <barrelfish/aos_rpc.h>
#include <string.h>
#include <math.h>
#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)

static struct capref ram_cap;
static uint32_t returned_string[9];
static int received_length;
//static uint32_t client_id = -1;
static struct aos_rpc memory_channel;

static void recv_handler(void *arg) 
{
	debug_printf("recv_handler: Got a message or a cap!");
	errval_t err;
	struct lmp_chan *lc = arg;
	struct lmp_recv_msg msg = LMP_RECV_MSG_INIT;
	struct capref cap;

	err = lmp_chan_recv(lc, &msg, &cap);
	if (err_is_fail(err) && lmp_err_is_transient(err)) {
		lmp_chan_register_recv(lc,get_default_waitset(),
							MKCLOSURE(recv_handler, arg));
	}
	
	debug_printf("msg buflen %zu\n", msg.buf.msglen);
	
	received_length = msg.buf.msglen;

	for (int i=0 ; i<msg.buf.msglen; i++) {
		debug_printf("msg->words[%d] = 0x%lx\n",i,msg.words[i]);	
		returned_string[i] = msg.words[i];	
	}
	
	ram_cap = cap;	
	lmp_chan_register_recv(lc, get_default_waitset(),
		MKCLOSURE(recv_handler, arg));

	
}

static void bootstrap_handler(void *arg) 
{
	debug_printf("recv_handler: I initialized the connection to the server!\n");
	errval_t err;
	struct lmp_chan *lc = arg;
	struct lmp_recv_msg msg = LMP_RECV_MSG_INIT;
	struct capref cap;

	err = lmp_chan_recv(lc, &msg, &cap);
	if (err_is_fail(err) && lmp_err_is_transient(err)) {
		lmp_chan_register_recv(lc,get_default_waitset(),
							MKCLOSURE(recv_handler, arg));
	}
	
	//debug_printf("msg buflen %zu\n", msg.buf.msglen);
	
	//received_length = msg.buf.msglen;
	
	//assert(received_length == 1);
	
	//debug_printf("My client_id = %d!\n", msg.words[0]);

	//client_id = msg.words[0];

}

errval_t aos_rpc_send_string(struct aos_rpc *chan, const char *string)
{
	errval_t err;

	uint32_t buffer[9];

	// Check length of user string in a safe manner
	int i;
	for (i=0; i < 34; i++)
		if (string[i] == '\0')
			break;

	if (i == 34) 
		return AOS_ERR_LMP_SEND_FAILURE;
	
	buffer[0] = AOS_RPC_SEND_STRING;	
	memcpy(buffer + 1, string, strlen(string)+1);

//	for (int t=0; t<9; t++)
//		debug_printf("buf[%d] = 0x%lx\n",  t, buffer[t]);
	
	err = lmp_chan_send(&chan->init_channel, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, 9,
				  buffer[0] , buffer[1],buffer[2],
				  buffer[3], buffer[4],buffer[5],
				  buffer[6], buffer[7],buffer[8]);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Error in sending the string!\n");
		return AOS_ERR_LMP_SEND_FAILURE;
	}
	
	return SYS_ERR_OK;
}



errval_t aos_rpc_get_ram_cap(struct aos_rpc *chan, size_t request_bits,
                             struct capref *retcap, size_t *ret_bits)
{
	debug_printf("aos_rpc_get_ram_cap: Initiating...\n");
	errval_t err;
	
	size_t alloc_bits = log2ceil(request_bits);
	
	err = lmp_chan_send2(&chan->init_channel, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, AOS_RPC_GET_RAM_CAP, alloc_bits);	
 	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Could not sent request for memory in the server!\n");
		return AOS_ERR_LMP_SEND_FAILURE;
	}

	event_dispatch(get_default_waitset());
	debug_printf("aos_rpc_get_ram_cap: Server responded!\n");	

	if (capref_is_null(ram_cap))  {
		debug_printf("aos_rpc_get_ram_cap: Server can not handle our request!\n");
   		*ret_bits = 0;
	 	return LIB_ERR_RAM_ALLOC;
	}
	else 
		debug_printf("aos_rpc_get_ram_cap: Server responded with a memory region!\n");
	
	lmp_chan_alloc_recv_slot(&chan->rpc_channel);	

	*retcap = ram_cap;
	*ret_bits = pow(2,alloc_bits);	
	return SYS_ERR_OK;

}

errval_t aos_rpc_get_dev_cap(struct aos_rpc *chan, lpaddr_t paddr,
                             size_t length, struct capref *retcap,
                             size_t *retlen)
{
    // TODO (milestone 4): implement functionality to request device memory
    // capability.
    return SYS_ERR_OK;
}

errval_t aos_rpc_serial_getchar(struct aos_rpc *chan, char *retc)
{
    // TODO (milestone 4): implement functionality to request a character from
    // the serial driver.
    return SYS_ERR_OK;
}


errval_t aos_rpc_serial_putchar(struct aos_rpc *chan, char c)
{
    // TODO (milestone 4): implement functionality to send a character to the
    // serial port.
    return SYS_ERR_OK;
}

errval_t aos_rpc_process_spawn(struct aos_rpc *chan, char *name,
                               domainid_t *newpid)
{
    // TODO (milestone 5): implement spawn new process rpc
    return SYS_ERR_OK;
}

errval_t aos_rpc_process_get_name(struct aos_rpc *chan, domainid_t pid,
                                  char **name)
{
    // TODO (milestone 5): implement name lookup for process given a process
    // id
    return SYS_ERR_OK;
}

errval_t aos_rpc_process_get_all_pids(struct aos_rpc *chan,
                                      domainid_t **pids, size_t *pid_count)
{
    // TODO (milestone 5): implement process id discovery
    return SYS_ERR_OK;
}

errval_t aos_rpc_open(struct aos_rpc *chan, char *path, int *fd)
{
    // TODO (milestone 7): implement file open
    return SYS_ERR_OK;
}

errval_t aos_rpc_readdir(struct aos_rpc *chan, char* path,
                         struct aos_dirent **dir, size_t *elem_count)
{
    // TODO (milestone 7): implement readdir
    return SYS_ERR_OK;
}

errval_t aos_rpc_read(struct aos_rpc *chan, int fd, size_t position, size_t size,
                      void** buf, size_t *buflen)
{
    // TODO (milestone 7): implement file read
    return SYS_ERR_OK;
}

errval_t aos_rpc_close(struct aos_rpc *chan, int fd)
{
    // TODO (milestone 7): implement file close
    return SYS_ERR_OK;
}

errval_t aos_rpc_write(struct aos_rpc *chan, int fd, size_t position, size_t *size,
                       void *buf, size_t buflen)
{
    // TODO (milestone 7): implement file write
    return SYS_ERR_OK;
}

errval_t aos_rpc_create(struct aos_rpc *chan, char *path, int *fd)
{
    // TODO (milestone 7): implement file create
    return SYS_ERR_OK;
}

errval_t aos_rpc_delete(struct aos_rpc *chan, char *path)
{
    // TODO (milestone 7): implement file delete
    return SYS_ERR_OK;
}

errval_t aos_rpc_init(int slot_number)
{
	errval_t err;
	
	struct waitset * ws = get_default_waitset();

	lmp_chan_init(&memory_channel.init_channel);
	memory_channel.init_channel.remote_cap = cap_initep;
	
	

	struct capref rem_ep = {
		.cnode = cnode_task,
		.slot = slot_number
	};

	struct lmp_endpoint* ep;
	
	err = endpoint_create(FIRSTEP_BUFLEN, &rem_ep,
									  &ep);		  
	if (err_is_fail(err)) {
		DEBUG_ERR(err,"Failure in creating client endpoint!\n");
		abort();
	}	
	memory_channel.rpc_channel.endpoint = ep;
	memory_channel.rpc_channel.local_cap = rem_ep;

	err = lmp_chan_alloc_recv_slot(&memory_channel.rpc_channel);
	if (err_is_fail(err)) {
		DEBUG_ERR(err,"Error in allocating capability slot in the channel!\n");
		return LIB_ERR_LMP_ALLOC_RECV_SLOT;
	}
	
	struct event_closure rpc_handler_init = {
        .handler = bootstrap_handler,
        .arg = &memory_channel.rpc_channel,
    };

	err = lmp_chan_register_recv(&memory_channel.rpc_channel, ws, rpc_handler_init);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Error in registering the channel for bootstrap handler!\n");	
		return LIB_ERR_CHAN_REGISTER_RECV;
	}
	
	lmp_chan_send1(&memory_channel.init_channel, LMP_SEND_FLAGS_DEFAULT, rem_ep, (uint32_t)AOS_RPC_CONNECT);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Error in sending our own endpoint to init\n!");
		return LIB_ERR_LMP_CHAN_SEND;
	} 
	else 
		debug_printf("Sent our endpoint to init!\n");
 
	event_dispatch(ws);	
	
	debug_printf("Memory server accepted us!\n");
//	memory_channel.client_id = client_id;	

	rpc_handler_init.handler = recv_handler;
	
	err = lmp_chan_register_recv(&memory_channel.rpc_channel, ws, rpc_handler_init);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Error in registering the channel for recv_handler!\n");	
		return LIB_ERR_CHAN_REGISTER_RECV;
	}


	set_init_chan(&memory_channel);

  	return SYS_ERR_OK;
}
