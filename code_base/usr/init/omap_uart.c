#include <stdlib.h>
#include <string.h>
#include <barrelfish/debug.h>
#include <barrelfish/sys_debug.h>
#include "omap_uart.h"

static volatile lvaddr_t uart3_base;
static volatile lvaddr_t uart3_lsr;
static volatile lvaddr_t uart3_thr;
static volatile lvaddr_t uart3_fcr;
static volatile lvaddr_t uart3_ier;
static volatile lvaddr_t uart3_lcr;

void uart_initialize(lvaddr_t mapped_address){

	uart3_base = mapped_address;
	uart3_thr = mapped_address + 0x00;
	uart3_ier = mapped_address + 0x04;
	uart3_lsr = mapped_address + 0x14;
	uart3_fcr = mapped_address + 0x08;
	uart3_lcr = mapped_address + 0x0C;

	*(char *) uart3_ier = 0;
	*(char *) uart3_fcr = 0xf1;
	*(char *) uart3_lcr = 0x03;
}

void serial_putchar(char c) {

	if (c == '\n')
		serial_putchar('\r');

	while ((!(* (char * ) uart3_lsr )) & 0x20);

	*(char *)uart3_thr = c;
}

char serial_getchar(void) {

	while (!(* (char *) uart3_lsr & 0x01));

	return (char) *(char *) uart3_thr;
}

static int poll_serial_thread(void) {

	while(1) {
		// TODO
	}
	return 1;	
}


