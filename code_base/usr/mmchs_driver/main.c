/**
 * \file
 * \brief MMCHS Driver main routine.
 */
/*
 * Copyright (c) 2013, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#include <stdlib.h>
#include <barrelfish/aos_rpc.h>
#include <arch/arm/omap44xx/device_registers.h>

#include "mmchs.h"
#include "fat32.h"

static struct cnoderef cnode;

static void get_cap(lpaddr_t base, size_t size)
{
    errval_t err;
    size_t len;

    struct capref cap;
    err = aos_rpc_get_dev_cap(get_init_chan(), base, size, &cap, &len);
    if (err_is_fail(err)) {
        USER_PANIC_ERR(err, "get_dev_mem rpc failed\n");
    }

    struct capref argcn = {
        .cnode = cnode_root,
        .slot = TASKCN_SLOT_ARGSPAGE
    };

    size_t bits = 8; // TODO(gz): How do I figure this value out on the fly?
    struct capref device_cap_iter = {
        .cnode = build_cnoderef(argcn, bits),
        .slot = 0
    };

    static size_t current_slot = 0;
    device_cap_iter.slot = current_slot++;
	//debug_printf("Slot = %zu \n", device_cap_iter.slot);
		
    err = cap_copy(device_cap_iter, cap);
    if (err_is_fail(err)) {
        USER_PANIC_ERR(err, "cap_copy failed.");
    }

	assert(err_is_ok(err));
}

int main(int argc, char **argv)
{
    //
    // Initializing the SD-Card
    //

    // Getting the necessary capabilities from init
    struct capref argcn = {
        .cnode = cnode_root,
        .slot = TASKCN_SLOT_ARGSPAGE
    };

    errval_t err = cnode_create_raw(argcn, &cnode, 255, NULL);
    if (err_is_fail(err)) {
        USER_PANIC_ERR(err, "can not create the cnode failed.");
    }

    get_cap(OMAP44XX_CM2 & ~0xFFF, 0x1000);
    get_cap(OMAP44XX_CLKGEN_CM2 & ~0xFFF, 0x1000);
    get_cap(OMAP44XX_I2C1 & ~0xFFF, 0x1000);
    get_cap(OMAP44XX_SYSCTRL_PADCONF_CORE & ~0xFFF, 0x1000);
    get_cap(OMAP44XX_MMCHS1 & ~0xFFF, 0x1000);

    // Initializing the necessary subsystem and the mmchs controlelr
	cm2_init();
    ti_twl6030_init();
    ctrlmod_init();
    cm2_enable_hsmmc1();
    sdmmc1_enable_power();

    mmchs_init();


    //
    // Reading the first block from the SD-Card
    // This should be the same information you get with
    // dd when reading the first block on linux...
    //
//    void *buffer = malloc(512);
//    assert(buffer != NULL);
//
//    err = mmchs_read_block(0, buffer);
//    assert(err_is_ok(err));
//
//	debug_printf("Boot Block Info\n");
//	debug_printf("--------------\n");
//
//	debug_printf("Manufacturer: ");
//	for (int i=3; i<=10; ++i) {
//		debug_printf("%c", ((uint8_t*) buffer)[i]);
//
//	}
//	debug_printf("\n");
//
//	uint16_t BPB_BytsPerSec = (((uint8_t*) buffer)[12] <<  8) +
//				   			  ((uint8_t*) buffer)[11];
//
//	debug_printf("Bytes Per Sector: %d\n", BPB_BytsPerSec);
//
//
//	uint8_t BPB_SecPerClus =  ((uint8_t*) buffer)[13];
//	debug_printf("Number of Sectors per Cluster: %d\n", BPB_SecPerClus);
//
//	uint8_t BPB_NumFATs =  ((uint8_t*) buffer)[16];
//	debug_printf("Number of FATs: %d\n", BPB_NumFATs);
//
//	uint32_t FATSz = 	(((uint8_t*) buffer)[39] << 24) +
//				   		(((uint8_t*) buffer)[38] << 16) +
//				   		(((uint8_t*) buffer)[37] <<  8) +
//				   		((uint8_t*) buffer)[36];
//	debug_printf("Size of FAT: %d\n", FATSz);
//
//	uint16_t BPB_RsvdSecCnt = (((uint8_t*) buffer)[15] <<  8) +
//				   			  ((uint8_t*) buffer)[14];
//
//	debug_printf("Number of reserved sectors: %d\n", BPB_RsvdSecCnt);
//
//	// Calculate the start of the data region
//	uint32_t FirstDataSector = BPB_RsvdSecCnt + (BPB_NumFATs*FATSz);
//	debug_printf("First Data Sector: %d\n", FirstDataSector);
//
//	// Calculate first cluster of root directory
//		
//	uint32_t BPB_RootClus = 	(((uint8_t*) buffer)[47] << 24) +
//				   				(((uint8_t*) buffer)[46] << 16) +
//				   				(((uint8_t*) buffer)[45] <<  8) +
//				   				((uint8_t*) buffer)[44];
//	debug_printf("First cluster of Root Directory: %d\n", BPB_RootClus);
//
//
//	// Now we have to find the sector number of the root directory
//	
//	uint32_t FirstSectorofRootDir = ((BPB_RootClus-2)*BPB_SecPerClus + FirstDataSector);
//	debug_printf("First sector of Root Directory : %d", FirstSectorofRootDir); 

/*
    debug_printf("Printing BOOT BLOCK block\n");
    for (int i = 1; i <= 512; ++i)
    {
        debug_printf("%x\t", ((uint8_t*) buffer)[i-1]);
        if (i % 4 == 0) {
            debug_printf("\n");
        }
    }

	// Read FAT
    err = mmchs_read_block(1, buffer);
    debug_printf("\nPrinting FAT\n");
    for (int i = 1; i <= 512; ++i)
    {
        debug_printf("%x\t", ((uint8_t*) buffer)[i-1]);
        if (i % 4 == 0) {
            debug_printf("\n");
        }
    }
    assert(err_is_ok(err));
*/

	// Print Root Directory
	
//    err = mmchs_read_block(FirstSectorofRootDir, buffer);
 //   debug_printf("\nPrinting Root dir\n");
  // for (int i = 32; i <= 128; ++i)
 //   {
 //       printf("%d: %c\n", i , ((uint8_t*) buffer)[i]);
  //     	fflush(stdout); 
  // }

	// Some form of ls
	
	//char ls_arg[12] = {"dir1"};

	err = fat32_init();

	// Check in root directory first	
//	struct dirent * dirtable = NULL;
//	uint32_t size;
	//err = get_dirents(FirstSectorofRootDir, &dirtable, &size);
	//printf("Size of Directory = %d\n", size);	

	struct dirent * dirtable = NULL;
	uint32_t size;
	list("/DIR1/DIR12", &dirtable, &size);
	
	printf("Found %" PRIu32 "\n", size);
	for (int i=0; i<size; i++) {
		struct dirent dirent;
		dirent = dirtable[i];
		printf("%s\n", dirent.name);	
	}
	
	while(1);
    return 0;
}
