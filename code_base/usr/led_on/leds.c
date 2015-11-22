
#include "leds.h"

static volatile lvaddr_t gpio1_base;
static volatile lvaddr_t gpio1_oe;
static volatile lvaddr_t gpio1_do;

void led_initialize(lvaddr_t mapped_address) {

	gpio1_base = mapped_address;
	gpio1_oe  = mapped_address + 0x00000134;
	gpio1_do  = mapped_address + 0x0000013c;
}

void turn_on_led1(void) {

	return;
} 

void turn_off_led1(void) {

	return;
}
