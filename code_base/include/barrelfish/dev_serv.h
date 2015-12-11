#include <barrelfish/barrelfish.h>
#include <mm/mm.h>

errval_t get_devframe(struct capref * ret, size_t * retlen, lpaddr_t start_addr, size_t length);
errval_t init_devserver(void);
