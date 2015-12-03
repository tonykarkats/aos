#include <string.h>
#include <barrelfish/dispatcher_arch.h>
#include <barrelfish/debug.h>
#include <spawndomain/spawndomain.h>
#define UNUSED(x) (x) = (x)
#include "../../lib/spawndomain/arch.h"
#include "boot_strap.h"

errval_t bootstrap_domain(const char *name, struct spawninfo *domain_si, struct bootinfo* bi, struct coreid_t my_core_id)
{
	// debug_printf("bootstrap_domain: Starting... Address of domain_si %p and name %p\n", domain_si, name);
	
	errval_t err;
	char prefix[12] = "armv7/sbin/";	

	char * module_name = strcat(prefix, name);

	// debug_printf("Before spawning the module!\n");	
	err = spawn_load_with_bootinfo(domain_si, bi, module_name, my_core_id);
	if (err_is_fail(err)) {
		debug_printf("spawn_load_with_bootinfo: ERROR!\n");
		return err;
	}

	err = spawn_run(domain_si);
	if (err_is_fail(err)) {
		debug_printf("bootstrap_domain: Error in spawn run!\n");
		return err;
	}

	err = spawn_free(domain_si);
	
	return SYS_ERR_OK;
}
