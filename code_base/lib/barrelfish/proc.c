#include <barrelfish/proc.h>
#include <barrelfish/mem_serv.h>

/**
 * \brief Searches through the process list for a process node with a given name or domain id.
 *        One of did or name must not be NULL. 
 *
 * \param head The head of the process list.
 * \param did The domain id to search for.
 * \param name The name to search for.
 * 
 * \return The node that was found or NULL if no node was found.
 */
struct process_node * get_process_node(struct process_node ** head, domainid_t did, char * name) 
{
	struct process_node * active = *head;
	struct process_node * previous = *head;
	
	if (*head == NULL)
		return NULL;
	
	while (((active->d_id != did)||(!strcmp(name, active->name)))&&(active->next_pr != NULL)) {
		previous = active;
		active = active->next_pr;
	}

	return active;
}


/**
 * \brief Deletes from the process list a process node with a given name or domain id.
 *        One of did or name must not be NULL. 
 *
 * \param head The head of the process list.
 * \param did The domain id to search for.
 * \param name The name to search for.
 * 
 */
struct process_node * delete_process_node(struct process_node ** head, domainid_t did, char * name) 
{
	struct process_node * active = *head;
	struct process_node * previous = *head;
	
	if (*head == NULL)
		return NULL;
	
	while (((active->d_id != did)||(!strcmp(name, active->name)))&&(active->next_pr != NULL)) {
		previous = active;
		active = active->next_pr;
	}

	if (((active->d_id == did)||(!strcmp(name, active->name)))&&(active == *head)) {
		*head = active->next_pr;		
		return active;
	}

	if ((active->d_id == did)||(!strcmp(name, active->name))) {
		previous->next_pr = active->next_pr;
		return active;	
	}
	
	return NULL;
}


/**
 * \brief Inserts a new process node into the process list.
 *        One of did or name must not be NULL. 
 *
 * \param head The head of the process list.
 * \param did The domain id of the new process.
 * \param name The name of the new process.
 * \param background Whether the process is spawned on the background.
 * \param client_endpoint The endpoint of the client that spawned the process.
 * \param dispatcher_frame Unused
 * 
 */
struct process_node* insert_process_node(struct process_node * head, domainid_t did, char * name, bool background, struct capref client_endpoint, struct capref dispatcher_frame) {

	struct process_node* new_node = (struct process_node *) malloc(sizeof(struct process_node));

	new_node->d_id = did;
	new_node->name = malloc(strlen(name)+1);
	memcpy(new_node->name, name, strlen(name) + 1);

		
	//debug_printf("inserted %s and name %s\n", new_node->name, name);

	new_node->memory_consumed = 0;	
	new_node->next_pr = NULL;
	new_node->consumed_frame = NULL;
	new_node->fd_node = NULL;
	new_node->background = background;
	new_node->client_endpoint = client_endpoint;
	new_node->dispatcher_frame = dispatcher_frame;


	if (head == NULL) {
		return new_node;
	}

	new_node->next_pr = head;
	return new_node;
}

/**
 * \brief Retrieves a process with a given name from the process list.
 *
 * \param head The head of the process list.
 * \param name The name to search for.
 *
 * \return The domain id of the process found or 0 if it was not found.
 * 
 */
domainid_t get_did_by_name(struct process_node * head, const char * name) 
{
	struct process_node * node = head;

	while (node != NULL) {
		if (!strcmp(node->name, name)) 
			return node->d_id;
		node = node->next_pr;
	}

	return 0;
	
}

/**
 * \brief Retrieves a process with a given domain id from the process list.
 *
 * \param head The head of the process list.
 * \param did The domain id to search for.
 *
 * \return The name of the process found or NULL if it was not found.
 * 
 */
char * get_name_by_did(struct process_node * head, domainid_t did) 
{
	struct process_node * node = head;

	while (node != NULL) {
		if (node->d_id == did) 
			return node->name;
		node = node->next_pr;
	}

	return NULL;
	
}

/**
 * \brief Helper function that prints all the nodes of a process list.
 */
void print_nodes( struct process_node *head) 
{
	struct process_node * node = head;

	while (node != NULL) {
		debug_printf("Node: Name %s Did %zu \n", node->name, node->d_id);
		node = node->next_pr;
	}	

}

/**
 * \brief Free up all the resources a process node consumes.
 */
void clear_process_node(struct process_node *node) 
{
	errval_t err;

	struct frame_node* head_frame = node->consumed_frame;
	struct frame_node* temp;
	
	// First free ALL allocated frames and also 
	// free regions in mm_ram allocator
	while (head_frame != NULL) {

		
		err = memserv_free(head_frame->frame, head_frame->base, head_frame->bits);
		if (err_is_fail(err)) {
			debug_printf("Can not free frame in mm_ram allocator!\n");	
		}	
		
		cap_revoke(head_frame->frame);
		
		temp = head_frame;
		head_frame = head_frame->next_frame;		
		free(temp);
	}

	// Then free everything else in the node	
	free(node->name);

	// Free shared frame with the client 
	struct frame_identity fid;
	err = invoke_frame_identify(node->shared_frame, &fid);
	if (err_is_ok(err)) {	
		memserv_free(node->shared_frame, fid.base, fid.bits);		
	}

	// Free all file descriptor nodes!
	struct file_descriptor_node * head_fd = node->fd_node;
	struct file_descriptor_node * temp_fd;

	while (head_fd != NULL) {
		temp_fd = head_fd->next_file_descriptor;
		free(head_fd->file_name);
		free(head_fd);
	}

	cap_destroy(node->client_endpoint);

	err = paging_unmap(get_current_paging_state(), NULL);
	if (err_is_fail(err)) {
		debug_printf("Can not unmap for terminated process!\n");
	}

	err = paging_free(get_current_paging_state(), node->buffer);
	if (err_is_fail(err)) {
		debug_printf("Can not free memory region of terminated process!\n");
	}

	return;
}

/**
 * \brief Insert a new file into the open files list.
 */
void update_fd_list (struct process_node *node, int fd, int poss, char * name) 
{

	struct file_descriptor_node* new_fd = ( struct file_descriptor_node *) malloc(sizeof(struct file_descriptor_node));

	new_fd->file_name = malloc(strlen(name)+1);
	strncpy(new_fd->file_name, name, strlen(name)+1);

	new_fd->fd = fd;
	new_fd->possition_in_file = poss;
	new_fd->next_file_descriptor = node->fd_node;

	node->fd_node = new_fd;

	return;
}

/**
 * \brief Checks if a file descriptor exists in an open files list.
 */
char * check_if_fd_exists(struct file_descriptor_node *node, int fd) 
{
	struct file_descriptor_node * head = node;

	if (head == NULL)
		return NULL;
			
	while(head != NULL) {
		if (head->fd == fd)
			return head->file_name;	
		head = head->next_file_descriptor;
	}

	return NULL;
}

/**
 * \brief Deletes a file descriptor from an open files list.
 */
bool delete_fd(struct process_node *node, int fd) 
{
	struct file_descriptor_node * head = node->fd_node;
	struct file_descriptor_node * temp = node->fd_node;
	
	if (head == NULL)
		return false;
			
	if (head->fd == fd) {
		node->fd_node = NULL;
		free(head);
		return true;
	}

	temp = head;	
	head = head->next_file_descriptor;
	
	while (head != NULL) {
		if (head->fd == fd) {
			temp->next_file_descriptor = head->next_file_descriptor;
			free(head);
			return true;
		}	
		temp = head;
		head = head->next_file_descriptor;
	}

	return false;
}


void update_frame_list(struct process_node *node, struct capref ram, size_t bits, genpaddr_t base) 
{	
	struct frame_node* new_frame_node = (struct frame_node *) malloc(sizeof(struct frame_node));
	new_frame_node->bits = bits;
	new_frame_node->frame = ram;
	new_frame_node->base = base;
	
	new_frame_node->next_frame = node->consumed_frame;
	node->consumed_frame = new_frame_node;
	
	return;
}

errval_t locate_and_map_shared_frame( struct process_node *node, struct capref * ret, void **buf) 
{
	////struct capref ram;
	errval_t err;
	
    err = 1;
    if (err_is_fail(err)){ 
        debug_printf("get_frame : Error in ram_alloc!\n");
        return err_push(err, LIB_ERR_RAM_ALLOC);
    }

	return SYS_ERR_OK;


}

/**
 * \brief Spawns a new domain on the given core.
 *
 * \param name The name of the domain to spawn. Will be prefixed with armv7/sbin/
 * \param domain_si The spawinfo struct of the domain.
 * \param bi The bootinfo struct.
 * \param my_core_id Core in which to spawn the domain.
 * \param dispatcher_frame The saved dispatcher frame.
 * \param did Domain id.
 * \param elf_vaddr The address of the elf to load from - if NULL then elf is loaded from multiboot image
 * \param elf_size The size of the elf - Used only IF elf_vaddr != NULL.
 *
 */
errval_t bootstrap_domain(const char *name, struct spawninfo *domain_si, struct bootinfo* bi,
			  coreid_t my_core_id, struct capref* dispatcher_frame, domainid_t did,
			  char * elf_vaddr, uint32_t elf_size)
{

	errval_t err;
	char prefix[100] = "armv7/sbin/";	
	
	char * module_name = strcat(prefix, name);

	err = spawn_load_with_bootinfo(domain_si, bi, module_name, my_core_id, did, elf_vaddr, elf_size);
	if (err_is_fail(err)) {
		debug_printf("spawn_load_with_bootinfo: ERROR in loading module %s! Error %s\n", name, err_getstring(err));
		return SPAWN_ERR_LOAD;
	}

	err = spawn_run(domain_si);
	if (err_is_fail(err)) {
		debug_printf("spawn_load_with_bootinfo: ERROR in running module %s!\n", name);
		return SPAWN_ERR_RUN;
	}
	
	spawn_free(domain_si);
	*dispatcher_frame = domain_si->dispframe;	

	return SYS_ERR_OK;
}
