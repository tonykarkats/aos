#ifndef LIBSOS_MORECORE_H
#define LIBSOS_MORECORE_H

#include <k_r_malloc.h>

struct morecore_state {
    Header header_base;
    Header *header_freep;
};

void morecore_init(void);
struct morecore_state* get_morecore_state(void);
Header* get_malloc_freep(void);

#endif // LIBSOS_MORECORE_H
