#include <barrelfish/barrelfish.h>
#include <barrelfish_kpi/types.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[])
{

	size_t stress_size = 4096;//atoi(argv[1]);
	debug_printf("stress_paging: Initializing Stress Paging for %zu bytes!\n", stress_size);

	errval_t err;
	void *vbuff;
    err = paging_alloc( get_current_paging_state(), &vbuff, stress_size);
    
    char * buf = (char *) vbuff;
    for (int i = 0; i < stress_size; i++) 
        buf[i] = i%255;

    for (int i = 0; i < stress_size; i++) 
        assert(buf[i] == i%255);

    printf("Memory test passed!\n"); 	


	while(1);
    return 0;
}
