#include <stdlib.h>
#include <barrelfish/debug.h>
#include <barrelfish/sys_debug.h>
#include <barrelfish/thread_sync.h>
#include <stdbool.h>

#define INPUT_BUF_SIZE 4096
void test_func(void);

void uart_initialize(lvaddr_t mapped_address);

void serial_putchar(char c);

char serial_getchar(void );

struct serial_ring_buffer { 

	char buffer[INPUT_BUF_SIZE];

	size_t head;
	size_t tail;

	struct thread_mutex ring_lock;
};

void initialize_ring(struct serial_ring_buffer * ring);
char* read_from_ring(struct serial_ring_buffer * ring, char * c);
bool  write_to_ring(struct serial_ring_buffer * ring, char * c);

int poll_serial_thread(void * arg);
