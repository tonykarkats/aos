#include <stdlib.h>
#include <string.h>
#include <barrelfish/debug.h>
#include <barrelfish/sys_debug.h>
#include <barrelfish/barrelfish.h>
#include "omap_uart.h"
#include <barrelfish/lmp_chan.h>

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

int get_char_thread(void *arg) 
{
	errval_t err;
	struct ring_arguments* r = (struct ring_arguments *) arg;	
	struct serial_ring_buffer  * ring = r->r_b;
	struct serial_capref_ring_buffer * capref_buffer = r->r_c;
	struct thread_cond * char_cond = r->char_wait_cond;
	struct thread_cond * capref_cond = r->capref_wait_cond;
	
	debug_printf("get_char_thread: Initiating...\n");
	char in_c;

	while(true) {	
		// debug_printf("Will read a char and a capref and transmit it!\n");
		struct capref remep;
		struct capref *p_remep;

		//debug_printf("get_char_thread: Character read.. going to read capref!\n");
		while(true) {
			p_remep = read_capref_from_ring(capref_buffer, &remep);	
			if (p_remep != NULL)
				break;
			thread_cond_wait(capref_cond, NULL);
		}

		while(true) {
			char * ret_char = read_from_ring(ring, &in_c);
			if (ret_char != NULL){
				break;
			}	
			thread_cond_wait(char_cond, NULL);
		}
			
		if (in_c != 13)
			serial_putchar(in_c);
		else { 
			serial_putchar('\n');
			in_c = '\n';
		}
	
		err = lmp_ep_send1(remep, LMP_SEND_FLAGS_DEFAULT, NULL_CAP, in_c);
		if (err_is_fail(err)) {
				DEBUG_ERR(err,"get_char_thread: Can not send character back to client!\n");
		}	

		cap_destroy(remep);
	}

	return 1;
}

int poll_serial_thread(void * arg) {

	struct serial_ring_buffer * ring = ( (struct ring_arguments *) arg )->r_b;
	char c;
	struct thread_cond * char_cond = ( (struct ring_arguments *) arg )->char_wait_cond;
 
	while(1) {
		thread_yield();
		c = serial_getchar();
		//debug_printf("poll_serial_thread: Got input from user c = %c will put it at tail %d\n", c, ring->tail);
		bool ret = write_to_ring(ring, &c);
		thread_cond_signal(char_cond);
		if (!ret) 
			; //debug_printf("poll_serial_thread: Ring buffer is full ! User input is dropped \n!");
	}

	return 1;	
}

void initialize_capref_ring(struct serial_capref_ring_buffer * ring) {

	ring->head = 0;
	ring->tail = 0;
}

void initialize_ring(struct serial_ring_buffer* ring) {

	ring->head = 0;
	ring->tail = 0;

}

struct capref * read_capref_from_ring(struct serial_capref_ring_buffer * ring, struct capref * cap) {

	
	size_t head = ring->head;
	size_t tail = ring->tail;

	if (head == tail) {
		//debug_printf("NULL CAPREF!\n");
		return NULL;
	}
		
	*cap = ring->buffer[head];
	ring->head = (head+1) % INPUT_BUF_SIZE;
	
	return cap;
}

bool write_capref_to_ring (struct serial_capref_ring_buffer * ring, struct capref * cap) {

	size_t head = ring->head;
	size_t tail = ring->tail;

	if ( (tail + 1)%INPUT_BUF_SIZE == head) {
		return false;
	}
	
	//debug_printf("Writing capref to ring. Tail = %d\n", ring->tail);
	ring->buffer[tail] = *cap;
	ring->tail = (tail+1) % INPUT_BUF_SIZE;

	return true	;
}

char * read_from_ring(struct serial_ring_buffer * ring, char * c) {

	
	size_t head = ring->head;
	size_t tail = ring->tail;

	// debug_printf("read_from_ring: Reading from ring! Head = %d , Tail = %d\n", ring->head, ring->tail);
	if (head == tail) {
		//debug_printf("Ring is null!\n");
		return NULL;
	}
		
	*c = ring->buffer[head];
	ring->head = (head+1) % INPUT_BUF_SIZE;
	
	//thread_mutex_unlock(&ring->ring_lock);

	return c;
}

bool write_to_ring (struct serial_ring_buffer * ring, char * c) {

	size_t head = ring->head;
	size_t tail = ring->tail;


	if ( (tail + 1)%INPUT_BUF_SIZE == head) {
		return false;
	}

	//debug_printf("write_to_ring: Writing to ring! Ring tail = %d\n", ring->tail);
	ring->buffer[tail] = *c;
	ring->tail = (tail+1) % INPUT_BUF_SIZE;

	return true	;
}

