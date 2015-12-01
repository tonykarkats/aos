#include <barrelfish/cross_core.h>
#include <barrelfish/paging.h>

volatile lvaddr_t start_of_ump_frame;

volatile lvaddr_t core_0_flag;
volatile lvaddr_t core_0_slot;

volatile lvaddr_t core_1_flag;
volatile lvaddr_t core_1_slot;

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

errval_t map_shared_frame(void **buf, bool init_frame) 
{
	errval_t err;

	struct capref ump_frame = {
		.cnode = cnode_task,
		.slot = TASKCN_SLOT_UMPFRAME,
	};

	struct frame_identity fid;
	invoke_frame_identify(ump_frame, &fid);

	// debug_printf("map_shared_frame: Base of frame is 0x%x\n", fid.base);	

	err = paging_map_frame_attr(get_current_paging_state(), buf, 4096, ump_frame, DEVICE_FLAGS, NULL, NULL);
	if (err_is_fail(err)) {
		debug_printf("Can not allocate and map for UMP shared frame!\n");
		return err;
	}

 	start_of_ump_frame = (lvaddr_t) *buf;
	
	core_0_flag = (lvaddr_t) *buf;
	core_0_slot = (lvaddr_t) *buf + 4;

	core_1_flag = (lvaddr_t) *buf + 4 + sizeof(struct ump_message);
	core_1_slot = (lvaddr_t) *buf + 4 + sizeof(struct ump_message) + 4; 

	if (init_frame)
		memset( *buf, 0, 4096);
	
	return SYS_ERR_OK;
}

void write_to_core_0(struct ump_message mess) 
{
	while(*(uint32_t *) core_0_flag == 1) {;}

 	* (struct ump_message *) core_0_slot = mess;
	
	*(uint32_t *) core_0_flag = 1;
}

struct ump_message read_from_core_0(void) 
{
	while(*(uint32_t *) core_0_flag == 0) {;}

	struct ump_message temp_message = * (struct ump_message *) core_0_slot;

	*(uint32_t *) core_0_flag = 0;

	return temp_message;
}

void write_to_core_1(struct ump_message mess) 
{
	while(*(uint32_t *) core_1_flag == 1) {;}

 	* (struct ump_message *) core_1_slot = mess;
	
	*(uint32_t *) core_1_flag = 1;
}

struct ump_message read_from_core_1(void) 
{
	while(* (uint32_t *) core_1_flag == 0) { ; }

	struct ump_message temp_message = * (struct ump_message *) core_1_slot;

	*(uint32_t *) core_1_flag = 0;

	return temp_message;
}

