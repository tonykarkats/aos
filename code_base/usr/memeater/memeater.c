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

#define BUFSIZE_2 (128UL*1024*1024)
#define MALLOC_BUFSIZE 1   //(1UL<<20)
#define BUFSIZE 32L * 1024 * 1024
#define SAFE_VADDR (1UL<<25)

#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)


static struct lmp_chan channel;

errval_t send_message(struct lmp_chan *c, uintptr_t *msgbuf,
	size_t msg_words, size_t *words_sent);

errval_t send_message(struct lmp_chan *c, uintptr_t *msgbuf,
	size_t msg_words, size_t *words_sent)
{
	uintptr_t buf[LMP_MSG_LENGTH];
	if (msg_words > LMP_MSG_LENGTH) {
		msg_words = LMP_MSG_LENGTH;
	}
	memcpy(buf, msgbuf, msg_words*sizeof(uintptr_t));
	memset(buf+msg_words, 0, (LMP_MSG_LENGTH-msg_words));
	if (words_sent) { *words_sent = msg_words; }
		return lmp_chan_send2(c, LMP_FLAG_SYNC | LMP_FLAG_YIELD, NULL_CAP,
								buf[0], buf[1]);
}

int main(int argc, char *argv[])
{
	errval_t err;

	debug_printf("memeater started\n");
    
	// TODO STEP 1: connect & send msg to init using syscall

	lmp_chan_init(&channel);
	uintptr_t msgbuf[2] = { 'A','B'};
	size_t words_sent;

	
	channel.remote_cap = cap_initep;	

	err = send_message(&channel, msgbuf, 2, &words_sent);
	if (err_is_fail(err)) {
		printf("Error in sending the message\n!");
	} 
	else 
		printf("Sent words!\n");
	
		
	// This call will re-enable init dispatcher 
	// in the schedule 
	// We could marshal the arguments by hand but lmp_ep_send2 does 
	// just that.:wq
	
//	err = lmp_ep_send2(cap_initep, LMP_FLAG_SYNC, NULL_CAP, 1, 16);
//	if (err_is_fail(err)) {
//		DEBUG_ERR(err,"memeater: Fail in sending message!\n");
//	}
	
	while(1);	
	// TODO STEP 5: test memory allocation using memserv

    return 0;
}
