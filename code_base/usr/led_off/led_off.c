#include <stdio.h>
#include <barrelfish/debug.h>
#include <barrelfish/barrelfish.h>
#include <barrelfish_kpi/types.h>
#include <barrelfish/aos_rpc.h>
#include "led_off.h"

int main(int argc, char *argv[])
{
	errval_t err;
	
	printf("led_off: Turning led OFF!\n");
	struct capref dev_cap;
	size_t ret_len;
	
	err = aos_rpc_get_dev_cap(get_init_chan(), 0, 0, &dev_cap, &ret_len);
	if (err_is_fail(err)) {
		debug_printf("Can not get device frame!\n");
		abort();
	}
	
	/*
	uint64_t size   = 0x1000;
	uint64_t offset = 0x8020000;
	void * vbuf;	
	err = paging_map_frame(get_current_paging_state(),&vbuf, 0x1000, dev_cap, &offset, &size);
	if (err_is_fail(err)) {
		debug_printf("CAN not map dev frame");
		abort();
	}
	
	led_initialize( (lvaddr_t) vbuf);
	
	*/
	
	return 0;
}
