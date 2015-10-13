#include<barrelfish/red_black_tree.h>
#include<stdio.h>
#include<ctype.h>
#include<stdint.h>

void VirtaddrDest(void* a);
int VirtaddrComp(const void* a,const void* b);
void VirtaddrPrint(const void*);
void VirtaddrInfo(const void*);

int is_virtual_address_mapped(rb_red_blk_tree*, lvaddr_t);

lvaddr_t allocate_memory(rb_red_blk_tree*, size_t);

rb_red_blk_node* find_node (rb_red_blk_tree* tree, rb_red_blk_node* x, size_t bytes, rb_red_blk_node* guard);

