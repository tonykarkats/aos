#include <barrelfish/proc.h>


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

struct process_node* insert_process_node(struct process_node * head, domainid_t did, char * name, bool background, struct capref client_endpoint, struct capref dispatcher_frame) {

	struct process_node* new_node = (struct process_node *) malloc(sizeof(struct process_node));

	new_node->d_id = did;
	new_node->name = malloc(strlen(name)+1);
	memcpy(new_node->name, name, strlen(name) + 1);
	
	//debug_printf("inserted %s and name %s\n", new_node->name, name);
	
	new_node->background = background;
	new_node->client_endpoint = client_endpoint;
	new_node->dispatcher_frame = dispatcher_frame;
	new_node->next_pr = NULL;

	if (head == NULL) {
		return new_node;
	}

	new_node->next_pr = head;
	return new_node;
}

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

void print_nodes( struct process_node *head) 
{
	struct process_node * node = head;

	while (node != NULL) {
		debug_printf("Node: Name %s Did %zu \n", node->name, node->d_id);
		node = node->next_pr;
	}	

}

void clear_process_node(struct process_node *node, struct mm mm_ram) 
{
	errval_t err;

	struct frame_node* head_frame = node->consumed_frame;
	struct frame_node* temp;

	debug_printf("Clearing up for client that requested total memory %d\n", node->memory_consumed);
	// First free ALL allocated frames and also 
	// free regions in mm_ram allocator
	while (head_frame != NULL) {
		
		struct frame_identity fid;
		err = cap_revoke(head_frame->frame);
		if (err_is_fail(err)) {
			debug_printf("Can not revoke frame of mm_ram allcoator!\n");
		}
		
		struct capref current_frame;
		err = slot_alloc(&current_frame);
		if (err_is_fail(err)) {
			debug_printf("Can not allocate frame for bookkeeping!\n");
			cap_destroy(head_frame->frame);
			continue;
		}

		err = cap_retype(current_frame, head_frame->frame, ObjType_Frame, head_frame->bits);
    	if (err_is_fail(err)) {
			debug_printf("error in cap_retype!\n");
			cap_destroy(head_frame->frame);
			cap_destroy(current_frame);
			continue;	
		}
		err = invoke_frame_identify( current_frame, &fid);
		if (err_is_fail(err)) {
			debug_printf("Can not identify frame of domain!\n");
			cap_destroy(head_frame->frame);
			cap_destroy(current_frame);
			continue;
		}
		else {
			err = mm_free(&mm_ram, head_frame->frame, fid.base, fid.bits);
			if (err_is_fail(err)) {
				debug_printf("Can not free frame in mm_ram allocator!\n");	
			}	

			cap_destroy(current_frame);
			// cap_destroy(head_frame->frame);
		}
	
		temp = head_frame;
		head_frame = head_frame->next_frame;		
		free(temp);
	}

	// Then free everything else in the node	
	free(node->name);

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

void update_fd_list (struct process_node *node, int fd, int poss, char * name) 
{

	struct file_descriptor_node* new_fd = ( struct file_descriptor_node *) malloc(sizeof(struct file_descriptor_node));

	new_fd->file_name = malloc(sizeof(name));
	strncpy(new_fd->file_name, name, 20);

	new_fd->fd = fd;
	new_fd->possition_in_file = poss;
	new_fd->next_file_descriptor = node->fd_node;

	node->fd_node = new_fd;

	return;
}

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


void update_frame_list(struct process_node *node, struct capref ram, size_t bits) 
{	
	struct frame_node* new_frame_node = (struct frame_node *) malloc(sizeof(struct frame_node));
	new_frame_node->bits = bits;
	new_frame_node->frame = ram;
	new_frame_node->next_frame = node->consumed_frame;
	
	node->consumed_frame = new_frame_node;
	
	return;
}

errval_t bootstrap_domain(const char *name, struct spawninfo *domain_si, struct bootinfo* bi, coreid_t my_core_id, struct capref* dispatcher_frame, domainid_t did)
{

	errval_t err;
	char prefix[100] = "armv7/sbin/";	
	
	char * module_name = strcat(prefix, name);

	//debug_printf("Before spawn! %s\n", module_name);
	err = spawn_load_with_bootinfo(domain_si, bi, module_name, my_core_id, did);
	if (err_is_fail(err)) {
		debug_printf("spawn_load_with_bootinfo: ERROR in loading module %s!\n", name);
		return SPAWN_ERR_LOAD;
	}

	//debug_printf("Before run!\n");
	err = spawn_run(domain_si);
	if (err_is_fail(err)) {
		debug_printf("spawn_load_with_bootinfo: ERROR in running module %s!\n", name);
		return SPAWN_ERR_RUN;
	}
	
	spawn_free(domain_si);
	*dispatcher_frame = domain_si->dispframe;	

	return SYS_ERR_OK;
}
