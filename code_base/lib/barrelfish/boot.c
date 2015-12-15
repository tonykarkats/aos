#include <barrelfish/boot.h>

struct monitor_allocate_state { 
    void          *vbase; 
    genvaddr_t     elfbase; 
}; 

struct module_blob {
    size_t             size;
    lvaddr_t           vaddr;
    genpaddr_t         paddr;
    struct mem_region *mem_region;
};      

static errval_t monitor_elfload_allocate(void *state, genvaddr_t base,
                                         size_t size, uint32_t flags,
                                         void **retbase)
{
    struct monitor_allocate_state *s = state;
    
    debug_printf("Returning at retbase the address %p\n", (char *)s->vbase + base - s->elfbase);
    
    *retbase = (char *)s->vbase + base - s->elfbase;
    return SYS_ERR_OK;
}

/**
 * \brief This function prepares the boot of the second core by allocating
 *        a frame for it and mapping it to our own vspace.
 */
static errval_t cpu_memory_prepare(size_t *size, struct capref * cap_ret,
    							   void ** buf_ret, struct frame_identity *frameid)
{
    errval_t err;
    struct capref cap;

    // First we allocate the memory for the new core!	
    err = frame_alloc(&cap, *size, size);
    if (err_is_fail(err)) {
    	USER_PANIC("Failed to allocate memory for the second core! Error = %s\n", err_getstring(err));
    }	

    // Now we should map the frame into OUR vspace !
    // What flags? Ask ta.
    void *buf;

    err = paging_map_frame_attr(get_current_paging_state(), &buf, *size, 
    							cap, DEVICE_FLAGS, NULL, NULL);
    if (err_is_fail(err)) {
    	USER_PANIC("Failed to map core-frame into our vspace! Error = %s\n", err_getstring(err));
    }

    invoke_frame_identify(cap, frameid);
    if (err_is_fail(err)) {
    	return err_push(err, LIB_ERR_FRAME_IDENTIFY);
    }

    debug_printf("cpu_memory_prepare: Allocated a frame at physical base %"PRIu64" / 0x%x and mapped it at virtual address\n", frameid->base, frameid->base);

    *cap_ret = cap;
    *buf_ret = buf;
    return SYS_ERR_OK;
}


/**
 * \brief This function loads the ELF file and relocates it to a given physical address.
 *
 */
static errval_t
elf_load_and_relocate(lvaddr_t blob_start, 
    				  size_t blob_size,
                      void *to, 
    				  lvaddr_t reloc_dest,
                      uintptr_t *reloc_entry)
{

    genvaddr_t entry; // entry poing of the loaded elf image
    struct Elf32_Ehdr *head = (struct Elf32_Ehdr *)blob_start;
    struct Elf32_Shdr *symhead, *rel, *symtab;
    errval_t err;

    
    struct monitor_allocate_state state;
    state.vbase   = to;
    state.elfbase = elf_virtual_base(blob_start);

    err = elf_load(head->e_machine,
                   monitor_elfload_allocate,
                   &state,
                   blob_start, 
    			   blob_size,
                   &entry);
    if (err_is_fail(err)) {
        return err;
    }

    	
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

/**
 * \brief Spawns the second core on the pandaboard.
 * 
 * \params bi The bootinfo struct.
 * \params aux_core_0 The physical address of the first communication register for the processors.
 * \params aux_core_1 The physical address of the second communication register for the processors.
 */

errval_t spawn_second_core(struct bootinfo *bi, lvaddr_t aux_core_0, lvaddr_t aux_core_1) 
{
    errval_t err;

    char name[100] = "armv7/sbin/cpu_omap44xx";
    struct mem_region *module = multiboot_find_module(bi, name);
    if (module == NULL) 
    {
        debug_printf("could not find module [%s] in multiboot image\n", name);
        return SPAWN_ERR_FIND_MODULE;
    }
    
    struct module_blob cpu_blob;
    cpu_blob.mem_region = module;
 
    /* Lookup and map the elf image */
    err = spawn_map_module(module, &cpu_blob.size, &cpu_blob.vaddr, &cpu_blob.paddr);
    if (err_is_fail(err)) {
        return err_push(err, SPAWN_ERR_ELF_MAP);
    }

    assert(sizeof(struct arm_core_data) <= BASE_PAGE_SIZE);
    struct {
        size_t                size;
        struct capref         cap;
        void                  *buf;
    	struct frame_identity frameid;
    } cpu_mem = {
        .size = BASE_PAGE_SIZE + elf_virtual_size(cpu_blob.vaddr)
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
    err = elf_load_and_relocate(cpu_blob.vaddr, 
    							cpu_blob.size, 
    							cpu_mem.buf + BASE_PAGE_SIZE,
    							cpu_mem.frameid.base + BASE_PAGE_SIZE,
    							&reloc_entry);	
    if (err_is_fail(err)) {
    	DEBUG_ERR(err, "cpu_memory_prepare!\n");
    	return err;
    }

    // Allocate frame for urpc!
    struct capref ump_frame;
    struct frame_identity ump_id;

    size_t ump_frame_size = 4096;
    err = frame_alloc (&ump_frame, ump_frame_size, &ump_frame_size);
    if (err_is_fail(err)) {
    	debug_printf("Can not allocate slot for urpc frame!\n");
    	abort();
    }

    err = invoke_frame_identify(ump_frame, &ump_id);
    if (err_is_fail(err)) {
    	debug_printf("Can not identify frame for urpc cap!\n");
    	abort();
    }

    debug_printf("spawn_second_core: Base of UMP frame is 0x%x\n", ump_id.base);
    
    struct capref temp_frame = {
    	.cnode = cnode_task,
    	.slot = TASKCN_SLOT_UMPFRAME,
    };
    
    err = cap_copy(temp_frame, ump_frame);
    if (err_is_fail(err)) {
    	debug_printf("Can not copy shared frame at UMP slot!\n");
    	abort();
    }	

    struct arm_core_data *core_data = (struct arm_core_data *)cpu_mem.buf;

    struct Elf32_Ehdr *head32 = (struct Elf32_Ehdr *) cpu_blob.vaddr;
    core_data->elf.size = sizeof(struct Elf32_Shdr);
    core_data->elf.addr = cpu_mem.frameid.base + BASE_PAGE_SIZE + (uintptr_t)head32->e_shoff;
    core_data->elf.num  = head32->e_shnum;
    
    core_data->mods_addr = bi->mod_start;
    core_data->mods_count = bi->mod_count;
    core_data->mmap_addr = bi->mmap_addr;
    core_data->mmap_length = bi->mmap_length;

    core_data->src_core_id         = 0;
    core_data->dst_core_id         = 1;

    // Pass frame for ump
    core_data->ump_frame_addr = ump_id.base; 
    core_data->ump_frame_len  = ump_id.bits;

    *(lvaddr_t *) aux_core_1 = reloc_entry;
    *(lvaddr_t *) aux_core_0 |= 0x00000004;

    cap_destroy(ump_frame);

    return SYS_ERR_OK;
}

/**
 * \brief Prints all the available modules in the bootinfo structure
 * 
 * \params bi The bootinfo structure given.
 */

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


