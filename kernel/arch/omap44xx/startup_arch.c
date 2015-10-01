/*
 * Copyright (c) 2009, 2010, 2012 ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#include <kernel.h>
#include <dispatch.h>
#include <string.h>
#include <stdio.h>

#include <barrelfish_kpi/init.h>
#include <barrelfish_kpi/syscalls.h>

#include <arm_hal.h>
#include <paging_kernel_arch.h>
#include <exceptions.h>
#include <cp15.h>
#include <cpiobin.h>
#include <init.h>
#include <barrelfish_kpi/paging_arm_v7.h>
#include <arm_core_data.h>
#include <kernel_multiboot.h>
#include <offsets.h>
#include <startup_arch.h>
#include <startup_helpers.h>
#include <global.h>

#define UNUSED(x)               (x) = (x)

#define STARTUP_PROGRESS()      debug(SUBSYS_STARTUP, "%s:%d\n",          \
                                      __FUNCTION__, __LINE__);

#define INIT_MODULE_NAME    "armv7/sbin/init"

static inline uintptr_t round_up(uintptr_t value, size_t unit)
{
    assert(0 == (unit & (unit - 1)));
    size_t m = unit - 1;
    return (value + m) & ~m;
}

//static phys_mmap_t* g_phys_mmap;        // Physical memory map
static union arm_l1_entry * init_l1;              // L1 page table for init
static union arm_l2_entry * init_l2;              // L2 page tables for init

struct dcb *spawn_init(const char *name)
{
    printf("spawn_init\n");

    // allocate & prime init control block
    // the argument gets filled in with the address of the parameter page
    struct dcb *init_dcb = allocate_init_dcb(name);

    // TODO: setup page tables for Init, set the provided variables
    // init_l1 and init_l2 to the address of the L1 and L2 page table respectively.
    // NOTE: internal functionality expects l2 ptables back-to-back in memory
    init_l1 = (union arm_l1_entry *) local_phys_to_mem(alloc_phys_aligned(16384, 16384));
    
    init_l2 = (union arm_l2_entry *) local_phys_to_mem( alloc_phys_aligned(4194304, 1024));

    memset(init_l1, 0, 16384);
    memset(init_l2, 0, 4194304);

    printf("Filling out l1 tables..\n");
    lvaddr_t l2_offset = (lvaddr_t) init_l2;
    for (int i = 0; i<4096; i++){
	paging_map_user_pages_l1((lvaddr_t) init_l1, (lvaddr_t) i*(0x100000), (lpaddr_t) l2_offset);

//        printf("init_l1[%d] = %0x  |   l2_offset = %0x\n", i, init_l1[i], l2_offset);
        l2_offset += 1024;
       
    }

    // TODO: save address of user L1 page table in init_dcb->vspace
    // init_dcb->vspace = init_l1; 
    init_dcb->vspace = (mem_to_local_phys((lvaddr_t ) init_l1));

    // Map & Load init structures and ELF image
    // returns the entry point address and the global offset table base address
    genvaddr_t init_ep, got_base;
    map_and_load_init(name, init_dcb, init_l2, &init_ep, &got_base);
    
    printf("After map_and_load_init \n");

    // get dispatcher structs from dispatcher handle
    struct dispatcher_shared_arm *disp_arm
        = get_dispatcher_shared_arm(init_dcb->disp);

    // set Thread local storage register in register save area
    disp_arm->save_area.named.rtls = INIT_DISPATCHER_VBASE;

    // set global offset table base in dispatcher
    disp_arm->got_base = got_base;

    // set processor mode
    disp_arm->save_area.named.cpsr = ARM_MODE_USR | CPSR_F_MASK;

    // TODO: set pc and r10(got base) in register save area (disp_arm->save_area)
    disp_arm->save_area.named.pc = init_ep;
    disp_arm->save_area.named.r10 = got_base;
 

    
    printf("Spawning init is ending.");
    return init_dcb;
}

void arm_kernel_startup(void)
{
    printf("arm_kernel_startup entered \n");

    struct dcb *init_dcb;

    printf("Doing BSP related bootup \n");

    /* Initialize the location to allocate phys memory from */
    init_alloc_addr = glbl_core_data->start_free_ram;

    // Create & initialize init control block
    init_dcb = spawn_init(INIT_MODULE_NAME);

    // Should not return
    printf("Calling dispatch from arm_kernel_startup, start address is=%"PRIxLVADDR"\n",
           get_dispatcher_shared_arm(init_dcb->disp)->save_area.named.pc);
    
    dispatch(init_dcb);
    panic("Error spawning init!");
}
