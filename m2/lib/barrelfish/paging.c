/**
 * \file
 * \brief Barrelfish paging helpers.
 */

/*
 * Copyright (c) 2012, 2013, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#include <barrelfish/barrelfish.h>
#include <barrelfish/paging.h>
#include <barrelfish/except.h>
#include <barrelfish/slab.h>
#include "threads_priv.h"
// #include <barrelfish/red_black_tree.h>
#include <stdio.h>
#include <string.h>

#define S_SIZE 8192*2
#define START_VADDR (1UL<<25)
static struct paging_state current;

/**
 * \brief Helper function that allocates a slot and
 *        creates a ARM l2 page table capability
 */
__attribute__((unused))
static errval_t arml2_alloc(struct capref *ret)
{
    errval_t err;
    err = slot_alloc(ret);
    if (err_is_fail(err)) {
        debug_printf("slot_alloc failed: %s\n", err_getstring(err));
        return err;
    }
    err = vnode_create(*ret, ObjType_VNode_ARM_l2);
    if (err_is_fail(err)) {
        debug_printf("vnode_create failed: %s\n", err_getstring(err));
        return err;
    }
    return SYS_ERR_OK;
}


#define FLAGS (KPI_PAGING_FLAGS_READ | KPI_PAGING_FLAGS_WRITE)
void handle_fault(lvaddr_t vaddr)
{
    int l1_index = ARM_L1_USER_OFFSET(vaddr);
    int l2_index = ARM_L2_USER_OFFSET(vaddr);
    struct capref l1_table = (struct capref) {
        .cnode = cnode_page,
        .slot = 0,
    };
 
    // would need checks if ptables exist already
    struct capref l2_table;
    arml2_alloc(&l2_table);
    vnode_map(l1_table, l2_table, l1_index, FLAGS, 0, 1);
    struct capref frame;
    size_t bytes = 4096u;
    frame_alloc(&frame, bytes, &bytes);
    vnode_map(l2_table, frame, l2_index, FLAGS, 0, 1);
}

// TODO: implement page fault handler that installs frames when a page fault
// occurs and keeps track of the virtual address space.

static void exception_handler(enum exception_type type,
							   int subtype,
							   void *addr,
							   arch_registers_state_t *regs,
							   arch_registers_fpu_state_t *fpuregs) {
	if (type == EXCEPT_PAGEFAULT) {
		printf("Pagefault exception of subtype %d at address %p\n", subtype, addr);
		handle_fault((lvaddr_t) addr);
	}
}


errval_t paging_init_state(struct paging_state *st, lvaddr_t start_vaddr,
        struct capref pdir)
{
    debug_printf("paging_init_state\n");
    lvaddr_t* newAddr;
	memory_chunk* newMemory;
    rb_red_blk_tree* tree;

	printf("Initialzing the red-black tree that holds the paging state\n");
    printf("At start only one chunk with the whole available memory exists\n");

    tree=RBTreeCreate(VirtaddrComp,VirtaddrDest,VirtaddrInfoDest,VirtaddrPrint,VirtaddrInfo);

    printf("Before first SafeMalloc\n");
    newAddr = (lvaddr_t*) SafeMalloc(sizeof(lvaddr_t));
    //newAddr = &vaddr_start;

    printf("After first SafeMalloc\n");
    *newAddr = START_VADDR;
    
    newMemory = (memory_chunk *) SafeMalloc(sizeof(memory_chunk));
    //newMemory = &first_chunk;  

    newMemory->reserved = 0;
    newMemory->size = 1UL*1024*1024*1024;
    
    printf("Before first tree insert\n");
    RBTreeInsert(tree, newAddr ,newMemory);
    printf("After first tree insert\n");
    st->mem_tree = tree;

    printf("Tree initialized\n");
    return SYS_ERR_OK;
}

static char e_stack[S_SIZE];
static char *e_stack_top = e_stack + S_SIZE;

errval_t paging_init(void)
{
    debug_printf("paging_init\n");
    // TODO: initialize self-paging handler
    // TIP: use thread_set_exception_handler() to setup a page fault handler
    thread_set_exception_handler(exception_handler, NULL, e_stack, e_stack_top, NULL, NULL);
    
    // TIP: Think about the fact that later on, you'll have to make sure that
    // you can handle page faults in any thread of a domain.
    // TIP: it might be a good idea to call paging_init_state() from here to
    // avoid code duplication.
    struct capref p;
    
    printf("Before initializing our memory tree\n");
    paging_init_state(&current, START_VADDR, p);
    printf("Printing our tree!\n");
    RBTreePrint(current.mem_tree);
    set_current_paging_state(&current);
    return SYS_ERR_OK;
}



void paging_init_onthread(struct thread *t)
{
    // TODO: setup exception handler for thread `t'.

}

/**
 * \brief return a pointer to a bit of the paging region `pr`.
 * This function gets used in some of the code that is responsible
 * for allocating Frame (and other) capabilities.
 */
errval_t paging_region_init(struct paging_state *st, struct paging_region *pr, size_t size)
{
    void *base;
    errval_t err = paging_alloc(st, &base, size);
    if (err_is_fail(err)) {
        debug_printf("paging_region_init: paging_alloc failed\n");
        return err_push(err, LIB_ERR_VSPACE_MMU_AWARE_INIT);
    }
    pr->base_addr    = (lvaddr_t)base;
    pr->current_addr = pr->base_addr;
    pr->region_size  = size;
    // TODO: maybe add paging regions to paging state?
    return SYS_ERR_OK;
}

/**
 * \brief return a pointer to a bit of the paging region `pr`.
 * This function gets used in some of the code that is responsible
 * for allocating Frame (and other) capabilities.
 */
errval_t paging_region_map(struct paging_region *pr, size_t req_size,
                           void **retbuf, size_t *ret_size)
{
    lvaddr_t end_addr = pr->base_addr + pr->region_size;
    ssize_t rem = end_addr - pr->current_addr;
	if(rem > req_size) {
        // ok
        *retbuf = (void*)pr->current_addr;
        *ret_size = req_size;
        pr->current_addr += req_size;
    } else if (rem > 0) {
        *retbuf = (void*)pr->current_addr;
        *ret_size = rem;
        pr->current_addr += rem;
        debug_printf("exhausted paging region, "
                "expect badness on next allocation\n");
    } else {
        return LIB_ERR_VSPACE_MMU_AWARE_NO_SPACE;
    }
    return SYS_ERR_OK;
}

/**
 * \brief free a bit of the paging region `pr`.
 * This function gets used in some of the code that is responsible
 * for allocating Frame (and other) capabilities.
 * We ignore unmap requests right now.
 */
errval_t paging_region_unmap(struct paging_region *pr, lvaddr_t base, size_t bytes)
{
    // XXX: should free up some space in paging region, however need to track
    //      holes for non-trivial case
    return SYS_ERR_OK;
}

/**
 * \brief Find a bit of free virtual address space that is large enough to
 *        accomodate a buffer of size `bytes`.
 * TODO: you need to implement this function using the knowledge of your
 * self-paging implementation about where you have already mapped frames.
 */
errval_t paging_alloc(struct paging_state *st, void **buf, size_t bytes)
{
    *buf = NULL;
    return SYS_ERR_OK;
}

/**
 * \brief map a user provided frame, and return the VA of the mapped
 *        frame in `buf`.
 */
errval_t paging_map_frame_attr(struct paging_state *st, void **buf,
                               size_t bytes, struct capref frame,
                               int flags, void *arg1, void *arg2)
{
    errval_t err = paging_alloc(st, buf, bytes);
    if (err_is_fail(err)) {
        return err;
    }
    return paging_map_fixed_attr(st, (lvaddr_t)(*buf), frame, bytes, flags);
}


/**
 * \brief map a user provided frame at user provided VA.
 */
errval_t paging_map_fixed_attr(struct paging_state *st, lvaddr_t vaddr,
        struct capref frame, size_t bytes, int flags)
{
    // TODO: you will need this functionality in later assignments. Try to
    // keep this in mind when designing your self-paging system.
    return SYS_ERR_OK;
}

/**
 * \brief unmap a user provided frame, and return the VA of the mapped
 *        frame in `buf`.
 * NOTE: this function is currently here to make libbarrelfish compile. As
 * noted on paging_region_unmap we ignore unmap requests right now.
 */
errval_t paging_unmap(struct paging_state *st, const void *region)
{
    return SYS_ERR_OK;
}
