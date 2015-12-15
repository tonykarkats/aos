#include <stdlib.h>
#include <barrelfish/barrelfish.h>
#include <barrelfish/capabilities.h>
#include <barrelfish_kpi/types.h> 
#include <spawndomain/spawndomain.h>
#include <string.h>
#include <elf/elf.h>
#include <barrelfish_kpi/arm_core_data.h>
#include <barrelfish/paging.h>

errval_t map_aux_core_registers(void);

errval_t spawn_second_core(struct bootinfo * bi, lvaddr_t aux_core_0, lvaddr_t aux_core_1);

errval_t invoke_monitor_spawn_core(coreid_t core_id, enum cpu_type cpu_type,
                          forvaddr_t entry);

void print_modules(struct bootinfo *bi);

