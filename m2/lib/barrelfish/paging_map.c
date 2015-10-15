#include"red_black_tree.h"
#include<stdio.h>
#include<ctype.h>
#include<stdint.h>


void VirtaddrDest(void* a) {
  free((int*)a);
}

int VirtaddrComp(const void* a,const void* b) {
  if( *(lvaddr_t*)a > *(lvaddr_t*)b) return(1);
  if( *(lvaddr_t*)a < *(lvaddr_t*)b) return(-1);
  return(0);
}

void VirtaddrPrint(const void* a) {
  printf("VirtAddr= %p",*(lvaddr_t*)a);
}

void VirtaddrInfo(const void* a) {
  
  memory_chunk* chunk = (memory_chunk*) a;
  printf("Size = %zu . Reserved = %d\n",chunk->size,chunk->reserved);
}

int is_virtual_address_mapped(rb_red_blk_tree* tree, lvaddr_t q) {

    rb_red_blk_node* is_in_memory_chunk = RBExactQuery(tree, &q);
    
    return (( (memory_chunk*)is_in_memory_chunk->info)->reserved);
}

rb_red_blk_node* find_node (rb_red_blk_tree* tree, rb_red_blk_node* x, size_t bytes, rb_red_blk_node* guard) 
{
	rb_red_blk_node* nil=tree->nil;
	rb_red_blk_node* root=tree->root;
    memory_chunk *chunk;
    rb_red_blk_node* init_guard = guard;

    if (x != tree->nil) {
			init_guard = find_node(tree, x->left, bytes, init_guard);
	    	printf("Searching node with start address = %p\n",*((lvaddr_t*)x->key));
			if (init_guard == NULL) { 
				 
				chunk =  ((memory_chunk*) x->info);
				if ( chunk->reserved == 1) 
					init_guard = NULL;
				else {
					if (chunk->size > bytes) {
						printf("----- Memory area can fit into memory chunk that starts at %p\n", *((lvaddr_t*)x->key));
   						init_guard = x;
   					}
					else 
						init_guard = NULL;
			}		
		}
		init_guard = find_node(tree, x->right, bytes, init_guard);
		return init_guard;
   }
   return init_guard;

}

lvaddr_t allocate_memory(rb_red_blk_tree* tree, size_t bytes) {

	memory_chunk *chunk, *new_chunk_1, *new_chunk_2;
	lvaddr_t *addr1, *addr2;

	
	rb_red_blk_node* node = find_node(tree, tree->root->left, bytes, NULL);	
	
	if (node == NULL) 
		return -1;

	printf("Found node that fits our allocation that starts at = %p\n",*((lvaddr_t*)node->key));
	chunk = (memory_chunk*) node->info;

	size_t size1 = bytes;
	size_t size2 = chunk->size - bytes;				
	addr1 = (lvaddr_t*) malloc(sizeof(lvaddr_t));  
	addr2 = (lvaddr_t*) malloc(sizeof(lvaddr_t));  
	
	*addr1 = *((lvaddr_t*) node->key);
	*addr2 = *addr1 + bytes;

	new_chunk_1 = (memory_chunk*) malloc(sizeof(memory_chunk));			
	new_chunk_2 = (memory_chunk*) malloc(sizeof(memory_chunk));		

	new_chunk_1->size = bytes;
	new_chunk_2->size = size2;
				
	new_chunk_1->reserved = 1;
	new_chunk_2->reserved = 0;

	RBDelete(tree, node);
	RBTreeInsert(tree, addr1, new_chunk_1);
	RBTreeInsert(tree, addr2, new_chunk_2);	

    printf("!! Will return %p\n",*addr1);		
	return *addr1;	
}


