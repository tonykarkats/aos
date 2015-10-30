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


int main(int argc, char *argv[])
{
	errval_t err;
	struct aos_rpc test_rpc; //, test_rpc_2;

	err = aos_rpc_init(&test_rpc, TASKCN_SLOT_REMEP);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Rpc init fail!\n");
		abort();
	}
	/*
	debug_printf("Registered the first channel...\n");
	err = aos_rpc_init(&test_rpc_2, TASKCN_SLOTS_USER + 10);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Rpc init fail!\n");
		abort();
	}
	*/

	err = aos_rpc_send_string(&test_rpc, "Hello init!COCK!!!!!!!!!!!!!!!!!!!!");
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
