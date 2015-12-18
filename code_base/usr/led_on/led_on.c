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
	
	struct capref dev_cap;
	size_t ret_len;

	printf("Hello world from led_on!\n");


	err = aos_rpc_get_dev_cap(get_init_chan(), 0x4A310000, 4096, &dev_cap, &ret_len);
	if (err_is_fail(err)) {
		debug_printf("Can not get device frame!\n");
		return 1;
	}

	if (capref_is_null(dev_cap)) {
		debug_printf("Got null dev?!\n");
		return 1;
	}

	void * vbuf;	
	err = paging_map_frame_attr(get_current_paging_state(), &vbuf, 4096, dev_cap, DEVICE_FLAGS, NULL, NULL);
	if (err_is_fail(err)) {
		printf("CAN not map dev frame");
		return 1;
	}
	
	led_initialize((lvaddr_t) vbuf);

	turn_on_led1();	
	
	return 0;
}
