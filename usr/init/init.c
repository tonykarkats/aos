/**
 * \file
 * \brief Barrelfish library initialization.
 */

/*
 * Copyright (c) 2007, 2008, 2009, 2010, 2011, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <errors/errno.h>
#include <syscalls.h>
#include <morecore.h>
#include <barrelfish_kpi/dispatcher_handle.h>
#include "init.h"
#include "helpers.h"
#include <asmoffsets.h>

extern size_t (*_libc_terminal_read_func)(char *, size_t);
extern size_t (*_libc_terminal_write_func)(const char *, size_t);
extern void (*_libc_exit_func)(int);
extern void (*_libc_assert_func)(const char *, const char *, const char *, int);

void libc_exit(int);

void libc_exit(int status)
{
    // If we're not dead by now, we wait
    while (1) {}
}

static void libc_assert(const char *expression, const char *file,
                        const char *function, int line)
{
    char buf[512];
    size_t len;

    /* Formatting as per suggestion in C99 spec 7.2.1.1 */
    len = snprintf(buf, sizeof(buf), "Assertion failed:"
                   " function %s, file %s, line %d.\n",
                   expression, function, file, line);
    sys_print(buf, len < sizeof(buf) ? len : sizeof(buf));
}

static size_t
dummy_terminal_read(char *data, size_t count)
{
    return 0;
}

static size_t
dummy_terminal_write(const char *data, size_t count)
{
    return count;
}

/* Set libc function pointers */
void sos_libc_glue_init(void)
{
    _libc_terminal_read_func = dummy_terminal_read;
    _libc_terminal_write_func = dummy_terminal_write;
    _libc_exit_func = libc_exit;
    _libc_assert_func = libc_assert;
}

/**
 *  \brief Initialise libbarrelfish, while disabled.
 *
 * This runs on the dispatcher's stack, while disabled, before the dispatcher is
 * setup. We can't call anything that needs to be enabled (ie. cap invocations)
 * or uses threads. This is called from crt0.
 */

extern int main(int argc, char *argv[]);
void sos_init(dispatcher_handle_t handle, bool init_dom_arg);
void sos_init(dispatcher_handle_t handle, bool init_dom_arg)
{
    char *args[1];
    args[0] = "init";
    // the libc glue init function is necessary to make the C library compile
    sos_libc_glue_init();
    // initialize skeleton heap allocator to make C library compile
    morecore_init();
    main(1, args);
    while(1);
}
