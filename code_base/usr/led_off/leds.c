
#include "leds.h"

static volatile lvaddr_t gpio1_base;
static volatile lvaddr_t gpio1_oe;
static volatile lvaddr_t gpio1_do;

void led_initialize(lvaddr_t mapped_address) {

	gpio1_base = mapped_address;
	gpio1_oe  = gpio1_base + 0x00000134;
	gpio1_do  = gpio1_base + 0x0000013c;

	
	debug_printf("mapped_addreess %p , gpio1_base %p oe = %p do = %p\n", mapped_address, gpio1_base, gpio1_oe, gpio1_do);
}

void turn_on_led1(void) {
	
	//debug_printf("content %x\n", *gpio1_do);
	* (lvaddr_t *)gpio1_oe &= ~0x0100;
	* (lvaddr_t *)gpio1_do |= 0x0100;
	//debug_printf("content %x\n", *gpio1_do);
	return;
} 

void turn_off_led1(void) {

	* (lvaddr_t *)gpio1_oe &= ~0x0100;
	* (lvaddr_t *)gpio1_do &= ~0x0100;

	return;
}
