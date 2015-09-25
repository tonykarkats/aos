#include <kernel.h>
#include <paging_kernel_arch.h>
#include <omap44xx_led.h>

#define GPIO_1_BASE 0x4a310000
#define GPIO_4_BASE 0x48059000

//Output Enable - Data Enable Register addreses
static volatile uint32_t *gpio_1_oe = (uint32_t *)(GPIO_1_BASE + 0x00000134);
static volatile uint32_t *gpio_1_do = (uint32_t *)(GPIO_1_BASE + 0x0000013c);
static volatile uint32_t *gpio_4_oe = (uint32_t *)(GPIO_4_BASE + 0x00000134);
static volatile uint32_t *gpio_4_do = (uint32_t *)(GPIO_4_BASE + 0x0000013c);
//Pad Configuration Register
static volatile uint32_t *gpio_4_mux = (uint32_t *)0x4a1000f4;

//
// LED section
//

/*
 * You will need to implement this function for the milestone 1 extra
 * challenge.
 */
void led_map_register(void)
{
    // TODO: remap GPIO registers in newly setup address space and ensure
    // that led_flash and co use the new address locations.
}

/*
 * Enable/disable led
 * TODO: This function might be useful for the extra challenge in
 * milestone 1.
 */
void led_set_state(bool new_state)
{
}

/*
 * Flash the LED On the pandaboard
 */
__attribute__((noreturn))
void led_flash(void)
{

    //Enable output for the output enable registers
    *gpio_1_oe &= ~0x0100;
    *gpio_4_oe &= ~0x4000;
    long long counter = 0;
    //Set mux mode for gpio_4 respective register
    *gpio_4_mux |= 1 << 16;
    *gpio_4_mux |= 1 << 17;

    while (true) {
	//Write to dataout registers and wait for ~1 sec
	//__nop commands used so that the compiler does not optimize the loop
        *gpio_1_do |= 0x0100;
        *gpio_4_do &= ~0x4000;
        for (counter = 0 ;  counter < 250000000 ; counter++)
            __asm("nop");

        *gpio_1_do &= ~0x0100;
        *gpio_4_do |= 0x4000;
        for (counter = 0 ;  counter < 250000000 ; counter++)
            __asm("nop");
    }

}


