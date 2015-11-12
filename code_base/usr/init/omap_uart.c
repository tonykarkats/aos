#include <stdlib.h>
#include <string.h>
#include <barrelfish/debug.h>
#include <barrelfish/sys_debug.h>
#include <barrelfish/barrelfish.h>
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

	while (! (((* (char * ) uart3_lsr )) & 0x20));

	*(char *)uart3_thr = c;
}

char serial_getchar(void) {

	while (! ((* (char *) uart3_lsr & 0x01)));

	return (char) *(char *) uart3_thr;
}

void serial_putstring(char *str) {

	int printed = 0;
	
	while (1) {
		if ( *(str + printed) == '\0')
			break;

		serial_putchar(*(str + printed)); 
		
		printed++;
		if (printed == 32)
			break;
	}

}

int poll_serial_thread(void * arg) {

	struct serial_ring_buffer * ring = (struct serial_ring_buffer *) arg;
	char c;
	
	while(1) {
		c = serial_getchar();
		//debug_printf("poll_serial_thread: Got input from user c = %c\n", c);
		bool ret = write_to_ring(ring, &c)	;
		if (!ret) 
			; //debug_printf("poll_serial_thread: Ring buffer is full ! User input is dropped \n!");
	}

	return 1;	
}

void initialize_ring(struct serial_ring_buffer* ring) {

	ring->head = 0;
	ring->tail = 0;

	//thread_mutex_init(&ring->ring_lock);
}

char * read_from_ring(struct serial_ring_buffer * ring, char * c) {

	
	//while (!thread_mutex_trylock(&ring->ring_lock)) ;
	
	size_t head = ring->head;
	size_t tail = ring->tail;

	if (head == tail) {
		//thread_mutex_unlock(&ring->ring_lock);
		return NULL;
	}
		
	*c = ring->buffer[head];
	ring->head = (head+1) % INPUT_BUF_SIZE;
	
	//thread_mutex_unlock(&ring->ring_lock);

	return c;
}

bool write_to_ring (struct serial_ring_buffer * ring, char * c) {

	//thread_mutex_lock(&ring->ring_lock);

	size_t head = ring->head;
	size_t tail = ring->tail;

	if ( (tail + 1)%INPUT_BUF_SIZE == head) {
		//thread_mutex_unlock(&ring->ring_lock);
		return false;
	}

	ring->buffer[tail] = *c;
	ring->tail = (tail+1) % INPUT_BUF_SIZE;


	//thread_mutex_unlock(&ring->ring_lock);

	return true	;
}

