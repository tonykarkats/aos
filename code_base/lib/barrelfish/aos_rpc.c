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
#include <barrelfish_kpi/types.h>
#include <string.h>
#include <math.h>
#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)

static struct aos_rpc memory_channel;

static void send_handler(void *arg) {

	errval_t err;
	struct lmp_chan *lc = arg;

	err = lmp_chan_register_send(lc, &get_init_chan()->s_waitset,
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

 	struct aos_rpc * rpc_channel = get_init_chan();

	rpc_channel->message_length = msg.buf.msglen;
	rpc_channel->cap = cap;
	for (int i = 0; i < msg.buf.msglen; i++)	
		rpc_channel->words[i] = msg.words[i];

	if (!capref_is_null(cap)) {
		err = lmp_chan_alloc_recv_slot(lc);
		if (err_is_fail(err)) {
			debug_printf("Error in allocating capability slot in the channel!\n");
		}
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

		buffer[0] = ((AOS_RPC_SEND_STRING << 24) | (0x00FFFFFFF & disp_get_domain_id()));
		
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
				
		// event_dispatch(get_default_waitset());
	} 	
	
	return SYS_ERR_OK;
}



errval_t aos_rpc_get_ram_cap(struct aos_rpc *chan, size_t request_bits,
                             struct capref *retcap, size_t *ret_bits)
{
	errval_t err;

	// debug_printf("aos_rpc_get_ram_cap: request for %d in bits!\n", request_bits);		

	while (true) {
		event_dispatch(&chan->s_waitset);
		err = lmp_chan_send2(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, ((AOS_RPC_GET_RAM_CAP << 24) | (0x00FFFFFF & disp_get_domain_id())), request_bits);	
		if ((err_no(err) != 17)&&(err_is_fail(err)))
			return err_push(err, AOS_ERR_LMP_GET_CAP);	
		else if (!err_is_fail(err)) 
			break;
	} 

	event_dispatch(get_default_waitset());

	*retcap = chan->cap;
	*ret_bits = chan->words[0];
		
	if (capref_is_null(chan->cap))  {
		debug_printf("aos_rpc_get_ram_cap: Server can not handle our request!\n");
   		*ret_bits = 0;
	 	*retcap = NULL_CAP;
		return err_push(err, AOS_ERR_LMP_GET_CAP);
	}

	return SYS_ERR_OK;

}

errval_t aos_rpc_get_dev_cap(struct aos_rpc *chan, lpaddr_t paddr,
                             size_t length, struct capref *retcap,
                             size_t *retlen)
{	
	errval_t err;

	size_t size_in_bits = log2ceil(length);
	
	while (true) {
		event_dispatch(&chan->s_waitset);
		err = lmp_chan_send3(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, 
							 chan->rpc_channel.local_cap, ((AOS_RPC_GET_DEV_CAP << 24) | (0x00FFFFFF & disp_get_domain_id())) , 
							 (uint32_t) paddr, (uint32_t) size_in_bits);	
		if ((err_no(err) != 17)&&(err_is_fail(err)))
			return err_push(err, AOS_ERR_LMP_GET_CAP);	
		else if (!err_is_fail(err)) 
			break;
	} 

	event_dispatch(get_default_waitset());

	*retcap = chan->cap;
	*retlen = chan->words[0];

	if (capref_is_null(chan->cap))  {
		debug_printf("aos_rpc_get_ram_cap: Server can not handle our request!\n");
   		*retlen = 0;
	 	*retcap = NULL_CAP;
		return err_push(err, AOS_ERR_LMP_GET_CAP);
	}

	return SYS_ERR_OK;
}

errval_t aos_rpc_serial_getchar(struct aos_rpc *chan, char *retc)
{
   	errval_t err;
		
	while(true) {
		event_dispatch(&chan->s_waitset);
		err = lmp_chan_send1(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, 
							 chan->rpc_channel.local_cap, 
							 ((AOS_RPC_GET_CHAR << 24) | (0x00FFFFFF & disp_get_domain_id())));	
		if ((err_no(err) != 17)&&(err_is_fail(err)))
			return err_push(err, AOS_ERR_LMP_GET_CHAR);	
		else if (!err_is_fail(err))
			break;	
	};

	event_dispatch(get_default_waitset());

	*retc = (char) chan->words[0];
	
	return SYS_ERR_OK;
}


errval_t aos_rpc_serial_putchar(struct aos_rpc *chan, char c)
{
	errval_t err;
	
	while(true) {
		event_dispatch(&chan->s_waitset);	
		err = lmp_chan_send2(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, 
							 chan->rpc_channel.local_cap, 
							 ((AOS_RPC_PUT_CHAR  << 24) | (0x00FFFFFF & disp_get_domain_id())), 
							 c & 0x000000FF);	
		if ((err_no(err) != 17)&&(err_is_fail(err)))
			return err_push(err, AOS_ERR_LMP_PUT_CHAR);	
		else if (!err_is_fail(err))
			break;
	}

	return SYS_ERR_OK;
}

errval_t aos_rpc_process_spawn(struct aos_rpc *chan, char *name,
                               coreid_t core ,domainid_t *newpid)
{
	errval_t err;
    uint32_t buffer[9];
    size_t name_length = strlen(name);
	
    assert(name_length <= 32);

    buffer[0] = ((AOS_RPC_PROC_SPAWN << 24) | (0x00FFFFFF & disp_get_domain_id()));
	buffer[1] = core;

    memcpy(buffer + 2, name, name_length+1);

	while(true) {
   		event_dispatch(&chan->s_waitset);
		err = lmp_chan_send9(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, 
						  buffer[0], buffer[1],buffer[2],
        	              buffer[3], buffer[4],buffer[5],
        	              buffer[6], buffer[7],buffer[8]);
        if ((err_no(err) != 17)&&(err_is_fail(err))) {
			debug_printf("aos_rpc_process_spawn: Error in spawning domain\n");
       		return err_push(err, AOS_ERR_LMP_SPAWN_DOM);
    	}
		else if (err_is_ok(err))
			break;
	}

    event_dispatch(get_default_waitset());

	*newpid = chan->words[0];
	if (*newpid == 0) {
		//debug_printf("spawn_domain: Can not spawn!\n");
		return AOS_ERR_LMP_SPAWN_DOM;
	}

	if (core == 1)
		return SYS_ERR_OK;
	
	if (strchr(name, '&') != NULL) {
		return SYS_ERR_OK;
	}
	else {
		//debug_printf("Waiting for process to finish!\n");
		event_dispatch(get_default_waitset());
	}
	
    return SYS_ERR_OK;
}

errval_t aos_rpc_process_kill_process(struct aos_rpc *chan, domainid_t pid)
{
    errval_t err;

	while(true) {
		event_dispatch(&chan->s_waitset);
		err = lmp_chan_send2(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, AOS_RPC_KILL, (uint32_t) pid);
       	if ((err_no(err) != 17)&&(err_is_fail(err))) {	
			debug_printf("aos_rpc_process_spawn: Error in killing process!\n");
       		return err_push(err, AOS_ERR_LMP_SPAWN_DOM);
    	}
		else if (err_is_ok(err))
			break;	
	}
	
    return SYS_ERR_OK;
}


errval_t aos_rpc_process_get_name(struct aos_rpc *chan, domainid_t pid,
                                  char **name)
{
    errval_t err;
	//char *domain_name;
	
	//debug_printf("WIll request name of pid %d\n", pid);

	//domain_name = (char *) malloc(36);    
    
	while(true) {
		event_dispatch(&chan->s_waitset);
		err = lmp_chan_send2(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, 
							 chan->rpc_channel.local_cap, 
							 ((AOS_RPC_PROC_GET_NAME << 24) | (0x00FFFFFF & disp_get_domain_id())) , 
							 (uint32_t) pid);
	
    	if ((err_no(err) != 17)&&(err_is_fail(err))) {
       		debug_printf("aos_rpc_process_spawn: Error in getting process name!\n");
       		return err_push(err, AOS_ERR_LMP_SPAWN_DOM);
    	}
		else if (err_is_ok(err))
			break;	
	}

    event_dispatch(get_default_waitset());

	for (int i = 0; i< 9; i++) {
		uint32_t * word = (uint32_t *) (*name + i*4);
		*word = chan->words[i];   
	}
   
	//debug_printf("Client: Process with %s\n", domain_name);
    	
	//*name = domain_name;
    return SYS_ERR_OK;
}

errval_t aos_rpc_process_get_all_pids(struct aos_rpc *chan,
                                      domainid_t **pids_returned, size_t *pid_count)
{
	errval_t err;

	while(true) {
		event_dispatch(&chan->s_waitset);
		err = lmp_chan_send1(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, 
							 ((AOS_RPC_PROC_GET_PIDS  << 24) | (0x00FFFFFF & disp_get_domain_id())));
		
    	if ((err_no(err) != 17)&&(err_is_fail(err))) {
       		debug_printf("aos_rpc_process_spawn: Error in getting pids!\n");
       		return err_push(err, AOS_ERR_LMP_SPAWN_DOM);
    	}
		else if (err_is_ok(err))
			break;	
	}

    event_dispatch(get_default_waitset());
	
	//debug_printf("Returned!\n");
	
	// Count valid pids
	size_t count = 0;
	while(true) {
		if (chan->words[count] == 0) 
			break;
		count++;
	}

	//debug_printf("Returned! Count = %d\n", count);
	
	for (int i = 0; i<count; i++) {
		//debug_printf("Returned pid %d\n", chan->words[i]);
		(*pids_returned)[i] = (domainid_t) chan->words[i];
		//debug_printf("Returned pid %d\n",(*pids_returned)[i] );
	}

	*pid_count = count;
	return SYS_ERR_OK;
}

errval_t aos_rpc_terminating(struct aos_rpc *chan, domainid_t did, int exit_status) 
{
	errval_t err;
		
	//debug_printf("Sending terminating to client with did %zu with status %d\n", did, exit_status);
	
	while(true) {
   		event_dispatch(&chan->s_waitset);
		err = lmp_chan_send3(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, 
							 chan->rpc_channel.local_cap, 
							 ((AOS_RPC_TERMINATING  << 24) | (0x00FFFFFF & disp_get_domain_id())), 
							 did, (uint32_t) exit_status);

    	if ((err_no(err) != 17)&&(err_is_fail(err))) {
       		debug_printf("aos_rpc_process_spawn: Error in terminating domain!\n");
       		return err_push(err, AOS_ERR_LMP_TERMINATING);
    	}
		else if (err_is_ok(err))
			break;
	}

	return SYS_ERR_OK;
}

errval_t aos_rpc_open(struct aos_rpc *chan, char *path, int *fd)
{
	errval_t err;
	
	// Copy path to the shared buffer with init!
	memcpy(chan->shared_buffer, path, strlen(path) + 1);

	while(true) {
   		event_dispatch(&chan->s_waitset);
		err = lmp_chan_send1(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, 
							 chan->rpc_channel.local_cap, 
							 ((AOS_RPC_OPEN_FILE  << 24) | (0x00FFFFFF & disp_get_domain_id())));

    	if ((err_no(err) != 17)&&(err_is_fail(err))) {
       		debug_printf("aos_rpc_readdir: Error in reading dir!\n");
       		return err_push(err, AOS_ERR_LMP_CAN_NOT_OPEN_FILE);
    	}
		else if (err_is_ok(err))
			break;
	}

	event_dispatch(get_default_waitset());	

	int returned_value = (int) chan->words[0];	

	if (returned_value == -1) {
		// debug_printf("aos_rpc_readdir: File not found!\n");
		return AOS_ERR_LMP_CAN_NOT_OPEN_FILE;
	}

	// Return fd to the caller
	*fd = returned_value;

    return SYS_ERR_OK;
}

errval_t aos_rpc_readdir(struct aos_rpc *chan, char* path,
                         struct aos_dirent **dir, size_t *elem_count)
{
	errval_t err;
	
	// Copy path to the shared buffer with init!
	memcpy(chan->shared_buffer, path, strlen(path) + 1);
	
	while(true) {
   		event_dispatch(&chan->s_waitset);
		err = lmp_chan_send1(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, 
							 chan->rpc_channel.local_cap, 
							 ((AOS_RPC_READ_DIR  << 24) | (0x00FFFFFF & disp_get_domain_id())));

    	if ((err_no(err) != 17)&&(err_is_fail(err))) {
       		debug_printf("aos_rpc_readdir: Error in reading dir!\n");
       		return err_push(err, AOS_ERR_LMP_DIR_NOT_FOUND);
    	}
		else if (err_is_ok(err))
			break;
	}

	event_dispatch(get_default_waitset());	

	int returned_value = (int) chan->words[0];
	
	if (returned_value == -1) {
		// debug_printf("aos_rpc_readdir: Directory not found!\n");
		return AOS_ERR_LMP_DIR_NOT_FOUND;
	}
	
	// Returned dir entries in the shared buffer	
	*elem_count = returned_value;

	// Malloc and fill in with data from the shared buffer and return to user!
	*dir = (struct aos_dirent *) malloc(sizeof(struct aos_dirent) * *elem_count);
	
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

errval_t aos_rpc_get_did (struct aos_rpc *chan, const char* name, domainid_t * did, struct capref *shared_frame) 
{
	errval_t err;
    uint32_t buffer[9];
    size_t name_length = strlen(name);
	
    assert(name_length <= 32);

    buffer[0] = ((AOS_RPC_GET_DID  << 24) & (0xFF000000)) ;
    memcpy(buffer + 1, name, name_length+1);

	while(true) {
   		event_dispatch(&chan->s_waitset);
		err = lmp_chan_send9(&chan->rpc_channel, LMP_SEND_FLAGS_DEFAULT, chan->rpc_channel.local_cap, 
						  buffer[0], buffer[1],buffer[2],
        	              buffer[3], buffer[4],buffer[5],
        	              buffer[6], buffer[7],buffer[8]);
    	if ((err_no(err) != 17)&&(err_is_fail(err))) {
       		debug_printf("aos_rpc_process_spawn: Error in spawning domain\n");
       		return err_push(err, AOS_ERR_LMP_SPAWN_DOM);
    	}
		else if (err_is_ok(err))
			break;
	}

    event_dispatch(get_default_waitset());

	*did = chan->words[0];
	*shared_frame = chan->cap;
	if (*did == 0) {
		debug_printf("spawn_domain: Can not fetch domain id!\n");
		return AOS_ERR_LMP_SPAWN_DOM;
	}
	
	// debug_printf("fetched did for domain %zu\n", *did);	
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
		
	waitset_init(&memory_channel.s_waitset);

	err = lmp_chan_register_recv(&memory_channel.rpc_channel, get_default_waitset(), 
			rpc_handler_init);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Error in registering the channel for recv_handler!\n");	
		return LIB_ERR_CHAN_REGISTER_RECV;
	}

	rpc_handler_init.handler = send_handler;
	
	err = lmp_chan_register_send(&memory_channel.rpc_channel, &memory_channel.s_waitset,
			rpc_handler_init);	
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Error in registering the channel for send_handler!\n");	
		return LIB_ERR_NO_LMP_BIND_HANDLER;
	}	

	set_init_chan(&memory_channel);

  	return SYS_ERR_OK;
}
