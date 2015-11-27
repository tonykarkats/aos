#include "proc.h"

struct process_node * delete_process_node(struct process_node ** head, domainid_t did, char * name) 
{
	struct process_node * active = *head;
	struct process_node * previous = *head;
	
	if (*head == NULL)
		return NULL;
	
	while (((active->d_id != did)||(strcmp(name, active->name)))&&(active->next_pr != NULL)) {
		previous = active;
		active = active->next_pr;
	}

	if (((active->d_id == did)||(!strcmp(name, active->name)))&&(active == *head)) {
		*head = NULL;		
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
	
//	debug_printf("inserted %s and name %s\n", new_node->name, name);
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

errval_t bootstrap_domain(const char *name, struct spawninfo *domain_si, struct bootinfo* bi, coreid_t my_core_id, struct capref* dispatcher_frame)
{

	errval_t err;
	char prefix[100] = "armv7/sbin/";	
	
	char * module_name = strcat(prefix, name);

	err = spawn_load_with_bootinfo(domain_si, bi, module_name, my_core_id);
	if (err_is_fail(err)) {
		debug_printf("spawn_load_with_bootinfo: ERROR!\n");
		return SPAWN_ERR_LOAD;
	}

	err = spawn_run(domain_si);
	if (err_is_fail(err)) {
		debug_printf("spawn_load_with_bootinfo: ERROR!\n");
		return SPAWN_ERR_RUN;
	}
	
	spawn_free(domain_si);
	*dispatcher_frame = domain_si->dispframe;	

	return SYS_ERR_OK;
}
