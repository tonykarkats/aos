/*
 * Copyright (c) 2007, 2008, 2009, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

/* standard libc types and assert */
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include <stdlib.h>
#include <assert.h>


#include "syscalls.h"
#include "syscall_arch.h"
#include <static_assert.h>
#include <barrelfish_kpi/types.h>
#include <barrelfish_kpi/syscalls.h>
#include <barrelfish_kpi/registers_arch.h>

STATIC_ASSERT_SIZEOF(struct sysret, 2 * sizeof(uintptr_t));
STATIC_ASSERT_OFFSETOF(struct sysret, error, 0 * sizeof(uintptr_t));
STATIC_ASSERT_OFFSETOF(struct sysret, value, 1 * sizeof(uintptr_t));
STATIC_ASSERT(SYSCALL_REG == 0, "Bad register for system call argument.");

//
// System call wrappers
//

errval_t sys_nop(void)
{
    return syscall1(SYSCALL_NOP).error;
}

errval_t sys_print(const char *string, size_t length)
{
    return SYS_ERR_OK;
}
