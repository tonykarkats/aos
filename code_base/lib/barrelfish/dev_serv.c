#include <barrelfish/dev_serv.h>

static struct mm dev_mm;

errval_t get_devframe(struct capref * ret, size_t * retlen, lpaddr_t start_addr, size_t length)
{
	errval_t err;

	// debug_printf("Aseked for addr 0x%p and length %"PRIu32"\n", start_addr, length);
	//genpaddr_t ret_base;
	//err = mm_alloc_range(&dev_mm, length, start_addr, 0x8000000, ret, &ret_base);
	err = mm_realloc_range( &dev_mm, length, start_addr,ret);
	if (err_is_fail(err)) {
		debug_printf("get_dev_frame: can not allocate range for device!\n");
		return MM_ERR_DEVICE_ALLOC;
	}
	*retlen = ((0x80000000 - start_addr) < length) ? (0x80000000 - start_addr) : length;

	return SYS_ERR_OK;
}

errval_t init_devserver(void) 
{
	errval_t err;	

	// Initialize device memory allocator 
	static struct range_slot_allocator devframes_allocator;
    err = range_slot_alloc_init(&devframes_allocator, 1024, NULL);
    if (err_is_fail(err)) {
        return err_push(err, LIB_ERR_SLOT_ALLOC_INIT);
    }
	
	err = mm_init(&dev_mm, ObjType_DevFrame,
                  0x40000000,  30,
                  1, slab_default_refill, slot_alloc_dynamic,
                  &devframes_allocator, false);
    if (err_is_fail(err)) {
        return err_push(err, MM_ERR_MM_INIT);
    }

	err = mm_add(&dev_mm, cap_io, 30, 0x40000000);
	if (err_is_fail(err)) {
		debug_printf("Error in adding device frame to device memory manager!\n");
		return err_push(err, MM_ERR_MM_ADD);
	}

	return SYS_ERR_OK;
}

