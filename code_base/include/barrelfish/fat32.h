#include <string.h>
#include <ctype.h>
#include <math.h>
#include <barrelfish/barrelfish.h>
#include <barrelfish/aos_rpc.h>
#include <barrelfish/mmchs.h>
#include <barrelfish/dev_serv.h>
#include <barrelfish/aos_rpc.h>
#include <arch/arm/omap44xx/device_registers.h>

errval_t get_dirents(uint32_t DirSector, struct aos_dirent **dirtable, uint32_t *dir_size);

errval_t list(const char *path, struct aos_dirent **dirtable, uint32_t * size);

errval_t fat32_init(void);

uint32_t get_fat_entry(uint32_t cluster_nr);

errval_t get_data(uint32_t cluster_nr, void *buf);

errval_t read_file(const char *filename, void **buf, uint32_t position, uint32_t size, uint32_t * retsize, bool read_all_file);

uint32_t get_first_cluster(const char *filename, uint32_t *filesize);


