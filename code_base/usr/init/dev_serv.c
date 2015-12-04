/**
 * \file
 * \brief
 */

/*
 * Copyright (c) 2012, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#include <string.h>
#include "init.h"
#include <mm/mm.h>

size_t dev_mem_total = 0, dev_mem_avail = 0;

#define MAXSIZEBITS     31                 ///< Max size of each allocation
                                           ///  must be less than #bits of arch.
#define MINSIZEBITS     OBJBITS_DISPATCHER ///< Min size of each allocation
#define MAXCHILDBITS    4                  ///< Max branching of BTree nodes
/// Maximum depth of the BTree, assuming only branching by two at each level
#define MAXDEPTH        (MAXSIZEBITS - MINSIZEBITS + 1)
/// Maximum number of BTree nodes
#define NNODES          ((1UL << MAXDEPTH) - 1)

// size of cnodes created by slot allocator
#define CNODE_BITS      12
#define NCNODES         (1UL << CNODE_BITS)     ///< Maximum number of CNodes

/// Watermark at which we must refill the slab allocator used for nodes
#define MINSPARENODES   (MAXDEPTH * 13) // XXX: FIXME: experimentally determined!

/// General-purpose slot allocator
static struct multi_slot_allocator dev_msa;
/// MM allocator instance data
static struct mm mm_dev;
/// Slot allocator for MM
static struct slot_prealloc dev_slot_alloc;

static bool refilling = false;

errval_t devserv_alloc(struct capref *ret, uint8_t bits, genpaddr_t minbase,
                              genpaddr_t maxlimit)
{
    errval_t err;
	
//	debug_printf("devserv_alloc: Bits requested are %d\n", bits);
    assert(bits >= MINSIZEBITS);

    /* refill slot allocator if needed */
    err = slot_prealloc_refill(mm_dev.slot_alloc_inst);
    assert(err_is_ok(err));

    /* refill slab allocator if needed */
    size_t freecount = slab_freecount(&mm_dev.slabs);
    while (!refilling && (freecount <= MINSPARENODES)) {
	
		debug_printf("memeserv_alloc: Need to refill..\n");
    
		//abort();
	    refilling = true;
        struct capref frame;
        err = dev_msa.a.alloc(&dev_msa.a, &frame);
        assert(err_is_ok(err));
        size_t retsize;
        err = frame_create(frame, BASE_PAGE_SIZE * 8, &retsize);
        assert(err_is_ok(err));
        assert(retsize % BASE_PAGE_SIZE == 0);
        assert(retsize >= BASE_PAGE_SIZE);
        void *buf;
        err = paging_map_frame(get_current_paging_state(), &buf, retsize, frame, NULL, NULL);
        if (err_is_fail(err)) {
            DEBUG_ERR(err, "paging_map_frame failed");
            assert(buf);
        }
        slab_grow(&mm_dev.slabs, buf, retsize);
        freecount = slab_freecount(&mm_dev.slabs);
    }
    if (freecount > MINSPARENODES) {
        refilling = false;
    }

    if(maxlimit == 0) {
        err = mm_alloc(&mm_dev, bits, ret, NULL);
    } else {
        err = mm_alloc_range(&mm_dev, bits, minbase, maxlimit, ret, NULL);
    }

    if (err_is_fail(err)) {
        debug_printf("in mem_serv:mymm_alloc(bits=%"PRIu8", minbase=%"PRIxGENPADDR
                     ", maxlimit=%"PRIxGENPADDR")\n", bits, minbase, maxlimit);
        DEBUG_ERR(err, "mem_serv:mymm_alloc");
    }

    return err;
}

errval_t initialize_dev_serv(void)
{
    errval_t err;

	debug_printf("Started!\n");
    /* Step 1: Initialize slot allocator by passing a cnode cap for it to start with */
    struct capref cnode_cap;
    err = slot_alloc(&cnode_cap);
    assert(err_is_ok(err));
    struct capref cnode_start_cap = { .slot  = 0 };

    struct capref dev;
    err = ram_alloc_fixed(&dev, BASE_PAGE_BITS, 0, 0);
    assert(err_is_ok(err));
    err = cnode_create_from_mem(cnode_cap, dev, &cnode_start_cap.cnode,
                              DEFAULT_CNODE_BITS);
    assert(err_is_ok(err));

    /* location where slot allocator will place its top-level cnode */
    struct capref top_slot_cap = {
  	//err = slot_alloc(&top_slot_cap);
	//assert(err_is_ok(err));
	    .cnode = cnode_root,
        .slot = ROOTCN_SLOT_SLOT_ALLOCR_DEV,
    };

    /* clear mm_dev struct */
    memset(&mm_dev, 0, sizeof(mm_dev));

	
	debug_printf("Before slot_prealloc_init!\n");
    /* init slot allocator */
    err = slot_prealloc_init(&dev_slot_alloc, top_slot_cap, MAXCHILDBITS,
                           CNODE_BITS, cnode_start_cap,
                           1UL << DEFAULT_CNODE_BITS, &mm_dev);
    assert(err_is_ok(err));

	debug_printf("Before mm_init!\n");
    // FIXME: remove magic constant for lowest valid RAM address
    err = mm_init(&mm_dev, ObjType_DevFrame, 0x40000000,
                30, MAXCHILDBITS, NULL,
                slot_alloc_prealloc, &dev_slot_alloc, true);
    assert(err_is_ok(err));

    /* Step 2: give MM allocator static storage to get it started */
	debug_printf("Before slab_grow!\n");
    static char dev_nodebuf[SLAB_STATIC_SIZE(MINSPARENODES, MM_NODE_SIZE(MAXCHILDBITS))];
    slab_grow(&mm_dev.slabs, dev_nodebuf, sizeof(dev_nodebuf));

	err = mm_add( &mm_dev, cap_io, 30, 0x40000000);
	assert(err_is_ok(err));

	
	debug_printf("Before slot_prealloc_refill!\n");
    err = slot_prealloc_refill(mm_dev.slot_alloc_inst);
    if (err_is_fail(err)) {
        debug_printf("Fatal internal error in RAM allocator: failed to initialise "
               "slot allocator, err = %s\n", err_getstring(err));
        DEBUG_ERR(err, "failed to init slot allocator");
        abort();
    }

    // setup proper multi slot alloc
    err = multi_slot_alloc_init(&dev_msa, DEFAULT_CNODE_SLOTS, NULL);
    if(err_is_fail(err)) {
        USER_PANIC_ERR(err, "multi_slot_alloc_init");
    }

    return SYS_ERR_OK;
}
