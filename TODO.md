- Handle better our page faults 

- Fix SafeMalloc usage somehow. Idea: Use heap struct provided by barrelfish core with a start buffer and then when full allocate from standar malloc().

- Lock on paging struct for each thread - FIXED

- Separate exception stack for each thread

- Fix map_page to handle arbitary user frames for consecutive l2 tables FIXED

- Use mm functionality for splitting devices VERY IMPORTANT FOR FILESYSTEM MILESTONE FIXED

- Fix background processes

- No acknowledgment in string rpc ! FIXED

- Fix exit status and domain id - better process termination **** FIXED.

- Fix weird bug with send string acknowledgemnt back to client - FIXED with no acnolwdgement in string rpc! FIXED - no acknowledgment sent in rpc send string.

- Fix 1-1 mapping for aux core registers, use paging_alloc for them OR find another mapping FIXED - mapped the registers at each vspace and used those values

- Fix weird bug in process list with name of processes FIXED

- Add lock to initapp for process list management FIXED

- Fix background processes , does not work with oncore figure out why.

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

- Fix printf to handle string printing in chunks of 4096 bytes.
