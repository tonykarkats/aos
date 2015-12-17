#include <barrelfish/fat32.h>

static uint16_t BPB_BytsPerSec;
static uint8_t BPB_SecPerClus;
static uint8_t BPB_NumFATs;
static uint32_t FATSz;
static uint16_t BPB_RsvdSecCnt;
static uint32_t FirstDataSector;
static uint32_t BPB_RootClus;
static uint32_t FirstSectorofRootDir;
static struct cnoderef cnode;
struct module_node * module_list_head;

/**
 * \brief This function retrieves a module from the module cache if it is available. 
 *	  The cache significantly increases performance when the module is requested 
 *	  more than one times.
 * \param module_name The name of the module.
 */
struct module_node * get_module_from_cache(char *module_name) 
{
	struct module_node * module_node = module_list_head;

	while (module_node != NULL) {
		if (!strcmp(module_node->module_name, module_name)) {
			debug_printf("Found %s \n", module_node->module_name);
			return module_node;
		} 
		module_node = module_node->next;
	}

	return NULL;
}

/**
 * \brief This function puts a module into the cache.
 *
 * \param module_name The name of the module.
 * \param module_data The data of the module.
 * \param len The size of the module.
 */
void put_module_in_cache( char *module_name, char * module_data, size_t len) 
{

	struct module_node * mod = (struct module_node *) malloc(sizeof(struct module_node));
	
	mod->module_name = malloc(strlen(module_name));
	strcpy(mod->module_name, module_name);

	mod->module_data = module_data;
	mod->len = len;
	mod->next = module_list_head;

	module_list_head = mod;

}

static errval_t get_cap(lpaddr_t base, size_t size)
{
    errval_t err;
    size_t len;

    struct capref cap;
	size_t size_log = log2floor(size);
	
    err =  get_devframe(&cap, &len, base, size_log);
    if (err_is_fail(err)) {
        USER_PANIC_ERR(err, "get_dev_mem rpc failed\n");
    }

    struct capref argcn = {
        .cnode = cnode_root,
        .slot = TASKCN_SLOT_ARGSPAGE
    };

    size_t bits = 8; // TODO(gz): How do I figure this value out on the fly?
    struct capref device_cap_iter = {
        .cnode = build_cnoderef(argcn, bits),
        .slot = 0
    };

    static size_t current_slot = 0;
    device_cap_iter.slot = current_slot++;

    err = cap_copy(device_cap_iter, cap);
    if (err_is_fail(err)) {
        USER_PANIC_ERR(err, "cap_copy failed.");
    }

	return SYS_ERR_OK;
    assert(err_is_ok(err));
}

/**
 * \brief Initialize the FAT-32 system.
 */
errval_t fat32_init(void) {

	errval_t err;

   struct capref argcn = {
        .cnode = cnode_root,
        .slot = TASKCN_SLOT_ARGSPAGE
    };

    err = cnode_create_raw(argcn, &cnode, 255, NULL);
    if (err_is_fail(err)) {
        USER_PANIC_ERR(err, "can not create the cnode failed.");
    }

    get_cap(OMAP44XX_CM2 & ~0xFFF, 0x1000);
    get_cap(OMAP44XX_CLKGEN_CM2 & ~0xFFF, 0x1000);
    get_cap(OMAP44XX_I2C1 & ~0xFFF, 0x1000);
    get_cap(OMAP44XX_SYSCTRL_PADCONF_CORE & ~0xFFF, 0x1000);
    get_cap(OMAP44XX_MMCHS1 & ~0xFFF, 0x1000);

    cm2_init();
    ti_twl6030_init();
    ctrlmod_init();
    cm2_enable_hsmmc1();
    sdmmc1_enable_power();

    mmchs_init();
	
    void *buffer = malloc(512);
    assert(buffer != NULL);

    err = mmchs_read_block(0, buffer);
    assert(err_is_ok(err));


	BPB_BytsPerSec = (((uint8_t*) buffer)[12] <<  8) +
				   			  ((uint8_t*) buffer)[11];

	debug_printf("Bytes Per Sector: %d\n", BPB_BytsPerSec);


	BPB_SecPerClus =  ((uint8_t*) buffer)[13];
	debug_printf("Number of Sectors per Cluster: %d\n", BPB_SecPerClus);

	BPB_NumFATs =  ((uint8_t*) buffer)[16];
	debug_printf("Number of FATs: %d\n", BPB_NumFATs);

	FATSz = 	(((uint8_t*) buffer)[39] << 24) +
				   		(((uint8_t*) buffer)[38] << 16) +
				   		(((uint8_t*) buffer)[37] <<  8) +
				   		((uint8_t*) buffer)[36];
	debug_printf("Size of FAT: %d\n", FATSz);

	BPB_RsvdSecCnt = (((uint8_t*) buffer)[15] <<  8) +
				   			  ((uint8_t*) buffer)[14];

	debug_printf("Number of reserved sectors: %d\n", BPB_RsvdSecCnt);

	// Calculate the start of the data region
	FirstDataSector = BPB_RsvdSecCnt + (BPB_NumFATs*FATSz);
	debug_printf("First Data Sector: %d\n", FirstDataSector);

	// Calculate first cluster of root directory
		
	BPB_RootClus = 	(((uint8_t*) buffer)[47] << 24) +
				   				(((uint8_t*) buffer)[46] << 16) +
				   				(((uint8_t*) buffer)[45] <<  8) +
				   				((uint8_t*) buffer)[44];
	debug_printf("First cluster of Root Directory: %d\n", BPB_RootClus);


	// Now we have to find the sector number of the root directory
	
	FirstSectorofRootDir = ((BPB_RootClus-2)*BPB_SecPerClus + FirstDataSector);
	debug_printf("First sector of Root Directory : %d\n", FirstSectorofRootDir); 

	return SYS_ERR_OK;
}

/**
 * \brief Get the entities of a directory with a given sector number.
 * 
 * \params DirSector The sector number of the directory.
 * \params dirtable The returned table of directory entries.
 * \params dir_size The size of the returned table (Number of entries in the directory).
 */
errval_t get_dirents(uint32_t DirSector, struct aos_dirent **dirtable, uint32_t *dir_size) {

	errval_t err;

	void *buffer = malloc(512);
	
	err = mmchs_read_block(DirSector, buffer);
	if (err_is_fail(err)) {	
		debug_printf("Can not read block from card\n");
		return err;	
	}
	
	bool has_entry = (((uint8_t*)buffer)[32] != 0x00 ? true  : false);
	uint32_t entry_count = 1;

	int cnt = 1;
	uint32_t files = 0;	
	while(((uint8_t *)buffer)[32*cnt] != 0x00) {
	
		uint32_t ent_start = cnt*32;
		uint8_t attr1 = (((uint8_t *)buffer)[ent_start+11]);

		if ((attr1 == 0x10)||(attr1 == 0x20))  {
			files++;
		}
		cnt++;
	}

	// printf("\nNr of files : %d\n", files);
	
	*dirtable = (struct aos_dirent *)malloc(files*sizeof(struct aos_dirent));

	int table_cnt = 0;
	while (has_entry) {
		has_entry = (((uint8_t*)buffer)[32*entry_count] != 0x00 ? true  : false);
		uint32_t entry_start = entry_count*32;
		
		uint8_t attr = 	(((uint8_t *)buffer)[entry_start+11]);
		
		if ( (attr == 0x10) || (attr == 0x20))  {	

			struct aos_dirent dirent;
			for (int i=entry_start, j=0; i<=entry_start+10; j++, i++) {
				dirent.name[j] = ((uint8_t *)buffer)[i];
			}	
			dirent.name[11] = '\0';	
				
			dirent.type = (((uint8_t *)buffer)[entry_start+11] == 0x10) ? typeDir : typeFile;	
	
			dirent.size =  (((uint8_t*) buffer)[entry_start + 31] << 24) +
    	                    (((uint8_t*) buffer)[entry_start + 30] << 16) +
        	                (((uint8_t*) buffer)[entry_start + 29] <<  8) +
            	            ((uint8_t*) buffer)[entry_start + 28];

			dirent.firstCluster =  (((uint8_t*) buffer)[entry_start + 27] <<  8) +
        	                	   ((uint8_t*) buffer)[entry_start + 26];

			(*dirtable)[table_cnt] = dirent;
			table_cnt++;

			//debug_printf("Name = %s\n", dirent.name);
			//debug_printf("Type = %s\n", (dirent.type == typeFile) ? "FILE" : "DIRECTORY");
			//debug_printf("Size = %" PRIu32 "\n", dirent.size);
			//debug_printf("First Cluster = %" PRIu16 "\n", dirent.firstCluster);
		}
	
		entry_count++;
	}

	free(buffer);
	*dir_size = files;

	return SYS_ERR_OK;

}

/**
 * \brief This function lists the entries of the pathname specified.
 * 		  If the pathname is a directory a dirtable is returned.
 * 	 	  If the pathname corresponds to a file then dirtable = NULL is returned.
 */
errval_t list(const char * dir_path, struct aos_dirent **dirtable, uint32_t *size) {


	// Split up the path and recursively look into the directories until we find the file
	// or directory
	char * path = malloc(100);
	strcpy(path, dir_path);
	for (int i = 0 ; i < strlen(path); i++) {
		char c = path[i];
		if (islower((int) c))
			path[i] = toupper((int) c);
	}
	
//	debug_printf("Will search for %s\n", path);
	errval_t err;

	//Get root dirents to start with
  	uint32_t size_root;
	struct aos_dirent *dirtable_root = NULL;
  	err = get_dirents(FirstSectorofRootDir, &dirtable_root, &size_root);
	assert(err_is_ok(err));

	char s[32];
	strcpy(s, path);

	struct aos_dirent * cur_table = dirtable_root;
	uint32_t cur_size = size_root;
	bool found = false;

	// If root path is requested return it
	if (!strcmp(s, "/")) {
		*dirtable = dirtable_root;
		*size = size_root;
		return SYS_ERR_OK;
	}

	for (char *p = strtok(s,"/"); p != NULL; ) {
			
			for (int i=0; i<cur_size; i++) {
				struct aos_dirent dirent;
				dirent = cur_table[i];
				char stripped[11];

				int k;
 				for (k=0; dirent.name[k] != ' '; k++) {
				   stripped[k] = dirent.name[k];
			    }
			    stripped[k] = '\0';

				if (!strcmp(stripped, p)) {
					found = true;
		
					// debug_printf("Found name %s. Moving deeper. firstCluster = %" PRIu32 "\n", dirent.name, dirent.firstCluster);
					uint32_t first_cluster = ((dirent.firstCluster  -2)*BPB_SecPerClus + FirstDataSector);
					
					p = strtok(NULL, "/");

					if ((dirent.type != typeDir)&&(p == NULL)) {

						struct aos_dirent* file_dirent = (struct aos_dirent *) malloc(sizeof(struct aos_dirent));
						*file_dirent = dirent;
						//free(cur_table);
						
						*dirtable = file_dirent;
						*size = 1;
							
						return SYS_ERR_OK;						
					}
					
					if (dirent.type != typeDir) {
						free(cur_table);
						return AOS_ERR_FAT_FILE_NOT_FOUND;
					}

				
					err = get_dirents(first_cluster, &cur_table, &cur_size);
					if (p != NULL)
						free(cur_table);
					else {
						*dirtable = cur_table;
						*size  = cur_size;
						return SYS_ERR_OK;				
					}

					if (err_is_fail(err)) {
						return err;
					}
				 							
					break;
				}
				found = false;
			} 
					
			if (!found) {
				return AOS_ERR_FAT_FILE_NOT_FOUND;
			}	
	}

	free(path);
	return SYS_ERR_OK;
}

/**
 * \brief Returns the contents of the FAT32 entry for the given cluster_nr
 * 
 * \params cluster_nr The cluster number of the requested cluster.
 * \return The FAT table entry value corresponding to this cluster number.
 */
uint32_t get_fat_entry(uint32_t cluster_nr) {

	uint32_t FATOffset = cluster_nr * 4;

	uint32_t ThisFATSecNum = BPB_RsvdSecCnt + (FATOffset / BPB_BytsPerSec);
	uint32_t ThisFATEntOffset = FATOffset % BPB_BytsPerSec;

	//debug_printf("cluster_nr %" PRIu32 " fatsecnum %" PRIu32 " fatentoffset %" PRIu32 "\n", cluster_nr, ThisFATSecNum, ThisFATEntOffset);	
	char * secBuff = malloc(BPB_BytsPerSec);
	
	mmchs_read_block(ThisFATSecNum, secBuff);
 	//uint32_t FAT32ClusEntryVal =   (*((uint32_t *)(secBuff + ThisFATEntOffset))) & 0x0FFFFFFF;
	uint32_t FAT32ClusEntryVal = (*((uint32_t *) &secBuff[ThisFATEntOffset])) & 0x0FFFFFFF;
	
	if (FAT32ClusEntryVal >= 0x0FFFFFF8) {
		; //debug_printf("Reached end!\n");
	}	

	free(secBuff);
	
	return FAT32ClusEntryVal;
}

/**
 * \brief  This function reads the data corresponding to a specific cluster number
 * 		   from the data section.
 * \params cluster_nr The cluster number of the cluster.
 * \params buf The buffer to be filled with the data.
 */
errval_t get_data(uint32_t cluster_nr, void *buf) {

	errval_t err;
	//debug_printf("Buff addr  = %p\n", buf);
	
	uint32_t sector = ((cluster_nr - 2) * BPB_SecPerClus) + FirstDataSector;

	err = mmchs_read_block(sector, buf);
	if (err_is_fail(err)) {
		debug_printf("Cannot read block from SD card\n");
		return AOS_ERR_FAT_FILE_NOT_FOUND;
	}
	
	//char * vbuf = (char *)buf;
	//for (int i = 0; i < 512 ; i++) {
	//	debug_printf("   %c\n", vbuf[i] );
	//}	
		

	return SYS_ERR_OK;
}

/* \brief Given a valid cluster_nr for the start of the file this function:
 * 		  -> Reads the actual data from the data section for that cluster_nr.
 * 		  -> Retrieves the next FAT entry from the FAT table and repeats until EOC.
 * \params filename The full pathname of the file to read.
 * \params buf The buffer to be filled in with the data.
 * \params position The position inside the file that we want to read from.
 * \params size The size that we want to read.
 * \params retsize The returned size that was read.
 * \params Flag to indicate whether the whole file should be read. In this case postion and size don't matter.
 */
errval_t read_file(const char *filename, void **buf, uint32_t position, uint32_t size, uint32_t * retsize, bool read_all_file) {

	errval_t err;

	//debug_printf("%s\n", filename);	
	
	// Calculate how many blocks the file needs
	uint32_t first_cluster;
    uint32_t filesize;
    first_cluster = get_first_cluster(filename, &filesize);

	module_list_head = NULL;
	
	//debug_printf("first cluster = %" PRIu32 " size of file = %" PRIu32 "\n", first_cluster, filesize);

    if (first_cluster != -1) { // If file exists
		
		if (read_all_file) {
			position = 0;
			size = filesize;
		}	
		else if (position + size > filesize) {
			size = filesize - position;
		}
		else if (position >= filesize) {
			*retsize = 0;
			*buf = NULL;
			return SYS_ERR_OK;
		}

		// First calculate the number of blocks the file needs in order to allocate the buffer        
		uint32_t cluster_chain[4096];
		//uint32_t total_blocks = (filesize % BPB_BytsPerSec == 0) ? (filesize/BPB_BytsPerSec) : (filesize/BPB_BytsPerSec + 1); 	

		uint32_t starting_block = position / BPB_BytsPerSec;
		uint32_t ending_block = (position + size) / BPB_BytsPerSec;
		uint32_t starting_offset = (position % BPB_BytsPerSec);

		uint32_t blocks_needed = (ending_block - starting_block + 1);

		//debug_printf("Total blocks %" PRIu32 "\n", total_blocks);
		//debug_printf("File size %" PRIu32 "\n", filesize);
		//debug_printf("Blocks Needed: %d\n", blocks_needed);
		//debug_printf("Starting Block: %d\n", starting_block);
		//debug_printf("Ending Block: %d\n", ending_block);
		//debug_printf("Starting Offset: %d\n", starting_offset);

		// Follow every cluster in the clusterchain of the FAT table
		uint32_t cur_cluster = first_cluster;
		for (int i=0; i<ending_block; i++) {
			//debug_printf("next cluster = %" PRIu32 "\n", cur_cluster);
			cluster_chain[i] = cur_cluster;
			cur_cluster = get_fat_entry(cur_cluster);
		}

		// This buffer holds all the blocks needed
		char * data_buffer = (char *)malloc(blocks_needed * BPB_BytsPerSec + 1);
		for (int i=0 ; i<blocks_needed; i++) {	
			//debug_printf("next_block = %" PRIu32 "\n", cluster_chain[starting_block + i]);
			err = get_data(cluster_chain[starting_block + i], data_buffer + i*BPB_BytsPerSec);
		}

		//debug_printf("All blocks are read!\n");	
		// This is the buffer that will be returned
		// It is actually a stripped version of the first one
		
		char *final_buffer = (char *)malloc(size);
		memcpy(final_buffer, data_buffer + starting_offset, size);	
		free(data_buffer);

		*retsize = size;	
		*buf = final_buffer;	
		
	
		return SYS_ERR_OK;
    }

	return AOS_ERR_FAT_FILE_NOT_FOUND;
}



/**
 *  \brief This function searches the filetree recursively until it finds the filename requested.
 *  \params filename The name of the file.
 *  \params filesize The returned filesize.
 *	\returns The first cluster of the file or -1 if the file was not found.
 */
uint32_t get_first_cluster(const char *filename, uint32_t *filesize) {
	
	errval_t err;
	struct aos_dirent * dirtable = NULL;
    uint32_t size;
	
    err = list(filename, &dirtable, &size);
	if (err_is_fail(err)) {
		*filesize = 0;
		return -1;
	}

	//If this file has been found then only one direntry will be returned
	struct aos_dirent dirent;
	dirent = dirtable[0];

	*filesize = dirent.size;

	return dirent.firstCluster;
}




