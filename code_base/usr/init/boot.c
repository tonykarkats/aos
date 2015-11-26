#include "boot.h"

errval_t invoke_monitor_spawn_core(struct capref c_kernel, coreid_t core_id, enum cpu_type cpu_type, 
                          forvaddr_t entry) 
{ 
    uint8_t invoke_bits = get_cap_valid_bits(cap_kernel); 
    capaddr_t invoke_cptr = get_cap_addr(cap_kernel) >> (CPTR_BITS - invoke_bits); 
 
    return syscall6((invoke_bits << 16) | (KernelCmd_Spawn_core << 8) 
                    | SYSCALL_INVOKE, invoke_cptr, core_id, cpu_type, 
                    (uintptr_t)(entry >> 32), (uintptr_t) entry).error; 
} 
 
errval_t spawn_second_core(struct bootinfo *bi ) 
{
	char name[100] = "armv7/sbin/cpu_omap44xx";
    struct mem_region *module = multiboot_find_module(bi, name);
    if (module == NULL) {
        debug_printf("could not find module [%s] in multiboot image\n", name);
        return SPAWN_ERR_FIND_MODULE;
    }


	return SYS_ERR_OK;
}

void print_modules(struct bootinfo *bi)
{
    for(size_t i = 0; i < bi->regions_length; i++) {
        struct mem_region *region = &bi->regions[i];

        const char *modname = multiboot_module_name(region);
		debug_printf("Module name = %s\n", modname);
    }

    return;
}


