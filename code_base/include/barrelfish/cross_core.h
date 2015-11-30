#include <barrelfish/barrelfish.h>
#include <barrelfish_kpi/types.h>
#include <barrelfish_kpi/init.h>

enum request_type {
	
	SPAWN_PROCESS,
	SERIAL_PUT_CHAR,
	SERIAL_PUT_STRING,
};

enum response_type {

	SPAWNED_PROCESS,
};

struct ump_request {
	enum request_type type;
	char ump_chars[36];
};

struct ump_response {
	enum response_type type;
	char ump_chars[36];
};


int get_core_id(struct bootinfo * bi);
void poll_for_core(void);
void signal_core_0(void);
errval_t map_shared_frame(void **buf);
