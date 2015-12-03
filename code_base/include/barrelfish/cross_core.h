#include <barrelfish/barrelfish.h>
#include <barrelfish_kpi/types.h>
#include <barrelfish_kpi/init.h>
#include <string.h>

enum type {
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

 	uint32_t words[9];
	uint32_t util_word;
};


void write_to_core_0(struct ump_message mess);
void write_to_core_1(struct ump_message mess);
struct ump_message read_from_core_0(void);
struct ump_message read_from_core_1(void);

int get_core_id(struct bootinfo * bi);
void poll_for_core(void);
void signal_core_0(void);
errval_t map_shared_frame(void **buf, bool init_frame);
