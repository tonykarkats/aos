#include "init.h"
#include <stdlib.h>
#include <string.h>
#include <barrelfish/morecore.h>
#include <barrelfish/dispatcher_arch.h>
#include <barrelfish/debug.h>
#include <barrelfish/lmp_chan.h>
#include <barrelfish/sys_debug.h>
#include <math.h>
#include <barrelfish/aos_rpc.h>
#include "omap_uart.h"
#include <spawndomain/spawndomain.h>
#include "../../lib/spawndomain/arch.h"

errval_t bootstrap_domain(const char *name, struct spawninfo *domain_si, struct bootinfo bi, struct coreid_t my_core_id);
