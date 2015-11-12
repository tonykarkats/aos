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

/*
static void custom_printf(const char *cp) {
  char c;
  while ((c=*(cp++))) {
  	aos_rpc_serial_putchar(get_init_chan(), c);
  }
}
*/

#define BUFSIZE_2 (128UL*1024*1024)
#define MALLOC_BUFSIZE 1   //(1UL<<20)
#define BUFSIZE 32L * 1024 * 1024
#define SAFE_VADDR (1UL<<25)

#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)

//static int thread_id = 0;
/*
static int shell_thread(void) 
{
	errval_t err, err_1, err_2;

	char command[1024];
	size_t offset = 0;

	struct aos_rpc * ch = get_init_chan();
	
	err = aos_rpc_serial_putchar(ch, '$');
	while(1){
		
		err_1 = aos_rpc_serial_getchar(ch, command + offset);
		if ( *(command+offset) == '\r') {
			err_1 = aos_rpc_serial_putchar(ch , '\n');
			command[offset+1] = '\0';
			offset = 0;
			err_1 = aos_rpc_serial_putchar(ch, '$');
		
			
		}
		else	
			err_2 = aos_rpc_serial_putchar(ch, *(command + offset));
		
		offset++;	
	}

	return 1;
}
*/ 
/*
static int test_thread(void){

	errval_t err;

	debug_printf("Hello from thread-%d!\n",thread_id);

	void * vbuf;	
	err = paging_alloc(get_current_paging_state(), &vbuf, (2*4096));
    if (err_is_fail(err)) {
        debug_printf("error in paging_alloc: %s\n", err_getstring(err));
        abort();
    }

	char* buf = (char *) vbuf;


	buf[0] = 66;
	buf[4096] = 77;

	debug_printf("%d %d\n", buf[0], buf[4096]);

	thread_id++;
	return 0;
}
*/ 

int main(int argc, char *argv[])
{
	
	//errval_t err;


	printf("Should have aborted...\n");
	abort();
/*	
	err = aos_rpc_send_string(test_rpc, "Hello"); 	
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Failure in sending string!!\n");
		abort();
	}

	err = aos_rpc_serial_putchar(test_rpc, 'H'); 	
	err = aos_rpc_serial_putchar(test_rpc, 'E'); 	
	err = aos_rpc_serial_putchar(test_rpc, 'L'); 	
	err = aos_rpc_serial_putchar(test_rpc, 'L'); 	
	err = aos_rpc_serial_putchar(test_rpc, 'O'); 	
	err = aos_rpc_serial_putchar(test_rpc, '\n'); 	

	char c1,c2,c3,c4;	
	err = aos_rpc_serial_getchar(test_rpc, &c1); 	
	err = aos_rpc_serial_getchar(test_rpc, &c2); 	
	err = aos_rpc_serial_getchar(test_rpc, &c3); 	
	err = aos_rpc_serial_getchar(test_rpc, &c4); 	

	err = aos_rpc_serial_putchar(test_rpc, c1); 	
	err = aos_rpc_serial_putchar(test_rpc, c2); 	
	err = aos_rpc_serial_putchar(test_rpc, c3); 	
	err = aos_rpc_serial_putchar(test_rpc, c4); 	

	struct thread* t = thread_create((thread_func_t)  test_thread, NULL);
	
	int ret_val;
	thread_join(t, &ret_val);
	
	debug_printf("main: Thread finished!\n");

	struct thread* t = thread_create((thread_func_t) shell_thread, NULL);
	
	int ret_val;
	thread_join(t, &ret_val);

 	test_rpc = test_rpc;
	err = SYS_ERR_OK;	
*/
	while(1);

   return 0;
}
