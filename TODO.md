- Allocate memory for paging book keeping struct with the use of slab allocator

- Handle better our page faults 

- Maybe fix malloc (?). Flag for using malloc instead of SafeMalloc in our paging structs 

- Lock on paging struct for each thread

- Move omap functionality outside of init.c

- Use dsl mac... for device access

- Move device driver and memory server to other domains with the use of an init server

- Ask if it is safe to perform channel and all other initialization on main 

- Separate exception stack for each thread

- Fix map_page to handle arbitary user frames for consecutive l2 tables

- Use mm functionality for splitting devices

- Fix background processes ?

- Fix exit status and domain id - better process termination
