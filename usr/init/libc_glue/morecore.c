
#include <stdint.h>
#include <stdlib.h>
#include <morecore.h>
#include <debug.h>
#include "helpers.h"

// barebones make-C-library-compile morecore skeleton

static struct morecore_state morecore_st = {
    .header_base.x = 0,
    .header_freep = 0,
};

typedef void *(*morecore_alloc_func_t)(size_t bytes, size_t *retbytes);
extern morecore_alloc_func_t sys_morecore_alloc;

typedef void (*morecore_free_func_t)(void *base, size_t bytes);
extern morecore_free_func_t sys_morecore_free;

static void*
morecore_alloc(size_t bytes, size_t *retbytes)
{
    return NULL;
}

static void
morecore_free(void *base, size_t bytes)
{
    return;
}

void
morecore_init(void)
{
    sys_morecore_alloc = morecore_alloc;
    sys_morecore_free = morecore_free;
}

struct morecore_state*
get_morecore_state(void)
{
    return &morecore_st;
}

Header*
get_malloc_freep(void)
{
    return get_morecore_state()->header_freep;
}

