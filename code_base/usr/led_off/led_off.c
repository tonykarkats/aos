#include <stdio.h>
#include <barrelfish/debug.h>
#include <barrelfish/barrelfish.h>
#include <barrelfish_kpi/types.h>
#include <barrelfish/aos_rpc.h>
#include "led_off.h"
#include "leds.h"

int main(int argc, char *argv[])
{
	errval_t err;
	
	struct capref dev_cap;
	size_t ret_len;

	err = aos_rpc_get_dev_cap(get_init_chan(), 0x4A310000, 4096, &dev_cap, &ret_len);
	if (err_is_fail(err)) {
		debug_printf("Can not get device frame!\n");
		abort();
	}

	if (capref_is_null(dev_cap))
		printf("Got null dev?!\n");

	void * vbuf;	
	err = paging_map_frame_attr(get_current_paging_state(), &vbuf, 4096, dev_cap, DEVICE_FLAGS, NULL, NULL);
	if (err_is_fail(err)) {
		printf("CAN not map dev frame");
		return 1;
	}
	
	led_initialize((lvaddr_t) vbuf);

	turn_off_led1();	

	return 0;
}
