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

static int test_thread(void *arg){

	errval_t err;
	void* vbuff;
	int size = * (int *) arg;
	printf("Running memory test for %d bytes!\n", size);	

	err = paging_alloc( get_current_paging_state(), &vbuff, size);
	
	char * buf = (char *) vbuff;
	for (int i = 0; i < size; i++) 
		buf[i] = i%255;

	for (int i = 0; i < size; i++) 
		assert(buf[i] == i%255);

	printf("Memory test passed!\n");	
	 	
	return 0;
}


int main(int argc, char *argv[])
{
	
	errval_t err;

	debug_printf("Hello world from memeater!\n");

    void * vbuff; 
	int size = 1024*1024*5;
	err = paging_alloc( get_current_paging_state(), &vbuff, size);
	
	char * buf = (char *) vbuff;
   	for (int i = 0; i < size; i++)
       	buf[i] = i%255;

   	for (int i = 0; i < size; i++)
   	    assert(buf[i] == i%255);


	debug_printf("Memory test passed!\n");

	
	char command[1024];
	const char space_token[2] = " ";
	char *token;
	while(1) {
		printf("$>");
		fflush(stdout);
		memset(command, 0, 1024);
		gets(command);
		
		token = strtok(command, space_token);
		
		if (!strcmp("echo", token)) {
			token = strtok(NULL, space_token);
			printf("%s\n", token);
		}
		else if (!strcmp("run_memtest", token)) {
			token = strtok(NULL, space_token);
			int memory_size = atoi(token);
			struct thread* t = thread_create((thread_func_t)  test_thread, &memory_size);
			int ret_val;
			thread_join(t, &ret_val);
		}
		else if (!strcmp("exit", token)) {
			printf("BY BY BABY!\n");
			break;
		}
	}
	

    return 0;
}
