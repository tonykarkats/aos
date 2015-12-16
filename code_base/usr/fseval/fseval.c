#include <barrelfish/barrelfish.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <omap_timer/timer.h>
#include <barrelfish/aos_rpc.h>

int main(int argc, char *argv[])
{
    
    errval_t err;

    err = omap_timer_init();
    if (err_is_fail(err)) {
    	debug_printf("Error in initializing the timer!\n");
    	abort();
    }
    
    omap_timer_ctrl(true);
    
    int fd;
    void *fbuf;
    size_t buflen;
    int pos = 0;
    uint64_t start, end;
    
    err = aos_rpc_open(get_init_chan(), "/armv7/text/text1", &fd);
    if (err_is_fail(err)) {
    	printf("Can not open file %s\n", "/armv7/sbin/led_on");
    }
    else {
    	printf("Got fd %d \n", fd);
    }
    
    start = omap_timer_read();
    // debug_printf("%"PRIu64"\n", start);
    while (1) {
    	err = aos_rpc_read(get_init_chan(), fd, pos, 5000, &fbuf, &buflen);
    	if (err_is_fail(err)) {
    		debug_printf("Can not read from file ! with fd %d\n", fd);		
    	}
    	//debug_printf("size %"PRIu32"\n", buflen);	
    	if (buflen == 0)
    		break;
    
    	pos += buflen;	
    	free(fbuf);
    }		

    end = omap_timer_read();

    err = aos_rpc_close(get_init_chan(),fd);
    if (err_is_fail(err)) {
    	printf("Can not close fd %d\n", fd);
    }
    else {
    	printf("Closed fd %d \n", fd);
    }
    		
    // debug_printf("size = %" PRIu32 " time %" PRIu64 "\n", pos, end-start);


    pos = 0;			
    err = aos_rpc_open(get_init_chan(), "/armv7/text/text2", &fd);
    if (err_is_fail(err)) {
    	printf("Can not open file %s\n", "/armv7/sbin/text2");
    }
    else {
    	printf("Got fd %d \n", fd);
    }
    
    start = omap_timer_read();

    while (1) {
    	err = aos_rpc_read(get_init_chan(), fd, pos, 5000, &fbuf, &buflen);
    	if (err_is_fail(err)) {
    		debug_printf("Can not read from file ! with fd %d\n", fd);		
    	}
    	//debug_printf("size %"PRIu32"\n", buflen);	
    	if (buflen == 0)
    		break;
    
    	pos += buflen;	
    	free(fbuf);
    }		

    end = omap_timer_read();

    err = aos_rpc_close(get_init_chan(),fd);
    if (err_is_fail(err)) {
    	printf("Can not close fd %d\n", fd);
    }
    else {
    	printf("Closed fd %d \n", fd);
    }
    		
    debug_printf("size = %" PRIu32 " time %" PRIu64 "\n", pos, end-start);
 
    pos = 0;
    err = aos_rpc_open(get_init_chan(), "/armv7/text/text3", &fd);
    if (err_is_fail(err)) {
    	printf("Can not open file %s\n", "/armv7/sbin/text3");
    }
    else {
    	printf("Got fd %d \n", fd);
    }
    
    start = omap_timer_read();
    while (1) {
    	err = aos_rpc_read(get_init_chan(), fd, pos, 5000, &fbuf, &buflen);
    	if (err_is_fail(err)) {
    		debug_printf("Can not read from file ! with fd %d\n", fd);		
    	}
    	//debug_printf("size %"PRIu32"\n", buflen);	
    	if (buflen == 0)
    		break;
    
    	pos += buflen;	
    	free(fbuf);
    }		

    end = omap_timer_read();

    err = aos_rpc_close(get_init_chan(),fd);
    if (err_is_fail(err)) {
    	printf("Can not close fd %d\n", fd);
    }
    else {
    	printf("Closed fd %d \n", fd);
    }
    		
    debug_printf("size = %" PRIu32 " time %" PRIu64 "\n", pos, end-start);
 
 
    return 0;
}
