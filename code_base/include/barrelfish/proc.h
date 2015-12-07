#include <barrelfish/barrelfish.h>
#include <mm/mm.h>
#include <spawndomain/spawndomain.h>
#include <string.h>

#define CLIENT_MEMORY_LIMIT 50*1024*1024

// Process node. It keeps all information regarding
// memory consumed by a process, the shared frame between the 
// domain and the init server etc...
struct frame_node {
	struct capref frame;
	size_t bits;
	struct frame_node * next_frame;
};
	
struct process_node {
	domainid_t d_id;
	char * name;

	bool background;
	struct capref client_endpoint;
	struct capref dispatcher_frame;

	// Shared memory between init process and spawned process
	char * buffer;
	struct capref shared_frame;

	// Memory frames used by this domain
	uint32_t memory_consumed; 	
	struct frame_node *consumed_frame;
	
	// Next process node 
	struct process_node * next_pr;
};

void clear_process_node(struct process_node *node, struct mm mm_ram);
void update_frame_list(struct process_node *node, struct capref ram, size_t bits);

struct process_node * get_process_node(struct process_node ** head, domainid_t did, char * name);
void print_nodes( struct process_node *head);
domainid_t get_did_by_name(struct process_node * head, const char * name);
errval_t bootstrap_domain(const char *name, struct spawninfo *domain_si, struct bootinfo * bi, coreid_t coreid, struct capref* dispatcher_frame, domainid_t did);
char * get_name_by_did(struct process_node * head, domainid_t did);
struct process_node * delete_process_node(struct process_node ** head, domainid_t did, char * name);
struct process_node* insert_process_node(struct process_node * head, domainid_t did, char * name, bool background, struct capref client_endpoint, struct capref dispatcher_frame);
