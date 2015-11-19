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
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <barrelfish/thread_sync.h>
#include <math.h>
#define S_SIZE_PER_THREAD 2*8192
#define S_SIZE 1024*100

#define MAX_MEMORY (1024*1024*3*512)
#define FLAGS (KPI_PAGING_FLAGS_READ | KPI_PAGING_FLAGS_WRITE)
#define DEVICE_FLAGS (KPI_PAGING_FLAGS_READ | KPI_PAGING_FLAGS_WRITE | KPI_PAGING_FLAGS_NOCACHE)
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

struct capref get_l2_table(lvaddr_t vaddr, struct paging_state * st){

	int l1_index = ARM_L1_USER_OFFSET(vaddr);
	
	return st->mem_tree->l2_tables[l1_index];
}

bool is_l2_mapped(lvaddr_t vaddr, struct paging_state * st) {
	
	int l1_index = ARM_L1_USER_OFFSET(vaddr);
	
	//debug_printf("is_l2_mapped: Searcing for l1 index = %d\n", l1_index);
	return st->mem_tree->l2_maps[l1_index];	
}

errval_t map_l2 (lvaddr_t vaddr, struct paging_state * st){

	errval_t err;
    int l1_index = ARM_L1_USER_OFFSET(vaddr);
	struct capref l2_table;
    //struct capref l1_table = (struct capref) {
    //   .cnode = st->cnode_page,
    //    .slot = 0,
    //};
    struct capref l1_table = st->pdir;

//	debug_printf("Mapping l2 table at l1... For l1 index = %d\n", l1_index);
	err = arml2_alloc(&l2_table);
	if (err_is_fail(err)) {
		debug_printf("map_l2: Error in allocating cab for l2 table!\n");
		return err_push(err, LIB_ERR_VNODE_MAP);
	}

   	err = vnode_map(l1_table, l2_table, l1_index, FLAGS, 0, 1);
	if (err_is_fail(err)) {
		debug_printf("map_l2: Error in maping l2 table!\n");
		return err_push(err, LIB_ERR_VNODE_MAP);
	}
	
	st->mem_tree->l2_maps[l1_index] = true;
 	st->mem_tree->l2_tables[l1_index] = l2_table;	 

	return SYS_ERR_OK;
}

errval_t map_user_frame_outside_tree(lvaddr_t vaddr, struct capref usercap, uint64_t off, uint64_t size, int mapping_flags, struct paging_state* st) {

	errval_t err;
	//debug_printf("map_user_frame_outside_tree: Initiating...\n");
		
	size_t pages_needed = size / BYTES_PER_PAGE;
	struct capref temporary_frame;
	
	int first_l2_table_index = ARM_L2_USER_OFFSET(vaddr);
	int first_l2_total_pages;
	if (pages_needed <= 1024 - first_l2_table_index) {
		first_l2_total_pages = pages_needed;
	}
	else {
		first_l2_total_pages = 1024 - first_l2_table_index;
	}
	//debug_printf("map_user_frame_outside_tree: First l2 table index = %d\n", first_l2_table_index);

	int middle_l2_tables;
	int last_l2_total_pages;
	if (pages_needed - first_l2_total_pages <= 1024) {
		middle_l2_tables = 0;
		last_l2_total_pages = pages_needed - first_l2_total_pages;
	}
	else {
		middle_l2_tables = (pages_needed - first_l2_total_pages) / 1024;
		last_l2_total_pages =  (pages_needed - first_l2_total_pages) % 1024;
	}
	
	//debug_printf("map_user_frame_outside_tree: Total pages needed %d. Will map %d pages for first l2 table. %d pages for each middle l2 table and %d pages for last l2 table!\n", 
	//			 pages_needed, first_l2_total_pages, middle_l2_tables, last_l2_total_pages);	
	uint64_t start_address = vaddr;	
	uint64_t offset = off;
	int l2_index;

	// Map first l2 table 
	err = slot_alloc(&temporary_frame);	
	if (err_is_fail(err)) {
		abort();
		return err_push(err, LIB_ERR_SLOT_ALLOC);
	}

    if (!is_l2_mapped(start_address, st)) {
		err = map_l2(start_address, st);
		if (err_is_fail(err)) {
			return err_push(err, LIB_ERR_VNODE_MAP);
		}
	}

		
	l2_index = ARM_L2_USER_OFFSET(start_address);	
	err = vnode_map( get_l2_table(start_address, st), usercap, l2_index, mapping_flags, offset, first_l2_total_pages);
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "Failed in mapping first l2 table!\n");
		return err_push(err, LIB_ERR_VNODE_MAP);
	}
	offset = first_l2_total_pages * 4096;
	start_address += first_l2_total_pages * 4096;

	for (int i = 0; i<middle_l2_tables; i++) {
		
		// Map first middle table 
		err = slot_alloc(&temporary_frame);	
		if (err_is_fail(err)) {
			return err_push(err, LIB_ERR_SLOT_ALLOC);
		}

		if (!is_l2_mapped(start_address, st)) {
			err = map_l2(start_address, st);
			if (err_is_fail(err)) {
				return err_push(err, LIB_ERR_VNODE_MAP);
			}
		}
	
		err = cap_copy(temporary_frame, usercap);
		
		l2_index = ARM_L2_USER_OFFSET(start_address);	
		err = vnode_map( get_l2_table(start_address, st), temporary_frame, l2_index, mapping_flags, offset, 1024);
		if (err_is_fail(err)) {
			return err_push(err, LIB_ERR_VNODE_MAP);
		}		
		offset += 1024 * 4096;
		start_address += 1024 * 4096;
	}

	
	// Map last l2 table 
	if (last_l2_total_pages != 0) {
		err = slot_alloc(&temporary_frame);	
		if (err_is_fail(err)) {
			return err_push(err, LIB_ERR_SLOT_ALLOC);
		}

    	if (!is_l2_mapped(start_address, st)) {
			err = map_l2(start_address, st);
			if (err_is_fail(err)) 
				return err_push(err, LIB_ERR_VNODE_MAP);
		}
	
		err = cap_copy(temporary_frame, usercap);
		
		l2_index = ARM_L2_USER_OFFSET(start_address);	
		//debug_printf("map_user_frame_outside_tree: Mapping last l2 table with index = %d, at offset = %d \n", l2_index, offset);
		err = vnode_map( get_l2_table(start_address, st), temporary_frame, l2_index, mapping_flags, offset, last_l2_total_pages);
		if (err_is_fail(err)){
			DEBUG_ERR(err, "Failed in mapping last l2 table!\n");
			return err_push(err, LIB_ERR_VNODE_MAP);
		}
	}


	return SYS_ERR_OK;
}

errval_t map_user_frame(lvaddr_t vaddr, struct capref usercap, uint64_t off, uint64_t size, int mapping_flags, struct paging_state* st) {

	errval_t err;

	debug_printf("map_user_frame: Will map user frame for address %p offset %" PRIu64 " size %" PRIu64 " \n", vaddr, off, size);
	
	// Arbitary frame mapped by user at low addresses. 
	// Our tree DOES not keep the user frames for those mappings
	// The implementation takes into account the case that a FRAME 
	// spawns throughout multiple l2 tables.
	if (vaddr < START_VADDR) {
		err = map_user_frame_outside_tree(vaddr, usercap, off, size, mapping_flags, st);
		if (err_is_fail(err)) {
			return err_push(err, LIB_ERR_VNODE_MAP);
		}

		return SYS_ERR_OK;
	}
	
	err = map_user_frame_outside_tree(vaddr, usercap, off, size, mapping_flags, st);
	if (err_is_fail(err)) {
		return err_push(err, LIB_ERR_VNODE_MAP);
	}
	
    return SYS_ERR_OK;
}

errval_t map_page(lvaddr_t vaddr, struct capref usercap, uint64_t off, uint64_t size, int mapping_flags, struct paging_state * st) {
	
	errval_t err;
	
	if (!capref_is_null(usercap)) {
		
		err = map_user_frame(vaddr, usercap, off, size, mapping_flags, st);
		if (err_is_fail(err)) {
			debug_printf("map_page: Error in mapping user frame!\n");
			return err_push(err, LIB_ERR_VNODE_MAP);
		}	

		return SYS_ERR_OK;	
	}

	int l2_index = ARM_L2_USER_OFFSET(vaddr);
    //int l1_index = ARM_L1_USER_OFFSET(vaddr);

    if (!is_l2_mapped(vaddr, st)) {
		//debug_printf("MAPPING L2 = %d!\n", ARM_L1_USER_OFFSET(vaddr));
		err = map_l2(vaddr, st);
		if (err_is_fail(err)) {
			return err_push(err, LIB_ERR_VNODE_MAP);
		}
	}

	rb_red_blk_node* node = RBExactQuery(st->mem_tree, &vaddr);
	memory_chunk* chunk = (memory_chunk*) node->info; 
	struct capref l2_table = get_l2_table(vaddr, st);

	// Logic for mapping frames created on the fly (on pagefaults)
	if (chunk->current_frame_used == -1) {
		//debug_printf("map_page: Allocating our first large frame!\n");		
        chunk->current_frame_used = 0;
		if (chunk->total_frames_needed == 1)
			err = get_frame(chunk->size_of_last_frame,&chunk->frame_caps_for_region[0]);
		else 
			err = get_frame(1024*1024, chunk->frame_caps_for_region);
	   	
		if (err_is_fail(err)) {
			debug_printf("map_page: Error in getting the very first frame of the region!\n");
			return err_push(err, LIB_ERR_FRAME_ALLOC);
		}
	}

 	if (chunk->total_frames_needed == 1) {
    	struct capref current_frame = chunk->frame_caps_for_region[0];

		//debug_printf("Mapping page from l2 table = %d with index = %d at slot = %d\n", l1_index, l2_index, chunk->frame_caps_for_region[0].slot);
		err = vnode_map(l2_table, current_frame, l2_index, mapping_flags, 0 , 1);	
		if (err_is_fail(err)) {
			debug_printf("map_page: Error in mapping first frame to l2 table !\n");
			return err_push(err, LIB_ERR_VNODE_MAP);
		}

		chunk->frame_caps_for_region[0].slot++;
		return SYS_ERR_OK;
	}
	else {
		//debug_printf("Larger than 1MB\n");
		int used_frame = chunk->current_frame_used;
		struct capref current_frame = chunk->frame_caps_for_region[used_frame];
		if (current_frame.slot == 256) {
	   //	printf("Total fr needed = %d . Current frame = %d . Size of last frame = %d\n",chunk->total_frames_needed,chunk->current_frame_used,chunk->size_of_last_frame);
			used_frame++;
			if (used_frame == (chunk->total_frames_needed -1)) {
				// debug_printf("map_page: Allocating the LAST frame!\n");		
				err = get_frame(chunk->size_of_last_frame, chunk->frame_caps_for_region + used_frame);
				if (err_is_fail(err)) {
					debug_printf("map_page: Error in getting last frame for region!\n");
					return err_push(err, LIB_ERR_FRAME_ALLOC);
				}				
			}
			else {
				// debug_printf("Allocating a middle frame!\n");
				err = get_frame(1024*1024, chunk->frame_caps_for_region + used_frame);
				if (err_is_fail(err)) {
					debug_printf("map_page: Error in getting last frame for region!\n");
					return err_push(err, LIB_ERR_FRAME_ALLOC);
				}
			}
			current_frame = chunk->frame_caps_for_region[used_frame];			
			chunk->current_frame_used++;
		} 

		//debug_printf("Mapping for frame = %d and for slot = %d at inner frame = %d\n",used_frame,current_frame.slot, chunk->current_frame_used);
		//debug_printf("Mapping at offset = %d\n", chunk->frame_offset);
		err = vnode_map(l2_table, current_frame, l2_index, mapping_flags, 0 , 1);
		if (err_is_fail(err)) {
			debug_printf("Error in mapping for frame = %d and for slot = %d \n",used_frame,current_frame.slot);
			debug_printf("map_page: Error in mapping frame to l2 table !\n");
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
	
	thread_mutex_lock(&get_current_paging_state()->paging_tree_lock);
	if (type == EXCEPT_PAGEFAULT) {
		debug_printf("Pagefault exception at address %p\n", addr);

		if (addr == NULL){
			debug_printf("exception_handler: NULL pointer!\n");
			abort();
		}

		if ((lvaddr_t) addr < START_VADDR) {
			debug_printf("exception_handler: Address outside of valid boundaries!\n");		
			abort();
		}		
	
		// Get lock 

		
		if ( !is_virtual_address_mapped(get_current_paging_state()->mem_tree, (lvaddr_t) addr)) {
			debug_printf("exception_handler: Address not mapped!\n");
			abort();			
		} 
		else { 
			//debug_printf("Address is mapped!\n");
			errval_t err = map_page((lvaddr_t) addr, NULL_CAP, 0, 0, FLAGS, get_current_paging_state());
 			if (err_is_fail(err)) {
				DEBUG_ERR(err, "exception_handler: Error in map_page!\n");
				abort();
			}
		}
		
		thread_mutex_unlock(&get_current_paging_state()->paging_tree_lock);
	}
}


/* This function initializes our paging state tree. In order to initialize the 
 * tree we use SafeMalloc which is essentially an allocation from a static 
 * array. We initialize the first chunk to [0-1GB] */

errval_t paging_init_state(struct paging_state *st, lvaddr_t start_vaddr,
        struct capref pdir)
{
	
    debug_printf("paging_init: Initialzing the red-black tree that holds the paging state\n");

	// Keep in paging state the l1 table
	st->pdir = pdir;

    lvaddr_t* newAddr;
	memory_chunk* newMemory;
    rb_red_blk_tree* tree;

    tree=RBTreeCreate(VirtaddrComp,VirtaddrDest,VirtaddrInfoDest,VirtaddrPrint,VirtaddrInfo);

	tree->lowest_memory_address = start_vaddr;
	for (int i = 0 ; i < 1024; i++) {
		tree->l2_maps[i] = false;
		tree->l2_tables[i] = NULL_CAP;
	}
    newAddr = (lvaddr_t*) SafeMalloc(sizeof(lvaddr_t));

    *newAddr = start_vaddr;

    newMemory = (memory_chunk *) SafeMalloc(sizeof(memory_chunk));
    newMemory->reserved = 0;
    newMemory->size = MAX_MEMORY;
	 
    RBTreeInsert(tree, newAddr ,newMemory);
    
	st->mem_tree = tree;
	thread_mutex_init(&st->paging_tree_lock);

    return SYS_ERR_OK;
}

static char e_stack[S_SIZE];
static int e_stack_head = 0;

errval_t paging_init(void)
{

    // Initialize self-paging handler
    thread_set_exception_handler(exception_handler, NULL, e_stack, e_stack + e_stack_head + S_SIZE_PER_THREAD, NULL, NULL);
    e_stack_head += S_SIZE_PER_THREAD;

    struct capref pdir = {
		.cnode = cnode_page,
		.slot   = 0,
	};
   
	paging_init_state(&current, START_VADDR, pdir);

    RBTreePrint(current.mem_tree);

    set_current_paging_state(&current);

    return SYS_ERR_OK;
}


/*
 * Mallos a new stack for each new thread
 * and initializes the thread exception stack.
 * Ask the TAs about this.
 */
void paging_init_onthread(struct thread *t)
{
    // TODO: setup exception handler for thread `t'.
	debug_printf("paging_init_onthread: Initializing...\n");
	    
	t->exception_handler = exception_handler;

	t->exception_stack = e_stack + e_stack_head;
	t->exception_stack_top = e_stack + e_stack_head + S_SIZE_PER_THREAD;

	e_stack_head += S_SIZE_PER_THREAD;
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

errval_t get_frame(size_t bytes, struct capref* current_frame)
{
	struct capref ram;
	size_t alloc_bits;
	errval_t err;

	//alloc_bits = log2floor(bytes);
	alloc_bits = log2ceil(bytes);
	
	debug_printf("get_frame: Requesting for size %d\n", alloc_bits);
	
	err = ram_alloc(&ram, alloc_bits);
    if (err_is_fail(err)){ 
		debug_printf("get_frame : Error in ram_alloc!\n");
		return err_push(err, LIB_ERR_RAM_ALLOC);
	}

	cslot_t slots_needed = bytes / BASE_PAGE_SIZE;
	cslot_t slots;
   	
   	debug_printf("get_frame: Need %d slots\n", slots_needed);
   	
	if (slots_needed > 1) {
		/* get CNode and retype into it */
		struct capref nextcncap; struct cnoderef nextcn;
		err = cnode_create(&nextcncap, &nextcn, slots_needed, &slots);
		if (err_is_fail(err)) {
			debug_printf("get_frame : Error in cnode_create!\n");
			return err_push(err,LIB_ERR_CNODE_CREATE);
		}
		(*current_frame) = (struct capref) { .cnode = nextcn, .slot = 0 };
	} else {
		err = slot_alloc(current_frame);
        if (err_is_fail(err)) {
			debug_printf("get_frame: Error in slot_alloc!\n");
			return err_push(err,LIB_ERR_SLOT_ALLOC_INIT);
		}
	}
	
	err = cap_retype(*current_frame, ram, ObjType_Frame, BASE_PAGE_BITS);
    if (err_is_fail(err)) {
		debug_printf("get_frame: error in cap_retype!\n");
		return err_push(err,LIB_ERR_CAP_RETYPE);
	}

    err = cap_destroy(ram);
	if (err_is_fail(err)) {
		debug_printf("get_frame: error in cap_destroy!\n");
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
   
	thread_mutex_lock(&st->paging_tree_lock);
 
	debug_printf("Trying to allocate memory. Rounded up to %zu\n",bytes);
    
	vaddr = allocate_memory(st->mem_tree, bytes);
	if (vaddr == -1) {
		debug_printf("paging_alloc: Run out of virtual memory!");
		return LIB_ERR_OUT_OF_VIRTUAL_ADDR;
	}

	//debug_printf("paging_alloc: Memory allocated at %p\n",vaddr);
    node = RBExactQuery(st->mem_tree, &vaddr);
    struct memory_chunk* chunk = (struct memory_chunk*) node->info;
  
    if (bytes <= (1024*1024)) {
    	chunk->total_frames_needed = 1;
		chunk->size_of_last_frame = bytes;
		chunk->frame_caps_for_region = (struct capref *)  SafeMalloc(sizeof(struct capref));
		chunk->current_frame_used = -1;
		chunk->frame_offset = 0;
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
		
		// debug_printf("SIZE OF LAST FRAME = %d\n", size_of_last_frame);
		chunk->current_frame_used = -1;
		chunk->total_frames_needed = frames_needed;
		chunk->size_of_last_frame  = size_of_last_frame;
		chunk->frame_offset = 0;
		chunk->frame_caps_for_region = (struct capref *) SafeMalloc(sizeof(struct capref) * frames_needed);	
	}

	thread_mutex_unlock(&st->paging_tree_lock);
		
	*buf = (void *)vaddr;

	//debug_printf("paging_alloc: Allocated address at %p with size = %zu and total pages = %d\n", *buf, bytes, bytes/BYTES_PER_PAGE);
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
	//debug_printf("paging_map_frame_attr: Initiating...Will allocate region of = %d bytes\n", bytes);
    errval_t err = paging_alloc(st, buf, bytes);
    if (err_is_fail(err)) {
        return err;
    }

	if (frame.slot == TASKCN_SLOT_IO)
		flags = DEVICE_FLAGS; 

    if ((arg1 != NULL)&&(arg2 != NULL) )
    	return paging_map_fixed_attr_args(st, (lvaddr_t)(*buf), frame, bytes, flags, arg1, arg2);
	else 
		return paging_map_fixed_attr(st, (lvaddr_t)(*buf), frame, bytes, flags);
}


/**
 * \brief map a user provided frame at user provided VA.
 * Starting from the absolute offset in the frame and 
 * for length in bytes
 */
errval_t paging_map_fixed_attr_args(struct paging_state *st, lvaddr_t vaddr,
        struct capref frame, size_t bytes, int flags, void *arg1, void *arg2)
{
	//debug_printf("paging_map_fixed_attr: Initiating...\n");
	
	uint64_t offset = *(uint64_t *) arg1;
	uint64_t size   = *(uint64_t *) arg2;
	
	return map_page(vaddr, frame, offset, size, flags, st);
}

/**
 * \brief map a user provided frame at user provided VA.
 */
errval_t paging_map_fixed_attr(struct paging_state *st, lvaddr_t vaddr,
        struct capref frame, size_t bytes, int flags)
{
	//debug_printf("paging_map_fixed_attr: Initiating...\n");

	
	return map_page(vaddr, frame, 0, bytes, flags, st);
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
