#include <stdlib.h>
#include <barrelfish/barrelfish.h>
#include <barrelfish_kpi/types.h> 
#include <spawndomain/spawndomain.h>
#include <string.h>
errval_t spawn_second_core(struct bootinfo * bi);
errval_t invoke_monitor_spawn_core(struct capref c_kernel, coreid_t core_id, enum cpu_type cpu_type,
                          forvaddr_t entry);

void print_modules(struct bootinfo *bi);

