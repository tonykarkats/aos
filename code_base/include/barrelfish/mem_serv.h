#include <stdio.h>
#include <barrelfish/barrelfish.h>
#include <spawndomain/spawndomain.h>

errval_t initialize_mem_serv(struct bootinfo * bi);
errval_t memserv_alloc(struct capref *ret, uint8_t bits, genpaddr_t minbase, genpaddr_t maxlimit, genpaddr_t *retbase);
errval_t memserv_free (struct capref ram_cap, genpaddr_t base, uint8_t bits);


