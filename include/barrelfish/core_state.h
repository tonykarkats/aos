/**
 * \file
 * \brief
 */

/*
 * Copyright (c) 2008, 2009, 2010, 2011, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#ifndef LIBBARRELFISH_CORESTATE_H
#define LIBBARRELFISH_CORESTATE_H

#include <k_r_malloc.h>

struct morecore_state {
    Header header_base;
    Header *header_freep;
};

struct core_state_generic {
    struct morecore_state morecore_state;
};

// This is implemented in usr/init/libc_glue/morecore.c
extern struct morecore_state* get_morecore_state(void);

#endif
