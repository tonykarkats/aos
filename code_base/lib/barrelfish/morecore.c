/**
 * \file
 * \brief Morecore implementation for malloc
 */

/*
 * Copyright (c) 2007, 2008, 2009, 2010, 2011, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#include <barrelfish/barrelfish.h>
#include <barrelfish/core_state.h>
#include <barrelfish/morecore.h>
#include <barrelfish/paging.h>
#include <stdio.h>

typedef void *(*morecore_alloc_func_t)(size_t bytes, size_t *retbytes);
extern morecore_alloc_func_t sys_morecore_alloc;

typedef void (*morecore_free_func_t)(void *base, size_t bytes);
extern morecore_free_func_t sys_morecore_free;

// this define makes morecore use an implementation that just has a static
// 16MB heap.
//#define USE_STATIC_HEAP


#define HEAP_SIZE (128*1024*1024)

#ifdef USE_STATIC_HEAP

// dummy mini heap (16M)
static char mymem[HEAP_SIZE] = { 0 };
//static char *endp = mymem + HEAP_SIZE;

/**
 * \brief Allocate some memory for malloc to use
 *
 * This function will keep trying with smaller and smaller frames till
 * it finds a set of frames that satisfy the requirement. retbytes can
 * be smaller than bytes if we were able to allocate a smaller memory
 * region than requested for.
 */
static void *morecore_alloc(size_t bytes, size_t *retbytes)
{
    struct morecore_state *state = get_morecore_state();

    char *freep = state->freep;

    size_t aligned_bytes = ROUND_UP(bytes, sizeof(Header));
    void *ret = NULL;
    if (freep + aligned_bytes < endp) {
        ret = freep;
        freep += aligned_bytes;
    }
    else {
        aligned_bytes = 0;
    }
    *retbytes = aligned_bytes;
    return ret;
}

static void morecore_free(void *base, size_t bytes)
{
    return;
}

errval_t morecore_init(void)
{
    struct morecore_state *state = get_morecore_state();

    thread_mutex_init(&state->mutex);

    state->freep = mymem;

    sys_morecore_alloc = morecore_alloc;
    sys_morecore_free = morecore_free;
    return SYS_ERR_OK;
}

#else
// dynamic heap using lib/barrelfish/paging features

/**
 * \brief Allocate some memory for malloc to use
 *
 * This function will keep trying with smaller and smaller frames till
 * it finds a set of frames that satisfy the requirement. retbytes can
 * be smaller than bytes if we were able to allocate a smaller memory
 * region than requested for.
 */
#endif

static char *endp;


static void *morecore_alloc(size_t bytes, size_t *retbytes)
{
    struct morecore_state *state = get_morecore_state();

    char *freep = state->freep;

	size_t aligned_bytes = ROUND_UP(bytes, sizeof(Header));

    void *ret = NULL;
    if (freep + aligned_bytes < endp) {
        ret = freep;
        state->freep += aligned_bytes;
    }
    else {
        aligned_bytes = 0;
    }
    *retbytes = aligned_bytes;

    return ret;
}

static void morecore_free(void *base, size_t bytes)
{
    return;
}

errval_t morecore_init(void)
{
    struct morecore_state *state = get_morecore_state();

    thread_mutex_init(&state->mutex);

    char* new_heap; 
    errval_t err = paging_alloc(get_current_paging_state(),(void **) &new_heap, HEAP_SIZE);
    if (err_is_fail(err)) {
		return err_push(err, LIB_ERR_MALLOC_FAIL);
	}
	
	state->freep = new_heap;
	endp = new_heap + HEAP_SIZE;
			
    sys_morecore_alloc = morecore_alloc;
    sys_morecore_free = morecore_free;
    return SYS_ERR_OK;
}


Header *get_malloc_freep(void);
Header *get_malloc_freep(void)
{
    return get_morecore_state()->header_freep;
}
