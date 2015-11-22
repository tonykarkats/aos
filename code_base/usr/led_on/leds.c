
#include "leds.h"

static volatile uint32_t * gpio1_base;
static volatile uint32_t * gpio1_oe;
static volatile uint32_t * gpio1_do;

void led_initialize(uint32_t mapped_address) {

	gpio1_base = (uint32_t *)mapped_address;
	gpio1_oe  = gpio1_base + 0x00000134;
	gpio1_do  = gpio1_base + 0x0000013c;

	debug_printf("difference %d difference %d", gpio1_oe - gpio1_base, gpio1_do- gpio1_base);

}

void turn_on_led1(void) {
	
	debug_printf("content %x\n", *gpio1_do);
	*gpio1_oe &= ~0x0100;
	*gpio1_do &= 0x0100;
	debug_printf("content %x\n", *gpio1_do);
	return;
} 

void turn_off_led1(void) {

	return;
}
