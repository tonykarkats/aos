/*
 * Copyright (c) 2009-2013 ETH Zurich.
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached LICENSE file.
 * If you do not find this file, copies can be found by writing to:
 * ETH Zurich D-INFK, Haldeneggsteig 4, CH-8092 Zurich. Attn: Systems Group.
 */

#include <kernel.h>
#include <dispatch.h>
#include <arm.h>
#include <arm_hal.h>
#include <cp15.h>
#include <exceptions.h>
#include <exec.h>
#include <misc.h>
#include <stdio.h>
#include <wakeup.h>
#include <barrelfish_kpi/syscalls.h>
#include <omap44xx_led.h> // for LED syscall

__attribute__((noreturn)) void sys_syscall_kernel(void);
__attribute__((noreturn)) void sys_syscall(arch_registers_state_t*);

#define UNUSED(x) x=x

void handle_user_page_fault(lvaddr_t                fault_address,
                            arch_registers_state_t* save_area)
{
    uintptr_t saved_pc = save_area->named.pc;
    panic("user page fault: addr %"PRIxLVADDR" IP %"PRIxPTR"\n",
            fault_address, saved_pc);
}

void handle_user_undef(lvaddr_t fault_address,
                       arch_registers_state_t* save_area)
{
    panic("user undef fault IP %"PRIxPTR"\n", fault_address);
}

void fatal_kernel_fault(uint32_t evector, lvaddr_t address, arch_registers_state_t* save_area
    )
{
    panic("Kernel fault at %08"PRIxLVADDR" vector %08"PRIx32"\nsave_area->ip = %"PRIx32"\n",
          address, evector, save_area->named.pc);
}

void handle_irq(arch_registers_state_t* save_area, uintptr_t fault_pc)
{
    panic("Unhandled IRQ\n");
}

void sys_syscall_kernel(void)
{
    panic("Why is the kernel making a system call?");
}

void sys_syscall(arch_registers_state_t* context)
{
    //panic("Can't handle user mode syscalls yet");

     // extract syscall number and number of syscall arguments from
    // registers
    struct registers_arm_syscall_args* sa = &context->syscall_args;
    uintptr_t   syscall = sa->arg0 & 0xf;
    uintptr_t   argc    = (sa->arg0 >> 4) & 0xf;
    //size_t length, counter = 0;    

    switch(syscall){ 
	case (SYSCALL_PRINT) : 
  	    // length = *((uintptr_t *)sa->arg2);
            
            //if (((char *)sa->arg1)[length] == '\0')        
    	    printf("%s", sa->arg1);
            break;
        case (SYSCALL_NOP) : 
            printf("Nop call\n");
	    break;
    }
    
    UNUSED(argc);
    resume(context);
}

