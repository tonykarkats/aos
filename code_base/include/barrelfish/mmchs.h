/*
 * Copyright (c) 2013, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#ifndef MMCHS2_H
#define MMCHS2_H

#include <barrelfish/barrelfish.h>

#include <barrelfish/mmchs_debug.h>
#include <barrelfish/omap44xx_cm2.h>
#include <barrelfish/omap44xx_ctrlmod.h>
#include <barrelfish/i2c.h>
#include <barrelfish/twl6030.h>

void mmchs_init(void);
errval_t mmchs_read_block(size_t block_nr, void *buffer);
errval_t mmchs_write_block(size_t block_nr, void *buffer);

#endif // MMCHS2_H
