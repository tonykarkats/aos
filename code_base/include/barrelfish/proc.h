#include <barrelfish/barrelfish.h>
#include <spawndomain/spawndomain.h>
#include <string.h>


struct process_node {
	domainid_t d_id;
	char * name;

	bool background;
	struct capref client_endpoint;
	struct capref dispatcher_frame;

	struct process_node * next_pr;
};


void print_nodes( struct process_node *head);
domainid_t get_did_by_name(struct process_node * head, const char * name);
errval_t bootstrap_domain(const char *name, struct spawninfo *domain_si, struct bootinfo * bi, coreid_t coreid, struct capref* dispatcher_frame, domainid_t did);
char * get_name_by_did(struct process_node * head, domainid_t did);
struct process_node * delete_process_node(struct process_node ** head, domainid_t did, char * name);
struct process_node* insert_process_node(struct process_node * head, domainid_t did, char * name, bool background, struct capref client_endpoint, struct capref dispatcher_frame);
