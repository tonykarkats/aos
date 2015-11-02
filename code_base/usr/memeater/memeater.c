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
	
	/*struct aos_rpc test_rpc;

	err = aos_rpc_init(&test_rpc, TASKCN_SLOT_REMEP);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Rpc init fail!\n");
		abort();
	}
	
	struct capref returned_cap;
	size_t ret_bits;

	err = aos_rpc_get_ram_cap( &test_rpc, 1024*1024, &returned_cap, &ret_bits); 	
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Failure in memory allocation!\n");
		abort();
	}
	
	err = aos_rpc_get_ram_cap( &test_rpc, 1024*1024, &returned_cap, &ret_bits); 	
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Failure in memory allocation!\n");
		abort();
	}

	err = aos_rpc_get_ram_cap( &test_rpc, 1024*1024*3, &returned_cap, &ret_bits); 	
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Failure in memory allocation!\n");
		abort();
	}

	err = aos_rpc_get_ram_cap( &test_rpc, 1024*1024*1/2, &returned_cap, &ret_bits); 	
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Failure in memory allocation!\n");
		abort();
	}
	*/
	
	
	
	void *vbuf;
    err = paging_alloc(get_current_paging_state(), &vbuf, (1024*1024*10));
    if (err_is_fail(err)) {
        printf("error in paging_alloc: %s\n", err_getstring(err));
        abort();
    }

	char* buf = (char *) vbuf;
	for (int i = 0 ; i < 10*1024*1024; i++)
		buf[i] = i;

    err = paging_alloc(get_current_paging_state(), &vbuf, (1024*32));
	debug_printf("Before while(1)\n");	
	for (int i = 0 ; i < 5*1024*1024; i++)
		buf[i] = i;

	while(1);

   return 0;
}
