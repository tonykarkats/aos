#include <barrelfish/barrelfish.h>
#include <barrelfish_kpi/types.h>
#include <barrelfish_kpi/init.h>



//#define AUX_CORE_BOOT_0 ((lpaddr_t)0x48281800)

int get_core_id(struct bootinfo * bi);
void poll_for_core(void);
void signal_core_0(void);
errval_t map_shared_frame(void **buf);
