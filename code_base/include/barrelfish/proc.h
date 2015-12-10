#include <barrelfish/barrelfish.h>
#include <mm/mm.h>
#include <spawndomain/spawndomain.h>
#include <string.h>
#include <barrelfish/mem_serv.h>
#define CLIENT_MEMORY_LIMIT 50*1024*1024

// Process node. It keeps all information regarding
// memory consumed by a process, the shared frame between the 
// domain and the init server etc...
struct frame_node {
	struct capref frame;
	size_t bits;
	genpaddr_t base;
	struct frame_node * next_frame;
};

struct file_descriptor_node {
	int fd;
	int possition_in_file;
	char *file_name;
	
	struct file_descriptor_node * next_file_descriptor;
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

	// Open file descriptors used by that process
	struct file_descriptor_node *fd_node;	
	
	// Next process node 
	struct process_node * next_pr;
};

bool delete_fd(struct process_node *node, int fd);
void update_fd_list (struct process_node *node, int fd, int poss, char *name);
void clear_process_node(struct process_node *node);
void update_frame_list(struct process_node *node, struct capref ram, size_t bits, genpaddr_t base);
char* check_if_fd_exists(struct file_descriptor_node *node, int fd);
errval_t locate_and_map_shared_frame( struct process_node *node, struct capref * ret, void **buf);

struct process_node * get_process_node(struct process_node ** head, domainid_t did, char * name);
void print_nodes( struct process_node *head);
domainid_t get_did_by_name(struct process_node * head, const char * name);
errval_t bootstrap_domain(const char *name, struct spawninfo *domain_si, struct bootinfo * bi, coreid_t coreid, struct capref* dispatcher_frame, domainid_t did);
char * get_name_by_did(struct process_node * head, domainid_t did);
struct process_node * delete_process_node(struct process_node ** head, domainid_t did, char * name);
struct process_node* insert_process_node(struct process_node * head, domainid_t did, char * name, bool background, struct capref client_endpoint, struct capref dispatcher_frame);
