- Handle better our page faults 

- Fix SafeMalloc usage somehow. Idea: Use heap struct provided by barrelfish core with a start buffer and then when full allocate from standar malloc().

- Lock on paging struct for each thread - FIXED
- Enable functionality for spawning processes from processes in init1. FIXED, domains at init-1 can only spawn at core-1 processes 

- We should really mm_free the frames for each spawned process 				****** infrastrucure is up need to ask the tas or someone about that.

- Put limit at client requested memory 						   				****** FIXED.

- Fix input for processes that are spawned at forground

- Enable functionality for domains in core-1 to spawn domains at core-0

- Check if it is needed to allocate again slot for incoming capabilty in server side and in client side.

- How to discern between different clients talking to us. Renlord suggested to use the channel. FIXED by sending domain id across with the rpc call.

- Maybe put init channel initialization before all other initializations on barrelfish_init_on_thread ?

- Fix proper erros in barrelfish/init.c for shared frame

- Fix rpc calls so that they malloc each time the requested memory in each call. Freeing is the users responsiblity.

- Everything that gets fixed in core-0 should get fixed also in core-1.

- Fix bug in initapp when processes from initapp spawning processes on initapp fail at process # = 18.

- Fix bug where both /hello and hello work as files
