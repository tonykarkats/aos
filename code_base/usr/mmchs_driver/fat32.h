#include <barrelfish/barrelfish.h>

enum filetype {
	typeFile,
	typeDir
};

struct dirent {

	char name[13]; // <- For now we hold just the small name
	enum filetype type;
	uint32_t size;
	uint32_t firstCluster;

};


errval_t get_dirents(uint32_t DirSector, struct dirent **dirtable, uint32_t *dir_size);

errval_t list(const char *path, struct dirent **dirtable, uint32_t * size);

errval_t read_file(const char *filepath, char *buf);

errval_t fat32_init(void);

uint32_t get_fat_entry(uint32_t cluster_nr);




