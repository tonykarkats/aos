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

static char rpc_char;
static struct capref ram_cap;
static struct aos_rpc memory_channel;
static domainid_t spawned_domain;
static domainid_t pids[32];
static int total_domains;
static char domain_name[32];

static void send_handler(void *arg) {
	
	errval_t err;
	struct lmp_chan *lc = arg;

	err = lmp_chan_register_send(lc, get_default_waitset(),
			MKCLOSURE(send_handler, arg));	
	if (err_is_fail(err)) {
		debug_printf("Error in re-registering send handler!\n");
	}

	return; 
}

static void recv_handler(void *arg) 
{
//	debug_printf("recv_handler: Got a message or a cap!");
	errval_t err;
	struct lmp_chan *lc = arg;
	struct lmp_recv_msg msg = LMP_RECV_MSG_INIT;
	struct capref cap;

	err = lmp_chan_recv(lc, &msg, &cap);
	if (err_is_fail(err) && lmp_err_is_transient(err)) {
		lmp_chan_register_recv(lc,get_default_waitset(),
							MKCLOSURE(recv_handler, arg));
	}

	lmp_chan_register_recv(lc, get_default_waitset(),
		MKCLOSURE(recv_handler, arg));	

	int message_length = msg.buf.msglen;
	
	int string_length = message_length - 1;
	//char message_string[string_length * 4];
		
	// uint32_t rpc_operation = msg.words[0];
	// debug_printf("msg buflen %zu\n", msg.buf.msglen);
	switch (msg.words[0]) {
		case AOS_RPC_GET_RAM_CAP: ;// Request Ram Capability
			ram_cap = cap;
			break;
		case AOS_RPC_GET_CHAR: ;
			rpc_char = (char) msg.words[1];
			break;
		case AOS_RPC_SEND_STRING: ;
			break;
		case AOS_RPC_PROC_SPAWN: ;
			spawned_domain = (domainid_t) msg.words[1];
			break;
		case AOS_RPC_PROC_GET_NAME:
		  			
			for (int i = 0; i< string_length; i++) {
				uint32_t * word = (uint32_t *) (domain_name + i*4);
				*word = msg.words[i+1];   
			}
			// debug_printf("ALL READ %s\n", domain_name);
			break;
		case AOS_RPC_PROC_GET_PIDS: ;
			total_domains = (int) msg.words[1];
			debug_printf("Received %d\n", total_domains);
			for (int i = 0; i < total_domains; i++) {
				debug_printf("Pid = %d\n", msg.words[i+2]);
				pids[i] = msg.words[i+2];
			}
			break;
	}

}

errval_t aos_rpc_send_string(struct aos_rpc *chan, const char *string)
{
	errval_t err;
	uint32_t buffer[9];
	int i, length, string_chunks, last_chunk;

	for (i=0; i < 2000; i++)
		if (string[i] == '\0')
			break;

	if (i == 2000) {
		debug_printf("Can not send string!\n");
		return AOS_ERR_LMP_SEND_FAILURE;
	}
	length = i + 1;
    string_chunks = (int) ceil(length / 32.0);
	
	if (length % 32 != 0)
		last_chunk = length % 32;
	else 
		last_chunk = 32;

	 //debug_printf("%s    length = %d , cunks = %d , last chunk = %d\n", string, length, string_chunks, last_chunk);

	for (int s_chunk = 0; s_chunk < string_chunks; s_chunk++) { 	
		//debug_printf("Sending chunk %d from %d \n", s_chunk, s_chunk * 32);
		memset(buffer, 0, 36);		

		buffer[0] = AOS_RPC_SEND_STRING;
		
		if (s_chunk == string_chunks - 1)	
			memcpy(buffer + 1, string + 32*s_chunk , last_chunk);
		else 
			memcpy(buffer + 1, string + 32*s_chunk, 32);

		do {	
			err = lmp_chan_send(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, 9,
					  buffer[0] , buffer[1],buffer[2],
					  buffer[3], buffer[4],buffer[5],
					  buffer[6], buffer[7],buffer[8]);
			if ((err_no(err) != 17)&&(err_is_fail(err)))
				return err_push(err, AOS_RPC_SEND_STRING);	
		} while (err_no(err) == 17);
				
		event_dispatch(get_default_waitset());
	} 	
	
	return SYS_ERR_OK;
}



errval_t aos_rpc_get_ram_cap(struct aos_rpc *chan, size_t request_bits,
                             struct capref *retcap, size_t *ret_bits)
{
//	debug_printf("aos_rpc_get_ram_cap: Initiating...\n");
	errval_t err;

	// debug_printf("aos_rpc_get_ram_cap: request for %d in bits!\n", request_bits);		
	
	chan->rpc_channel.remote_cap = cap_initep;

	do {
		err = lmp_chan_send2(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, AOS_RPC_GET_RAM_CAP, request_bits);	
		if ((err_no(err) != 17)&&(err_is_fail(err)))
			return err_push(err, AOS_RPC_GET_RAM_CAP);	
	
	} while (err_no(err) == 17) ;

	event_dispatch(get_default_waitset());

	if (capref_is_null(ram_cap))  {
		debug_printf("aos_rpc_get_ram_cap: Server can not handle our request!\n");
   		*ret_bits = 0;
	 	return AOS_RPC_GET_RAM_CAP;
	}

	lmp_chan_alloc_recv_slot(&chan->rpc_channel);	
	
	*retcap = ram_cap;
	return err;

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
   	errval_t err;
		
	do {
		err = lmp_chan_send1(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, AOS_RPC_GET_CHAR);	
		if ((err_no(err) != 17)&&(err_is_fail(err)))
			return err_push(err, AOS_ERR_LMP_PUT_CHAR);	
	
	} while (err_no(err) == 17) ;


	//debug_printf("BEFORE WAITSET!\n");	

	event_dispatch(get_default_waitset());

	//debug_printf("SERVER RESPONDED WITH CHAR = %c!\n", rpc_char);	


	*retc = rpc_char;	
		
	return SYS_ERR_OK;
}


errval_t aos_rpc_serial_putchar(struct aos_rpc *chan, char c)
{
	errval_t err;
	
	do {	
		err = lmp_chan_send2(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, AOS_RPC_PUT_CHAR, c & 0x000000FF);	
		if ((err_no(err) != 17)&&(err_is_fail(err)))
			return err_push(err, AOS_ERR_LMP_PUT_CHAR);	
	
	} while (err_no(err) == 17) ;



		return AOS_ERR_LMP_SEND_FAILURE;
	

	// event_dispatch(get_default_waitset());
	
	return SYS_ERR_OK;
}

errval_t aos_rpc_process_spawn(struct aos_rpc *chan, char *name,
                               domainid_t *newpid)
{
	errval_t err;
    uint32_t buffer[9];
    size_t name_length = strlen(name);

    assert(name_length <= 32);

    buffer[0] = AOS_RPC_PROC_SPAWN;
    memcpy(buffer + 1, name, name_length);

    //Maybe use fixed buffer[9] for send?
	
   	err = lmp_chan_send9(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, buffer[0], 
					  buffer[1],buffer[2],
                      buffer[3], buffer[4],buffer[5],
                      buffer[6], buffer[7],buffer[8]);
    if (err_is_fail(err)) {
       	debug_printf("aos_rpc_process_spawn: Error in sending request\n");
       	return AOS_ERR_LMP_SEND_FAILURE;
    }
    event_dispatch(get_default_waitset());

   	debug_printf("Spawned process with pid = %d\n", spawned_domain);

	*newpid = spawned_domain;

    return SYS_ERR_OK;
}

errval_t aos_rpc_process_get_name(struct aos_rpc *chan, domainid_t pid,
                                  char **name)
{
    errval_t err;
        
    err = lmp_chan_send2(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, AOS_RPC_PROC_GET_NAME, (uint32_t) pid);
    if (err_is_fail(err)) {
        debug_printf("aos_rpc_process_get_name: Error in sending request\n");
        return AOS_ERR_LMP_SEND_FAILURE;
    }

    event_dispatch(get_default_waitset());
   
	debug_printf("Client: Process with %s\n", domain_name);
    	
	*name = domain_name;
    return SYS_ERR_OK;
}

errval_t aos_rpc_process_get_all_pids(struct aos_rpc *chan,
                                      domainid_t **pids_returned, size_t *pid_count)
{
 errval_t err;

    err = lmp_chan_send1(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, AOS_RPC_PROC_GET_PIDS);
    if (err_is_fail(err)) {
        debug_printf("aos_rpc_process_get_all_pids: Error in sending request\n");
        return AOS_ERR_LMP_SEND_FAILURE;
    }

    event_dispatch(get_default_waitset());

    debug_printf("-------PROCESS LIST TOTAL DOMAINS %d-------\n", total_domains);
    debug_printf("--------------------------\n");

	for (size_t i=0; i < total_domains; i++) {
        debug_printf("%zu\n", pids[i]);
	}

	*pid_count = total_domains;
    *pids_returned = pids;

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
	
	lmp_chan_init(&memory_channel.rpc_channel);
	
	memory_channel.rpc_channel.remote_cap = cap_initep;	

	err = endpoint_create(FIRSTEP_BUFLEN, &memory_channel.rpc_channel.local_cap,
									  &memory_channel.rpc_channel.endpoint);		  
	if (err_is_fail(err)) {
		DEBUG_ERR(err,"Failur in creating client endpoint!\n");
		abort();
	}	
    
	//debug_printf("aos_rpc_init: Created endpoint in slot %zu\n", memory_channel.rpc_channel.local_cap.slot);
		
	err = lmp_chan_alloc_recv_slot(&memory_channel.rpc_channel);
	if (err_is_fail(err)) {
		DEBUG_ERR(err,"Error in allocating capability slot in the channel!\n");
		return LIB_ERR_LMP_ALLOC_RECV_SLOT;
	}
	
	struct event_closure rpc_handler_init = {
        .handler = recv_handler,
        .arg = &memory_channel.rpc_channel,
    };
		
	err = lmp_chan_register_recv(&memory_channel.rpc_channel, get_default_waitset(), 
			rpc_handler_init);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Error in registering the channel for recv_handler!\n");	
		return LIB_ERR_CHAN_REGISTER_RECV;
	}

	rpc_handler_init.handler = send_handler;
	
	err = lmp_chan_register_send(&memory_channel.rpc_channel, get_default_waitset(),
			rpc_handler_init);	
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Error in registering the channel for send_handler!\n");	
		return LIB_ERR_NO_LMP_BIND_HANDLER;
	}

	set_init_chan(&memory_channel);

  	return SYS_ERR_OK;
}
