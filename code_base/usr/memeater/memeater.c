#include <barrelfish/barrelfish.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <barrelfish/sys_debug.h>
#include <barrelfish/morecore.h>
#include <barrelfish/dispatcher_arch.h>
#include <barrelfish/debug.h>
#include <barrelfish/lmp_chan.h>
#include <barrelfish/sys_debug.h>
#include <barrelfish/cspace.h>
#include <barrelfish/aos_rpc.h>

#define BUFSIZE_2 (128UL*1024*1024)
#define MALLOC_BUFSIZE 1   //(1UL<<20)
#define BUFSIZE 32L * 1024 * 1024
#define SAFE_VADDR (1UL<<25)

#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)

/*
static struct lmp_chan init_channel;
static struct lmp_chan memeater_channel;

static errval_t send_message(struct lmp_chan *c, uintptr_t *msgbuf,
	size_t msg_words, size_t *words_sent, struct capref cap_to_pass)
{
	uintptr_t buf[LMP_MSG_LENGTH];
	if (msg_words > LMP_MSG_LENGTH) {
		msg_words = LMP_MSG_LENGTH;
	}
	memcpy(buf, msgbuf, msg_words*sizeof(uintptr_t));
	memset(buf+msg_words, 0, (LMP_MSG_LENGTH-msg_words));
	if (words_sent) { *words_sent = msg_words; }
		return lmp_chan_send2(c, LMP_FLAG_SYNC | LMP_FLAG_YIELD, cap_to_pass,
								buf[0], buf[1]);
}

static void recv_handler(void *arg) 
{
	debug_printf("recv_handler: Got a message!");
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
	debug_printf("msg->words[0] = 0x%lx\n", msg.words[0]);	
	debug_printf("msg->words[1] = 0x%lx\n", msg.words[1]);
	lmp_chan_register_recv(lc, get_default_waitset(),
		MKCLOSURE(recv_handler, arg));

	if (capref_is_null(cap)) 
		debug_printf("cap received = NULL_CAP\n");
	else {
		debug_printf("cap received, slot = %u \n", cap.slot);
		err = lmp_ep_send1(cap, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, 'a');
		if (err_is_fail(err))
			debug_printf("Could not send a message!\n");
	}
}
*/

int main(int argc, char *argv[])
{
	errval_t err;
//	uintptr_t msg_buf[2] = { 'A', 'B' };
//	debug_printf("memeater started\n");
//    
//	// TODO STEP 1: connect & send msg to init using syscall
//
//	lmp_chan_init(&init_channel);
//	lmp_chan_init(&memeater_channel);
//	struct waitset* ws = get_default_waitset();
//
//	size_t words_sent;
//	
//	init_channel.remote_cap = cap_initep;	
//
//	struct lmp_endpoint* remep;
//
//	struct capref mem_ep = {
//		.cnode = cnode_task,
//		.slot = TASKCN_SLOT_REMEP
//	};		
//
//	err = lmp_endpoint_create_in_slot(FIRSTEP_BUFLEN, mem_ep, &remep);
//	if (err_is_fail(err)) {
//		DEBUG_ERR(err, "Error in lmp endpoint create!\n");
//		abort();
//	}			
//
//	memeater_channel.endpoint = remep;
//	memeater_channel.local_cap = mem_ep;
//
//	struct event_closure memeater_handler_init = {
//        .handler = recv_handler,
//        .arg = &memeater_channel,
//    };
//
//	err = lmp_chan_register_recv(&memeater_channel,ws, memeater_handler_init);
//	if (err_is_fail(err)) {
//		debug_printf("Error in registering the channel..\n");	
//		abort();
//	}
//	
//	err = send_message(&init_channel, msg_buf, 2, &words_sent, mem_ep);
//	if (err_is_fail(err)) {
//		printf("Error in sending the message\n!");
//	} 
//	else 
//		printf("Sent words!\n");


	struct aos_rpc test_rpc;

	err = aos_rpc_init(&test_rpc);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Rpc init fail!\n");
		abort();
	}

	err = aos_rpc_send_string(&test_rpc, "Hello init!COCK!!!!!");
	if (err_is_fail(err)) {
		DEBUG_ERR(err,"Rpc send strign failed!\n");
		abort();
	}
	while(1);
	// This call will re-enable init dispatcher 
	// in the schedule 
	// We could marshal the arguments by hand but lmp_ep_send2 does 
	// just that.:wq


    return 0;
}
