#include <barrelfish/barrelfish.h>
#include <barrelfish_kpi/types.h>
#include <barrelfish_kpi/init.h>
#include <string.h>

enum type {
	SPAWNED_PROCESS_RESPONSE_PERMISSION_FOR_SPAWN,
	SPAWNED_PROCESS_REQUEST_PERMISSION_FOR_SPAWN,
	SPAWNED_PROCESS_RESPONSE,
	SPAWNED_PROCESS_REQUEST,
	SPAWNED_PROCESS_TERMINATED_RESPONSE,
	SERIAL_PUT_CHAR,
	SERIAL_PUT_STRING,
	SERIAL_GET_CHAR,
};

struct ump_message {
	uint32_t is_request;
	enum type type;
	struct capref client_cap; // Used for answering back to our client that domain is spawned. this is a hack :)
 	uint32_t words[9];
	uint32_t util_word;
};


void write_to_core_0(struct ump_message mess);
void write_to_core_1(struct ump_message mess);
struct ump_message read_from_core_0(void);
struct ump_message read_from_core_1(void);

int get_core_id(struct bootinfo * bi);
void poll_for_core(lvaddr_t cross_core_register);
void signal_core_0(lvaddr_t cross_core_register);
errval_t map_shared_frame(void **buf, bool init_frame);
