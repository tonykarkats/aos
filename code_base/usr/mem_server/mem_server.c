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
#include <mem_server.h>
#include <stdlib.h>
#include <string.h>
#include <barrelfish/morecore.h>
#include <barrelfish/dispatcher_arch.h>
#include <barrelfish/debug.h>
#include <barrelfish/lmp_chan.h>
#include <barrelfish/sys_debug.h>
#include <math.h>
#include <barrelfish/aos_rpc.h>
#include <barrelfish/thread_sync.h>

#define UNUSED(x) (x) = (x)

#define INPUT_BUF_SIZE 4096
#define MALLOC_BUFSIZE (1UL<<20)
#define BUFSIZE 32L * 1024 * 1024
#define SAFE_VADDR (1UL<<25)

#define FIRSTEP_BUFLEN          21u
#define FIRSTEP_OFFSET          (33472u + 56u)
#define CLIENT_LIMIT 			(1<<26)*10			

struct bootinfo *bi;
static coreid_t my_core_id;

int main(int argc, char *argv[])
{
//    errval_t err;

	debug_printf("In memory server!\n");	
	UNUSED(bi);
	UNUSED(my_core_id);

   return EXIT_SUCCESS;
}
