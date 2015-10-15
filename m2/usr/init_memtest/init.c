/**
 * \file
 * \brief init process.
 */

/*
 * Copyright (c) 2007, 2008, 2009, 2010, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#include "init.h"
#include <stdlib.h>
#include <barrelfish/morecore.h>
#include <barrelfish/domain.h>
#include <barrelfish/sys_debug.h>

struct bootinfo *bi;

#define MALLOC_BUFSIZE (1UL<<20)
#define BUFSIZE 32L * 1024 * 1024
#define SAFE_VADDR (1UL<<25)

int main(int argc, char *argv[])
{
    printf("init: invoked as:");
    for (int i = 0; i < argc; i++) {
        printf(" %s", argv[i]);
    }
    printf("\n");

    errval_t err;

    // First argument contains the bootinfo location
    bi = (struct bootinfo*)strtol(argv[1], NULL, 10);

    /* Initialize local memory allocator */
    err = initialize_ram_alloc();
    if (err_is_fail(err)) {
        DEBUG_ERR(err, "Failed to init ram alloc");
        abort();
    }
	
	printf("Before dynamic malloc\n");
    char *static_malloc_buf = malloc(MALLOC_BUFSIZE);
    
    printf("Malloc returned %p!\n", static_malloc_buf);
	for (int i = 0; i < MALLOC_BUFSIZE; i++){
        static_malloc_buf[i] = i%255;
    }

    sys_debug_flush_cache();
    printf("dynamic malloc buf filled\n");
    for (int i = 0; i < MALLOC_BUFSIZE; i++){
        assert(static_malloc_buf[i] == i%255);
    }
    printf("dynamic malloc buf checked\n");

    void *vbuf;
    err = paging_alloc(get_current_paging_state(), &vbuf, BUFSIZE);
    if (err_is_fail(err)) {
        printf("error in paging_alloc: %s\n", err_getstring(err));
        abort();
    }
    
    if (!vbuf) {
        printf("did not get a buffer\n");
        abort();
    }
     
    char *buf = vbuf;
    
    for (int i = 0; i < BUFSIZE ; i++){
        buf[i] = i%255;
    }
    
    printf("buf filled\n");
    sys_debug_flush_cache();
    for (int i = 0; i < BUFSIZE; i++){
        assert(buf[i] == i%255);
    }
    printf("check passed\n");
    

    while(1);

    return EXIT_SUCCESS;
}
