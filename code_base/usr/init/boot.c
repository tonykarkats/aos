#include "boot.h"

struct monitor_allocate_state { 
    void          *vbase; 
    genvaddr_t     elfbase; 
}; 

static errval_t monitor_elfload_allocate(void *state, genvaddr_t base,
                                         size_t size, uint32_t flags,
                                         void **retbase)
{
    struct monitor_allocate_state *s = state;

    *retbase = (char *)s->vbase + base - s->elfbase;
    return SYS_ERR_OK;
}

static errval_t cpu_memory_prepare(size_t * size, struct capref * cap_ret,
								   void ** buf_ret, struct frame_identity *frameid)
{
	errval_t err;
	struct capref cap;

	// First we allocate the memory for the new core!	
	debug_printf("cpu_memory_prepare: Allocating frame of size %zu..\n", *size);
	err = frame_alloc(&cap, *size, size);
	if (err_is_fail(err)) {
		USER_PANIC("Failed to allocate memory for the second core! Error = %s\n", err_getstring(err));
	}	

	// Now we should map the frame into OUR vspace !
	// What flags? Ask ta.
	void *buf;
	err = paging_map_frame_attr(get_current_paging_state(), &buf, *size, 
								cap, FLAGS, NULL, NULL);
	if (err_is_fail(err)) {
		USER_PANIC("Failed to map core-frame into our vspace! Error = %s\n", err_getstring(err));
	}
	
	debug_printf("Newly allocated frame for second core at %p\n", (char *)buf); 		

	invoke_frame_identify(cap, frameid);
	if (err_is_fail(err)) {
		return err_push(err, LIB_ERR_FRAME_IDENTIFY);
	}
	
	*cap_ret = cap;
	*buf_ret = buf;
	return SYS_ERR_OK;
}

static errval_t
elf_load_and_relocate(lvaddr_t blob_start, size_t blob_size,
                      void *to, lvaddr_t reloc_dest,
                      uintptr_t *reloc_entry)
{

    genvaddr_t entry; // entry poing of the loaded elf image
    struct Elf32_Ehdr *head = (struct Elf32_Ehdr *)blob_start;
    struct Elf32_Shdr *symhead, *rel, *symtab;
    errval_t err;

    //state.vbase = (void *)ROUND_UP(to, ARM_L1_ALIGN);
    struct monitor_allocate_state state;
    state.vbase   = to;
    state.elfbase = elf_virtual_base(blob_start);

    err = elf_load(head->e_machine,
                   monitor_elfload_allocate,
                   &state,
                   blob_start, blob_size,
                   &entry);
    if (err_is_fail(err)) {
        return err;
    }

    // Relocate to new physical base address
    symhead = (struct Elf32_Shdr *)(blob_start + (uintptr_t)head->e_shoff);
    rel = elf32_find_section_header_type(symhead, head->e_shnum, SHT_REL);
    symtab = elf32_find_section_header_type(symhead, head->e_shnum, SHT_DYNSYM);
    assert(rel != NULL && symtab != NULL);

    elf32_relocate(reloc_dest, state.elfbase,
                   (struct Elf32_Rel *)(blob_start + rel->sh_offset),
                   rel->sh_size,
                   (struct Elf32_Sym *)(blob_start + symtab->sh_offset),
                   symtab->sh_size,
                   state.elfbase, state.vbase);

    *reloc_entry = entry - state.elfbase + reloc_dest;

    return SYS_ERR_OK;
}



errval_t invoke_monitor_spawn_core(struct capref c_kernel, coreid_t core_id, enum cpu_type cpu_type, 
                          forvaddr_t entry) 
{ 
    uint8_t invoke_bits = get_cap_valid_bits(cap_kernel); 
    capaddr_t invoke_cptr = get_cap_addr(cap_kernel) >> (CPTR_BITS - invoke_bits); 
 
    return syscall6((invoke_bits << 16) | (KernelCmd_Spawn_core << 8) 
                    | SYSCALL_INVOKE, invoke_cptr, core_id, cpu_type, 
                    (uintptr_t)(entry >> 32), (uintptr_t) entry).error; 
} 
 
errval_t spawn_second_core(struct bootinfo *bi) 
{
	errval_t err;

	char name[100] = "armv7/sbin/cpu_omap44xx";
    struct mem_region *module = multiboot_find_module(bi, name);
    if (module == NULL) 
	{
        debug_printf("could not find module [%s] in multiboot image\n", name);
        return SPAWN_ERR_FIND_MODULE;
    }
	
	debug_printf("Found cpu_omap44xx module. Base = %p and size = %zu \n",
			  module->mr_base, module->mrmod_size);

	debug_printf("Mapping cpu module in our vspace... Returning the size and the location of the image.\n");
    
	/* Lookup and map the elf image */
    lvaddr_t binary;
    size_t binary_size;
    err = spawn_map_module(module, &binary_size, &binary, NULL);
    if (err_is_fail(err)) {
        return err_push(err, SPAWN_ERR_ELF_MAP);
    }

	// Helping struct for keeping cpu info 
	// Size of region will be BASE_PAGE_SIZE + binary_size
    assert(sizeof(struct arm_core_data) <= BASE_PAGE_SIZE);
    struct {
        size_t                size;
        struct capref         cap;
        void                  *buf;
    	struct frame_identity frameid;
	} cpu_mem = {
        .size = BASE_PAGE_SIZE + elf_virtual_size(binary)
    };

	// Allocating the memory NEEDED for the new kernel to boot up
	// This function will call frame alloc and map this frame to a NEWLY
	// allocated memory in our vspace!
	err = cpu_memory_prepare( &cpu_mem.size, 
						&cpu_mem.cap,
						&cpu_mem.buf,
						&cpu_mem.frameid); 
	if (err_is_fail(err)) {
		USER_PANIC("Error in cpu_memory_prepare! Error = %s\n", err_getstring(err));
	}

	// Time to load the cput driver to the newly allocated memory 
	// and perform the relocation! 
	uintptr_t reloc_entry= 0;
	err = elf_load_and_relocate(binary, 
								binary_size, 
								cpu_mem.buf + BASE_PAGE_SIZE,
								cpu_mem.frameid.base + BASE_PAGE_SIZE,
								&reloc_entry);	
	if (err_is_fail(err)) {
		DEBUG_ERR(err, "cpu_memory_prepare!\n");
		return err;
	}
	
    struct arm_core_data *core_data = (struct arm_core_data *)cpu_mem.buf;

    struct Elf32_Ehdr *head32 = (struct Elf32_Ehdr *)binary;
    core_data->elf.size = sizeof(struct Elf32_Shdr);
    core_data->elf.addr = cpu_mem.frameid.base + (uintptr_t)head32->e_shoff;
    core_data->elf.num  = head32->e_shnum;

    core_data->module_start        = cpu_mem.frameid.base;
    core_data->module_end          = cpu_mem.frameid.base + ;
    //core_data->urpc_frame_base     = urpc_frame_id.base;
    //core_data->urpc_frame_bits     = urpc_frame_id.bits;
    //core_data->monitor_binary      = monitor_blob.paddr;
    //core_data->monitor_binary_size = monitor_blob.size;
    //core_data->memory_base_start   = spawn_mem_frameid.base;
    //core_data->memory_bits         = spawn_mem_frameid.bits;
    core_data->src_core_id         = 0;
    core_data->src_arch_id         = my_arch_id;
    core_data->dst_core_id         = 1;
	
	

	debug_printf("spawn_second_core returning...\n");
	
	return SYS_ERR_OK;
}

void print_modules(struct bootinfo *bi)
{
    for(size_t i = 0; i < bi->regions_length; i++) {
        struct mem_region *region = &bi->regions[i];

        const char *modname = multiboot_module_name(region);
		debug_printf("Module name = %s , base = %p , size = %zu\n", modname, 
				  	 	region->mr_base, region->mrmod_size);
    	debug_printf("Size = %zu\n", region->mrmod_size);
		if (region->mr_type == RegionType_Module)
			debug_printf("Region describes a module..\n");
		else 
			debug_printf("Region is not a module..\n");
	}

    return;
}


