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
void serial_putstring(char *str);

struct serial_ring_buffer { 

	char buffer[INPUT_BUF_SIZE];

	size_t head;
	size_t tail;

};

struct serial_capref_ring_buffer { 

	struct capref buffer[INPUT_BUF_SIZE];

	size_t head;
	size_t tail;

};

struct ring_arguments {
	
	struct serial_ring_buffer * r_b;
	struct serial_capref_ring_buffer * r_c;

	struct thread_cond* char_wait_cond;
	struct thread_cond* capref_wait_cond;	
};

void initialize_ring(struct serial_ring_buffer * ring);
void initialize_capref_ring(struct serial_capref_ring_buffer * ring);
char* read_from_ring(struct serial_ring_buffer * ring, char * c);
bool  write_to_ring(struct serial_ring_buffer * ring, char * c);
int poll_serial_thread(void * arg);

int get_char_thread(void *arg);
bool write_capref_to_ring(struct serial_capref_ring_buffer * ring, struct capref * cap);
struct capref * read_capref_from_ring(struct serial_capref_ring_buffer * ring, struct capref * cap);

