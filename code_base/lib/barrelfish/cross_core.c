#include <barrelfish/cross_core.h>
#include <barrelfish/paging.h>

volatile lvaddr_t start_of_ump_frame;

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

errval_t map_shared_frame(void **buf) 
{
	errval_t err;

	struct capref ump_frame = {
		.cnode = cnode_task,
		.slot = TASKCN_SLOT_UMPFRAME,
	};

	struct frame_identity fid;
	invoke_frame_identify(ump_frame, &fid);

	debug_printf("map_shared_frame: Base of frame is 0x%x\n", fid.base);	

	//uint64_t offset = 0;
	//size_t size = 4096;

	err = paging_map_frame_attr(get_current_paging_state(), buf, 4096, ump_frame, DEVICE_FLAGS, NULL, NULL);
	if (err_is_fail(err)) {
		debug_printf("Can not allocate and map for UMP shared frame!\n");
		return err;
	}

 	start_of_ump_frame = (lvaddr_t) *buf;

	return SYS_ERR_OK;
}
