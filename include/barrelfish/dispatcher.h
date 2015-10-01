/**
 * \file
 * \brief Generic dispatcher structure private to the user
 */

/*
 * Copyright (c) 2007, 2008, 2009, 2010, 2011, ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#ifndef BARRELFISH_DISPATCHER_H
#define BARRELFISH_DISPATCHER_H

#include <barrelfish/dispatch.h>
#include <barrelfish/core_state_arch.h>

struct lmp_chan;
struct deferred_event;

// Architecture generic user only dispatcher struct
struct dispatcher_generic {
    /// stack for traps and disabled pagefaults
    uintptr_t trap_stack[DISPATCHER_STACK_WORDS];
    /// all other dispatcher upcalls run on this stack
    uintptr_t stack[DISPATCHER_STACK_WORDS];

    /// Currently-running (or last-run) thread, if any
    struct thread *current;

    /// Thread run queue (all threads eligible to be run)
    struct thread *runq;

    /// Queue of deferred events (i.e. timers)
    struct deferred_event *deferred_events;

    /// The core the dispatcher is running on
    coreid_t core_id;

    uintptr_t timeslice;

    /// Per core dispatcher state
    struct core_state_arch core_state;

    /// Tracing buffer
    struct trace_buffer *trace_buf;

    struct thread *cleanupthread;

    /// Last FPU-using thread
    struct thread *fpu_thread;

    /// Domain ID cache
    domainid_t domain_id;
};

#endif // BARRELFISH_DISPATCHER_H
