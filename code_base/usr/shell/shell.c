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
	
	char command[1024];
	const char space_token[2] = " ";
	char *token;
	char *next_token;
	size_t dir_entries;

	domainid_t did_2;
	int sp = 1;
	while(1) {
		err = aos_rpc_process_spawn(get_init_chan(), "led_on", 0, &did_2);
		debug_printf("SPAWNED %d\n", sp++);
	}



	while(1) {
		printf("$>");
		fflush(stdout);
		memset(command, 0, 1024);
		gets(command);
		
		if (!strcmp(command, "\n"))
			continue;
	
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
		else if (!strcmp("ps", token)) {
			domainid_t * pids;
				
			size_t pid_count;
			err = aos_rpc_process_get_all_pids(get_init_chan(), &pids, &pid_count);
			if (err_is_fail(err)) {
				printf("Could not fetch pids from server!\n");
				continue;
			}
			
			char * domain_name;
			for (int i = 0; i < pid_count; i++) {
				err = aos_rpc_process_get_name(get_init_chan(), pids[i], &domain_name);	
				if (err_is_ok(err)) 
					printf("pid: %d name: %s	", pids[i], domain_name); 
				free(domain_name);
			}
			printf("\n");
		
			free(pids);	
		}	
		else if (!strcmp("oncore", token)) {
			token = strtok(NULL, space_token);
			next_token = strtok(NULL, space_token);
			if (next_token == NULL)
				continue;

			int core_id = atoi(token);
			if ((core_id !=0 ) && (core_id != 1))	
				continue;

			// debug_printf("Will spawn %s to core %d\n", next_token, core_id);		

			domainid_t pid;
			err = aos_rpc_process_spawn(get_init_chan(), next_token, core_id, &pid);
			if (err_is_fail(err) || (pid == 0))
				printf("Could not spawn domain [%s]\n", next_token);
			else 
				printf("Domain spawned with pid = %d\n", pid);
		}
		else if (!strcmp("ls", token)) {
			token = strtok(NULL, space_token);
			struct aos_dirent * dirtable;
			if (token == NULL)
				continue;
			//debug_printf("Will ls path %s\n", token);
			
			err = aos_rpc_readdir( get_init_chan(), token, &dirtable, &dir_entries);
			if (err_is_fail(err)) {
				printf("%s not found!\n", token);
			}
			else {
				// debug_printf("entries = %"PRIu32"\n", dir_entries);
				for (int i = 0; i < dir_entries; i++) {
					printf("%s %"PRIu32" | ", dirtable[i].name, dirtable[i].size);
				}	
				printf("\n");
				
				free(dirtable);
			}

			continue;
		}
		else if (!strcmp("cat", token)) {	
			token = strtok(NULL, space_token);
			if (token == NULL)
				continue;

			int fd;
			void *fbuf;
			size_t buflen;
			char temp_buf[5001];
			int pos = 0;

			err = aos_rpc_open(get_init_chan(), token, &fd);
			if (err_is_fail(err)) {
				printf("Can not open file %s\n", token);
				continue;
			}
			else {
				printf("Got fd %d \n", fd);
			}
	
			// Reading the whole file!			
			while (1) {
				err = aos_rpc_read(get_init_chan(), fd, pos, 5000, &fbuf, &buflen);
				if (err_is_fail(err)) {
					debug_printf("Can not read from file ! with fd %d\n", fd);		
				}
				//debug_printf("size %"PRIu32"\n", buflen);	
				if (buflen == 0)
					break;
	

				pos += buflen;
				memcpy(temp_buf, fbuf, buflen);
				
				free(fbuf);
				
				temp_buf[buflen] = '\0';							
				printf("%s", temp_buf);
				fflush(stdout);
			}		

			err = aos_rpc_close(get_init_chan(),fd);
			if (err_is_fail(err)) {
				printf("Can not close fd %d\n", fd);
			}
			else {
				printf("Closed fd %d \n", fd);
			}

		}
		else if (!strcmp("exit", token)) {
			return 0;
		}
	}		
			
	return 0;
}
