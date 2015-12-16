#include <barrelfish/barrelfish.h>
#include <mm/mm.h>
#include <spawndomain/spawndomain.h>
#include <string.h>

#define CLIENT_MEMORY_LIMIT 50*1024*1024

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

/**
 * \brief This struct describes a node on the process list maintained by the 
 *        process manager.
 */
struct process_node {

	domainid_t d_id;                      // <- The domain id of the process.
	char * name;       		      // <- The name of the process.
	bool background;   		      // <- Whether the process runs on the background.
	struct capref client_endpoint;        // <- Endpoint of the client that requested the process.
	struct capref dispatcher_frame;       // <- Unused.
	char * buffer;                        // <- Shared buffer used for communication between init and spawned process.
	struct capref shared_frame;           // <- Shared frame for the communication.
	uint32_t memory_consumed;             // <- Amount of memory already consumed by the process
	struct frame_node *consumed_frame;    // <- List of frames used by the process
	struct file_descriptor_node *fd_node; // <- List of open files for this process.
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

errval_t bootstrap_domain(const char *name, struct spawninfo *domain_si, struct bootinfo * bi,
                          coreid_t coreid, struct capref* dispatcher_frame, domainid_t did,
                          char * elf_vaddr, uint32_t elf_size);

char * get_name_by_did(struct process_node * head, domainid_t did);

struct process_node * delete_process_node(struct process_node ** head, domainid_t did, char * name);

struct process_node* insert_process_node(struct process_node * head, domainid_t did, char * name,
                                         bool background, struct capref client_endpoint,
                                         struct capref dispatcher_frame);
