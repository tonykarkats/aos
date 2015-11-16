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

#define S_SIZE_PER_THREAD 2*8192
#define S_SIZE 1024*100
#define START_VADDR (1UL<<25)
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

struct capref get_l2_table(lvaddr_t vaddr){

	int l1_index = ARM_L1_USER_OFFSET(vaddr);
	
	return current.mem_tree->l2_tables[l1_index];
}

bool is_l2_mapped(lvaddr_t vaddr) {
	
	int l1_index = ARM_L1_USER_OFFSET(vaddr);
	
	//debug_printf("is_l2_mapped: Searcing for l1 index = %d\n", l1_index);
	return current.mem_tree->l2_maps[l1_index];	
}

errval_t map_l2 (lvaddr_t vaddr){

	errval_t err;
    int l1_index = ARM_L1_USER_OFFSET(vaddr);
	struct capref l2_table;
    struct capref l1_table = (struct capref) {
        .cnode = cnode_page,
        .slot = 0,
    };
   
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
	
	current.mem_tree->l2_maps[l1_index] = true;
 	current.mem_tree->l2_tables[l1_index] = l2_table;	 

	return SYS_ERR_OK;
}

errval_t map_user_frame(lvaddr_t vaddr, struct capref usercap, uint64_t off, uint64_t size) {

	debug_printf("map_user_frame: Initiating...\n");

	errval_t err;
	rb_red_blk_node* node = RBExactQuery(get_current_paging_state()->mem_tree, &vaddr);
	memory_chunk* chunk = (memory_chunk*) node->info; 

	size_t pages_needed = size / BYTES_PER_PAGE;
	lvaddr_t page_start;
	uint64_t offset;

	offset = off;
	page_start = vaddr;

	chunk->frame_offset = off;
	chunk->total_frames_needed = 1;
	chunk->current_frame_used = 0;
	chunk->size_of_last_frame = size;
	chunk->user_provided_frame = true;
	chunk->frame_caps_for_region = (struct capref *) SafeMalloc(sizeof(struct capref) * pages_needed);

	// Are we mapping a device ?
	int mapping_flags;
	if (usercap.slot == TASKCN_SLOT_IO) {
		mapping_flags = DEVICE_FLAGS;
	}
	else {
		mapping_flags = FLAGS;
	}

	for (int i = 0; i < pages_needed; i++) {
		
		err = slot_alloc(&chunk->frame_caps_for_region[i]);
		if (err_is_fail(err)) {
			DEBUG_ERR(err, "map_user_frame: Can not allocate slot for capability!\n");
			return err_push(err, LIB_ERR_VNODE_MAP);
		}

		err = cap_copy(chunk->frame_caps_for_region[i], usercap); 
		if (err_is_fail(err)) {
			DEBUG_ERR(err, "map_user_frame: can not copy user provided frame to tree!\n");
			return err_push(err, LIB_ERR_VNODE_MAP);
		}
	
	}
	 
	debug_printf("Will map %d pages starting at address 0x%x\n", pages_needed, page_start);

	// Map all pages of the memory region, that may span across multiple 
	// l2 tables. AS OF NOW it only does ONE iteration and maps all the pages

	int l1_index = ARM_L1_USER_OFFSET(vaddr);
    struct capref l2_table_1 = (struct capref) {
        .cnode = cnode_page,
        .slot = l1_index + 1,
    };
	struct capref l1_table_1 = (struct capref) {
		.cnode = cnode_page,
		.slot = 0,
	};
	l1_table_1 = l1_table_1;
	int l2_index_1 = ARM_L2_USER_OFFSET(vaddr);
	debug_printf("l1 index = %d l2 index = %d\n", l1_index, l2_index_1);
  	


	if (l1_index < 7) {	
		//return SYS_ERR_OK;
		err = vnode_unmap(l1_table_1, l2_table_1, l1_index, 1);
		if (err_is_fail(err)) 
			DEBUG_ERR(err, "SHIT\n");;	
		//err = vnode_map(l2_table_1, usercap, l2_index_1, mapping_flags, 0, 1);
		//if (err_is_fail(err)) 
		//	abort();
		//return SYS_ERR_OK;		
	} 
	
	

	for (int i = 0 ; i < pages_needed; i++) {

	   if (!is_l2_mapped(page_start)) {
			
			// debug_printf("map_user_frame: Mapping for l2 table %d\n", ARM_L2_USER_OFFSET(page_start));
			err = map_l2(page_start);
			if (err_is_fail(err)) {
				debug_printf("map_user_frame: Error in mapping l2 table!\n");
				return err_push(err, LIB_ERR_VNODE_MAP);
			}
		}

		struct capref l2_table = get_l2_table(page_start);
		int l2_index = ARM_L2_USER_OFFSET(page_start);
	
		//debug_printf("map_user_frame: Mapping page for virtual address = 0x%x at offset = %d\n", page_start, offset);
		//debug_printf("map_user_frame: L2 index = %d\n", l2_index);
		err = vnode_map(l2_table, chunk->frame_caps_for_region[i], l2_index, mapping_flags, offset, 1);
		if (err_is_fail(err)) {
			DEBUG_ERR(err, "map_user_frame: Can not map page for user provided frame!\n");
			abort();
			return err_push(err, LIB_ERR_FRAME_ALLOC);
		}
		
		page_start += BYTES_PER_PAGE;
		offset += BYTES_PER_PAGE;
	}

	return SYS_ERR_OK;
}

errval_t create_and_map_frame(lvaddr_t vaddr) {

	return SYS_ERR_OK;
}


errval_t map_page(lvaddr_t vaddr, struct capref usercap, uint64_t off, uint64_t size) {
	
	errval_t err;
	
	if (!capref_is_null(usercap)) {
		
		err = map_user_frame(vaddr, usercap, off, size);
		if (err_is_fail(err)) {
			debug_printf("map_page: Error in mapping user frame!\n");
			return err_push(err, LIB_ERR_VNODE_MAP);
		}	

		return SYS_ERR_OK;	
	}

	int l2_index = ARM_L2_USER_OFFSET(vaddr);
    //int l1_index = ARM_L1_USER_OFFSET(vaddr);

    if (!is_l2_mapped(vaddr)) {
		//debug_printf("MAPPING L2 = %d!\n", ARM_L1_USER_OFFSET(vaddr));
		err = map_l2(vaddr);
		if (err_is_fail(err)) {
			return err_push(err, LIB_ERR_VNODE_MAP);
		}
	}

	rb_red_blk_node* node = RBExactQuery(get_current_paging_state()->mem_tree, &vaddr);
	memory_chunk* chunk = (memory_chunk*) node->info; 
	struct capref l2_table = get_l2_table(vaddr);

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
		err = vnode_map(l2_table, current_frame, l2_index, FLAGS, 0 , 1);	
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
		err = vnode_map(l2_table, current_frame, l2_index, FLAGS, 0 , 1);
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
	if (type == EXCEPT_PAGEFAULT) {
		//printf("Pagefault exception of subtype %d at address %p\n", subtype, addr);

		if (addr == NULL){
			debug_printf("exception_handler: NULL pointer!\n");
			abort();
		}

		if ((lvaddr_t) addr < START_VADDR) {
			debug_printf("exception_handler: Address outside of valid boundaries!\n");		
			abort();
		}		
	
		// Get lock 
		thread_mutex_lock(&get_current_paging_state()->paging_tree_lock);
		
		if ( !is_virtual_address_mapped(get_current_paging_state()->mem_tree, (lvaddr_t) addr)) {
			debug_printf("exception_handler: Address not mapped!\n");
			abort();			
		} 
		else { 
			//debug_printf("Address is mapped!\n");
			errval_t err = map_page((lvaddr_t) addr, NULL_CAP, 0, 0);
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
//    debug_printf("paging_init_state\n");
    lvaddr_t* newAddr;
	memory_chunk* newMemory;
    rb_red_blk_tree* tree;

    debug_printf("paging_init: Initialzing the red-black tree that holds the paging state\n");

    tree=RBTreeCreate(VirtaddrComp,VirtaddrDest,VirtaddrInfoDest,VirtaddrPrint,VirtaddrInfo);

	for (int i = 0 ; i < 4096; i++) {
		tree->l2_maps[i] = false;
		tree->l2_tables[i] = NULL_CAP;
	}
    newAddr = (lvaddr_t*) SafeMalloc(sizeof(lvaddr_t));

    *newAddr = START_VADDR;
    newMemory = (memory_chunk *) SafeMalloc(sizeof(memory_chunk));

    newMemory->reserved = 0;
    newMemory->size = MAX_MEMORY;
    
    RBTreeInsert(tree, newAddr ,newMemory);
    st->mem_tree = tree;

	thread_mutex_init(&st->paging_tree_lock);

	debug_printf("paging_init: Finalizing...\n");
    return SYS_ERR_OK;
}

static char e_stack[S_SIZE];
static int e_stack_head = 0;

errval_t paging_init(void)
{
    debug_printf("paging_init\n");

    // Initialize self-paging handler
    thread_set_exception_handler(exception_handler, NULL, e_stack, e_stack + e_stack_head + S_SIZE_PER_THREAD, NULL, NULL);
    e_stack_head += S_SIZE_PER_THREAD;

    struct capref p;
    
    debug_printf("Before initializing our memory tree\n");
    paging_init_state(&current, START_VADDR, p);
    debug_printf("paging_init: Initial Memory State Tree\n");
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
	
	//debug_printf("get_frame: Requesting for size %d\n", alloc_bits);
	
	err = ram_alloc(&ram, alloc_bits);
    if (err_is_fail(err)){ 
		debug_printf("get_frame : Error in ram_alloc!\n");
		return err_push(err, LIB_ERR_RAM_ALLOC);
	}

	cslot_t slots_needed = bytes / BASE_PAGE_SIZE;
	cslot_t slots;
   	
   	//debug_printf("get_frame: Need %d slots\n", slots_needed);
   	
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
 
    // debug_printf("Trying to allocate memory. Rounded up to %d\n",bytes);
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
	debug_printf("paging_map_frame_attr: Initiating...Will allocate region of = %d bytes\n", bytes);
    errval_t err = paging_alloc(st, buf, bytes);
    if (err_is_fail(err)) {
        return err;
    }

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
	debug_printf("paging_map_fixed_attr: Initiating...\n");
	
	uint64_t offset = *(uint64_t *) arg1;
	uint64_t size   = *(uint64_t *) arg2;
	
	return map_page(vaddr, frame, offset, size);
}

/**
 * \brief map a user provided frame at user provided VA.
 */
errval_t paging_map_fixed_attr(struct paging_state *st, lvaddr_t vaddr,
        struct capref frame, size_t bytes, int flags)
{
	debug_printf("paging_map_fixed_attr: Initiating...\n");

	
	return map_page(vaddr, frame, 0, bytes);
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
