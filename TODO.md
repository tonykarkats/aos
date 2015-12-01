- Allocate memory for paging book keeping struct with the use of slab allocator - how ?

- Handle better our page faults 

- Maybe fix malloc (?). Flag for using malloc instead of SafeMalloc in our paging structs 

- Lock on paging struct for each thread - FIXED

- Move omap functionality outside of init.c

- Use dsl mac... for device access

- Move device driver and memory server to other domains with the use of an init server

- Ask if it is safe to perform channel and all other initialization on main 

- Separate exception stack for each thread

- Fix map_page to handle arbitary user frames for consecutive l2 tables FIXED

- Use mm functionality for splitting devices VERY IMPORTANT FOR FILESYSTEM MILESTONE ****

- Fix background processes ? FIXED

- No acknowledgment in string rpc !

- Fix exit status and domain id - better process termination **** FIXED.

- Fix weird bug with send string acknowledgemnt back to client - FIXED with no acnolwdgement in string rpc!

- Fix 1-1 mapping for aux core registers, use paging_alloc for them OR find another mapping!

- Fix weird bug in process list with name of processes!

- Add lock to initapp for process list management!
