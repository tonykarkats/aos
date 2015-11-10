#include <stdlib.h>
#include <barrelfish/debug.h>
#include <barrelfish/sys_debug.h>

void test_func(void);

void uart_initialize(lvaddr_t mapped_address);

void serial_putchar(char c);

char serial_getchar(void );
