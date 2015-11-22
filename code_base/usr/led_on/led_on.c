#include <barrelfish/barrelfish.h>
#include <barrelfish_kpi/types.h>
#include <barrelfish/aos_rpc.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "led_on.h"
#include "leds.h"

int main(int argc, char *argv[])
{
	errval_t err;
	
	printf("led_on: Turning led ON!\n");
	struct capref dev_cap;
	size_t ret_len;
	
	err = aos_rpc_get_dev_cap(get_init_chan(), 0, 0, &dev_cap, &ret_len);
	if (err_is_fail(err)) {
		debug_printf("Can not get device frame!\n");
		abort();
	}

	uint64_t ret_size;	
	uint64_t size   = 0x1000;
	uint64_t offset = 0xA310000;
	void * vbuf;	
	err = paging_map_frame(get_current_paging_state(),&vbuf, size, dev_cap, &offset, &ret_size);
	if (err_is_fail(err)) {
		debug_printf("CAN not map dev frame");
		abort();
	}
	
	led_initialize((lvaddr_t) vbuf);

	turn_on_led1();	
	
	return 0;
}
