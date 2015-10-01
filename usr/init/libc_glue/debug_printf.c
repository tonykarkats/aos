/**
 * \file
 * \brief Debugging functions
 */

/*
 * Copyright (c) 2008, 2009, 2010, 2011, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#include <stdio.h>
#include <string.h> // strncpy
#include <debug.h>
#include <syscalls.h>

#define DISP_MEMORY_SIZE            1024 // size of memory dump in bytes

void debug_printf(const char *fmt, ...)
{
    va_list argptr;
    char str[256];
    size_t len;

    len = strlen("debug: ");
    strncpy(str, "debug: ", sizeof(str));
    if (len < sizeof(str)) {
        va_start(argptr, fmt);
        vsnprintf(str + len, sizeof(str) - len, fmt, argptr);
        va_end(argptr);
    }
    sys_print(str, sizeof(str));
}
