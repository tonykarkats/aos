#include <stdio.h>
#include <barrelfish/debug.h>
#include <barrelfish/barrelfish.h>
#include <barrelfish_kpi/types.h>
#include "led_off.h"

int main(int argc, char *argv[])
{
	debug_printf("led_on: Turning led OFF!\n");

	while(1);
    return 0;
}
