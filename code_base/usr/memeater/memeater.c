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

static int thread_id = 0;

static int test_thread(void){

	errval_t err;

	debug_printf("Hello from thread-%d!\n",thread_id);

	void * vbuf;	
	err = paging_alloc(get_current_paging_state(), &vbuf, (2*4096));
    if (err_is_fail(err)) {
        printf("error in paging_alloc: %s\n", err_getstring(err));
        abort();
    }

	char* buf = (char *) vbuf;
	for (int i = 0 ; i <  2*4096; i++)
		buf[i] = i/4096;

//	for (int i = 0 ; i< 2*4096; i++)
//		assert(buf[i] == i);
	for (int i = 0 ; i< 2*4096; i++)
		debug_printf("%d\n",buf[i]);


	thread_id++;
	return 0;
}

int main(int argc, char *argv[])
{
	
	errval_t err;
	
	struct aos_rpc *test_rpc = get_init_chan();
	err = aos_rpc_send_string(test_rpc, "Hello"); 	
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Failure in sending string!!\n");
		abort();
	}

	struct thread* t = thread_create((thread_func_t)  test_thread, NULL);
	//struct thread* t2= thread_create((thread_func_t)  test_thread, NULL);
	
	int ret_val;
	thread_join(t, &ret_val);
	//thread_join(t2, &ret_val);
	debug_printf("main: Thread finished!\n");
/*	

	 err = paging_alloc(get_current_paging_state(), &vbuf, (1024*1024*800));
    if (err_is_fail(err)) {
        printf("error in paging_alloc: %s\n", err_getstring(err));
        abort();
    }

	char* buf = (char *) vbuf;
	for (int i = 0 ; i < 1024*1024*512; i++)
		buf[i] = i;
*/

	while(1);

   return 0;
}
