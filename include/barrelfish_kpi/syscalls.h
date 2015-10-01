/**
 * \file
 * \brief System call numbers.
 */

/*
 * Copyright (c) 2007, 2008, 2009, 2010, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#ifndef BARRELFISH_SYSCALLS_H
#define BARRELFISH_SYSCALLS_H

#ifndef __ASSEMBLER__

/// return type from a system call: two words
struct sysret {
    errval_t  error;
    uintptr_t value;
};

/// Macro used for constructing return values from single-value syscalls
#define SYSRET(x) (struct sysret){ .error = x, .value = 0 }
#endif // __ASSEMBLER__

#define ERR_SYSCALL_ARGUMENT_MISMATCH 1   ///< error value for syscall with wrong number
                                          ///  of arguments

#define SYSCALL_NOP                 0     ///< No operation
#define SYSCALL_PRINT               1     ///< Print to kernel serial
#define SYSCALL_LED                 2     ///< Switch LED on/off

#endif // BARRELFISH_SYSCALLS_H
