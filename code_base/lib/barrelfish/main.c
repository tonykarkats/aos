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

	err = fat32_init();
	assert(err_is_ok(err));


	// This is how list() is used!
/*
	struct dirent * dirtable = NULL;
	uint32_t size;
	list("/DIR1/DIR12/F121", &dirtable, &size);
  
	printf("Found %" PRIu32 "\n", size);
	for (int i=0; i<size; i++) {
		struct dirent dirent;
		dirent = dirtable[i];
		printf("%s\n", dirent.name);	
		printf("Starting cluster at %"PRIu32"\n", dirent.firstCluster);
	}

*/

	// This is how read_file() is used!

	uint32_t retsize;
	err = read_file("/DIR1/TEST1", &data, 0, 0, &retsize);
	if (err_is_fail(err)) {
		debug_printf("File not found!\n");
	}	
	
	//char * char_data = (char *) data;
	//char_data[retsize] = '\0';
	//debug_printf("%s\n", char_data);
	
    return 0;
}
