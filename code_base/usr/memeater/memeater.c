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


int main(int argc, char *argv[])
{
	//errval_t err;
    struct sysret ret;

	debug_printf("memeater started\n");
    
	// TODO STEP 1: connect & send msg to init using syscall
   
	struct capref remote_endpoint = {
		.cnode = cnode_task,	
		.slot = TASKCN_SLOT_REMEP
	};

	
	ret = cap_invoke1(remote_endpoint, 2);

	// TODO STEP 5: test memory allocation using memserv

    return 0;
}
