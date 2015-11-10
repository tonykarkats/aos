#include <stdlib.h>
#include <string.h>
#include <barrelfish/morecore.h>
#include <barrelfish/dispatcher_arch.h>
#include <barrelfish/debug.h>
#include <barrelfish/lmp_chan.h>
#include <barrelfish/sys_debug.h>
#include <math.h>
#include <barrelfish/aos_rpc.h>
#include <dev/omap/omap_uart_dev.h>

void uart_initialize(lvaddr_t mapped_address);

void serial_putchar(char c);

char serial_getchar(void );
