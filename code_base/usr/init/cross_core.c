#include <cross_core.h>

static volatile lvaddr_t cross_core_register = 0x48281800;

int get_core_id(struct bootinfo * bi) {

	return bi->coreid;
}

void poll_for_core(void) {
	
	while ( *(lvaddr_t *) cross_core_register != 1) {
		; //debug_printf("Read %zu \n", (*(uint32_t *) AUX_CORE_BOOT_0));
	}
}

void signal_core_0 (void) {

	*(lvaddr_t *) cross_core_register = 1;
	
	//debug_printf("Signaled with %zu \n", (*(uint32_t *) AUX_CORE_BOOT_0));
}

