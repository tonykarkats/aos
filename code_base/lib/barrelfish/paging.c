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
#include <stdbool.h>

#define S_SIZE 8192*2
#define START_VADDR (1UL<<25)
#define FLAGS (KPI_PAGING_FLAGS_READ | KPI_PAGING_FLAGS_WRITE)

static struct paging_state current;
//static int temp1;
//static int temp2;



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

errval_t map_page(lvaddr_t vaddr) {
	
	errval_t err;
    int l1_index = ARM_L1_USER_OFFSET(vaddr);
    int l2_index = ARM_L2_USER_OFFSET(vaddr);
    struct capref l1_table = (struct capref) {
        .cnode = cnode_page,
        .slot = 0,
    };
    rb_red_blk_node* node = RBExactQuery(get_current_paging_state()->mem_tree, &vaddr);
	memory_chunk* chunk = (memory_chunk*) node->info; 
 
    struct capref l2_table;
	
    if (!chunk->l2_mapped[l1_index]) {
	    debug_printf("Mapping l2 table at l1... For l1 index = %d\n", l1_index);
		err = arml2_alloc(&l2_table);
		if (err_is_fail(err)) {
			printf("map_page: Error in allocating cab for l2 table!\n");
			return err_push(err, LIB_ERR_VNODE_MAP);
		
		}

		debug_printf("map_page: Before VNODE map!\n");
    	err = vnode_map(l1_table, l2_table, l1_index, FLAGS, 0, 1);
		debug_printf("map_page: After VNODE map!\n");
		if (err_is_fail(err)) {
			printf("map_page: Error in maping l2 table!\n");
			return err_push(err, LIB_ERR_VNODE_MAP);
		}
		chunk->l2_mapped[l1_index] = true;    
		chunk->l2_table_cap[l1_index] = l2_table; 
	}
	else {
		l2_table = chunk->l2_table_cap[l1_index];
	}

	if (chunk->current_frame_used == -1) {
		printf("map_page: Allocating our first large frame!\n");		
        chunk->current_frame_used = 0;
		if (chunk->total_frames_needed == 1)
			err = get_frame(chunk->size_of_last_frame,chunk->frame_caps_for_region);
		else 
			err = get_frame(1024*1024, chunk->frame_caps_for_region);
	   	
		if (err_is_fail(err)) {
			printf("map_page: Error in getting the very first frame of the region!\n");
			return err_push(err, LIB_ERR_FRAME_ALLOC);
		}
	}

 	if (chunk->total_frames_needed == 1) {
    	struct capref current_frame = chunk->frame_caps_for_region[0];

		//printf("Mapping frame with index = %d at l2 table...\n",l2_index);
		err = vnode_map(l2_table, current_frame, l2_index, FLAGS, 0 , 1);	
		if (err_is_fail(err)) {
			printf("map_page: Error in mapping frame to l2 table !\n");
			return err_push(err, LIB_ERR_VNODE_MAP);
		}

		chunk->frame_caps_for_region[0].slot++;
		return SYS_ERR_OK;
	}
	else {
		//printf("Larger than 1MB\n");
		int used_frame = chunk->current_frame_used;
		struct capref current_frame = chunk->frame_caps_for_region[used_frame];
		if (current_frame.slot == 256) {
	   //	printf("Total fr needed = %d . Current frame = %d . Size of last frame = %d\n",chunk->total_frames_needed,chunk->current_frame_used,chunk->size_of_last_frame);
			used_frame++;
			if (used_frame == (chunk->total_frames_needed -1)) {
				debug_printf("map_page: Allocating the LAST frame!\n");		
		//		printf("Allocating huge frame with %d bytes\n", chunk->size_of_last_frame);
				err = get_frame(chunk->size_of_last_frame, chunk->frame_caps_for_region + used_frame);
				if (err_is_fail(err)) {
					printf("map_page: Error in getting last frame for region!\n");
					return err_push(err, LIB_ERR_FRAME_ALLOC);
				}				
			}
			else {
		//		printf("Allocating a middle frame!\n");
				err = get_frame(1024*1024, chunk->frame_caps_for_region + used_frame);
				if (err_is_fail(err)) {
					printf("map_page: Error in getting last frame for region!\n");
					return err_push(err, LIB_ERR_FRAME_ALLOC);
				}
			}
			current_frame = chunk->frame_caps_for_region[used_frame];			
			chunk->current_frame_used++;
		} 

		//printf("Mapping for frame = %d and for slot = %d \n",used_frame,current_frame.slot);
		err = vnode_map(l2_table, current_frame, l2_index, FLAGS, 0 , 1);	
		if (err_is_fail(err)) {
			printf("map_page: Error in mapping frame to l2 table !\n");
			return err_push(err, LIB_ERR_VNODE_MAP);
		}
		chunk->frame_caps_for_region[used_frame].slot++;
		return SYS_ERR_OK;
	}
}

// Page fault handler that installs frames when a page fault
// occurs and keeps track of the virtual address space.

static void exception_handler(enum exception_type type,
			      int subtype,
			      void *addr,
			      arch_registers_state_t *regs,
			      arch_registers_fpu_state_t *fpuregs) 
{
	if (type == EXCEPT_PAGEFAULT) {
		//printf("Pagefault exception of subtype %d at address %p\n", subtype, addr);
        	//printf("Checking to see if we have it in paging tree\n");

		if (addr == NULL){
			printf("exception_handler: NULL pointer!\n");
			abort();
		}

		if ((lvaddr_t) addr < START_VADDR) {
			printf("exception_handler: Address outside of valid boundaries!\n");		
			abort();
		}		

		if ( !is_virtual_address_mapped(get_current_paging_state()->mem_tree, (lvaddr_t) addr)) {
			printf("exception_handler: Address not mapped!\n");
			abort();			
		} 
		else { 
			//printf("Address is mapped!\n");
			errval_t err = map_page((lvaddr_t) addr);
 			if (err_is_fail(err)) {
				printf("exception_handler: Error in map_page!\n");
				abort();
			}
		}
	}
}


/* This function initializes our paging state tree. In order to initialize the 
 * tree we use SafeMalloc which is essentially an allocation from a static 
 * array. We initialize the first chunk to [0-1GB] */

errval_t paging_init_state(struct paging_state *st, lvaddr_t start_vaddr,
        struct capref pdir)
{
    debug_printf("paging_init_state\n");
    lvaddr_t* newAddr;
	memory_chunk* newMemory;
    rb_red_blk_tree* tree;

    printf("paging_init: Initialzing the red-black tree that holds the paging state\n");
    //printf("At start only one chunk with the whole available memory exists\n");

    tree=RBTreeCreate(VirtaddrComp,VirtaddrDest,VirtaddrInfoDest,VirtaddrPrint,VirtaddrInfo);

    //printf("Before first SafeMalloc\n");
    newAddr = (lvaddr_t*) SafeMalloc(sizeof(lvaddr_t));
    //newAddr = &vaddr_start;

    //printf("After first SafeMalloc\n");
    *newAddr = START_VADDR;
    
    newMemory = (memory_chunk *) SafeMalloc(sizeof(memory_chunk));
    //newMemory = &first_chunk;  

    newMemory->reserved = 0;
    newMemory->size = 1UL*1024*1024*1024;
    
    //printf("Before first tree insert\n");
    RBTreeInsert(tree, newAddr ,newMemory);
    //printf("After first tree insert\n");
    st->mem_tree = tree;

    printf("paging_init: Paging Struct initialized.\n");
    return SYS_ERR_OK;
}

static char e_stack[S_SIZE];
static char *e_stack_top = e_stack + S_SIZE;

errval_t paging_init(void)
{
    debug_printf("paging_init\n");
    // Initialize self-paging handler
    thread_set_exception_handler(exception_handler, NULL, e_stack, e_stack_top, NULL, NULL);
    
    struct capref p;
    
    //printf("Before initializing our memory tree\n");
    paging_init_state(&current, START_VADDR, p);
    printf("paging_init: Initial Memory State Tree\n");
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
 */


errval_t get_frame(size_t bytes, struct capref* current_frame)
{
	struct capref ram;
	size_t alloc_bits;
	errval_t err;

	alloc_bits = log2floor(bytes);
	err = ram_alloc(&ram, alloc_bits);
    if (err_is_fail(err)){ 
		printf("get_frame : Error in ram_alloc!\n");
		return err_push(err, LIB_ERR_RAM_ALLOC);
	}

	cslot_t slots_needed = bytes / BASE_PAGE_SIZE;
	cslot_t slots;
    //printf("get_frame: Need %d slots\n", slots_needed);
   	
	if (slots_needed > 1) {
		/* get CNode and retype into it */
		struct capref nextcncap; struct cnoderef nextcn;
		err = cnode_create(&nextcncap, &nextcn, slots_needed, &slots);
		if (err_is_fail(err)) {
			printf("get_frame : Error in cnode_create!\n");
			return err_push(err,LIB_ERR_CNODE_CREATE);
		}
		(*current_frame) = (struct capref) { .cnode = nextcn, .slot = 0 };
	} else {
		err = slot_alloc(current_frame);
        if (err_is_fail(err)) {
			printf("get_frame: Error in slot_alloc!\n");
			return err_push(err,LIB_ERR_SLOT_ALLOC_INIT);
		}
	}
	
	err = cap_retype(*current_frame, ram, ObjType_Frame, BASE_PAGE_BITS);
    if (err_is_fail(err)) {
		printf("get_frame: error in cap_retype!\n");
		return err_push(err,LIB_ERR_CAP_RETYPE);
	}

    err = cap_destroy(ram);
	if (err_is_fail(err)) {
		printf("get_frame: error in cap_destroy!\n");
		return err_push(err,LIB_ERR_CAP_DESTROY);
	}
 
    return SYS_ERR_OK;
}



errval_t paging_alloc(struct paging_state *st, void **buf, size_t bytes)
{
    rb_red_blk_node* node;
	lvaddr_t vaddr;
	int frames_needed, size_of_last_frame;
	bytes = ROUND_UP(bytes, BYTES_PER_PAGE); 
    
    //printf("Trying to allocate memory. Rounded up to %d\n",bytes);
    vaddr = allocate_memory(st->mem_tree, bytes);
	if (vaddr == -1) {
		printf("paging_alloc: Run out of virtual memory!");
		return LIB_ERR_OUT_OF_VIRTUAL_ADDR;
	}

	//printf("Memory allocated at %p\n",vaddr);
  	
   	//printf("Trying to find node that was just created to update its memory frame\n");
    node = RBExactQuery(st->mem_tree, &vaddr);
    struct memory_chunk* chunk = (struct memory_chunk*) node->info;
  
    if (bytes <= (1024*1024)) {
		chunk->total_frames_needed = 1;
		chunk->size_of_last_frame = bytes;
		chunk->frame_caps_for_region = (struct capref *)  SafeMalloc(sizeof(struct capref));
		chunk->current_frame_used = -1;
    }  
	else {

		frames_needed = bytes / (1024*1024);
		if ( (bytes % (1024*1024)) != 0) {
			frames_needed += 1;
			size_of_last_frame = bytes % (1024*1024);
		}
		else {
			size_of_last_frame = 1024*1024;
		}
		
		chunk->current_frame_used = -1;
		chunk->total_frames_needed = frames_needed;
		chunk->size_of_last_frame  = size_of_last_frame;
		chunk->frame_caps_for_region = (struct capref *) SafeMalloc(sizeof(struct capref) * frames_needed);	
	}

	for (int i = 0; i<4096; i++)
		chunk->l2_mapped[i] = false;

		
	*buf = (void *)vaddr;

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
	debug_printf("paging_map_frame_attr: Initiating...\n");
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
	debug_printf("paging_map_fixed_attr: Initiating...\n");
    //int l1_index = ARM_L1_USER_OFFSET(vaddr);
    //int l2_index = ARM_L2_USER_OFFSET(vaddr);

 	//rb_red_blk_node* node = RBExactQuery(get_current_paging_state()->mem_tree, &vaddr);
	


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
