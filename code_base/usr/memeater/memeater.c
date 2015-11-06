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
	
	struct aos_rpc *test_rpc = get_init_chan();
	err = aos_rpc_send_string(test_rpc, "Hello"); 	
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Failure in sending string!!\n");
		abort();
	}
	
	void *vbuf;
    err = paging_alloc(get_current_paging_state(), &vbuf, (1024*1024*5));
    if (err_is_fail(err)) {
        printf("error in paging_alloc: %s\n", err_getstring(err));
        abort();
    }

	char* buf = (char *) vbuf;
	for (int i = 0 ; i < 1024*1024*10; i++)
		buf[i] = i;

//	for (int i = 0 ; i < 5*1024*1024; i++)
//		buf[i] = i;

	while(1);

   return 0;
}
