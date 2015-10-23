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
				
	return *addr1;	
}


int main(int argc, char** argv) {
  stk_stack* enumResult;
  int option=0;
  lvaddr_t* newAddr,newAddr2;
  memory_chunk* newMemory;
  rb_red_blk_node* newNode;
  rb_red_blk_tree* tree;

  tree=RBTreeCreate(VirtaddrComp,VirtaddrDest,VirtaddrDest,VirtaddrPrint,VirtaddrInfo);
  
  newAddr = (lvaddr_t*) malloc(sizeof(lvaddr_t));
  *newAddr = 0;
  newMemory = (memory_chunk *) malloc(sizeof(memory_chunk));
  newMemory->reserved = 0;
  newMemory->size = (1024*1024*1024)*2;
  RBTreeInsert(tree, newAddr ,newMemory);
  /*
  newAddr = (lvaddr_t*) malloc(sizeof(lvaddr_t));
  *newAddr = 1024*1024*1024/4;
  newMemory = (memory_chunk *) malloc(sizeof(memory_chunk));
  newMemory->reserved = 0;
  newMemory->size = 1024*1024*1024/4;
  RBTreeInsert(tree, newAddr ,newMemory);
  
  newAddr = (lvaddr_t*) malloc(sizeof(lvaddr_t));
  *newAddr = 1024*1024*1024/2;
  newMemory = (memory_chunk *) malloc(sizeof(memory_chunk));
  newMemory->reserved = 0;
  newMemory->size = 1024*1024*1024/2;
  RBTreeInsert(tree, newAddr ,newMemory);

  newAddr = (lvaddr_t*) malloc(sizeof(lvaddr_t));
  *newAddr = 1024*1024*1024;
  newMemory = (memory_chunk *) malloc(sizeof(memory_chunk));
  newMemory->reserved = 1;
  newMemory->size = 1024*1024*1024/2;
  RBTreeInsert(tree, newAddr ,newMemory);
  
  newAddr = (lvaddr_t*) malloc(sizeof(lvaddr_t));
  *newAddr = 1024*1024*1024*1.5;
  newMemory = (memory_chunk *) malloc(sizeof(memory_chunk));
  newMemory->reserved = 1;
  newMemory->size = 1024*1024*1024/2;
  RBTreeInsert(tree, newAddr ,newMemory);
  
  RBTreePrint(tree);
  

  printf("\n==============================================\n"); 
  lvaddr_t searchAddress = atoi(argv[1]);
  rb_red_blk_node* node = RBExactQuery(tree, &searchAddress);
  if (node == NULL) 
	printf("Not found\n");
  else {
      newMemory = (memory_chunk*) node->info;
      printf("Address = %p . Size = %zu . Reserved = %d\n", *((lvaddr_t*) node->key), newMemory->size, newMemory->reserved);
  }

	if (is_virtual_address_mapped(tree, searchAddress))
		printf("Address is mapped!\n");
	else 
		printf("Address not mapped\n");

    lvaddr_t vaddr = allocate_memory(tree, atoi(argv[2]));
	if (vaddr == -1)
		printf("Can not allocate\n");
	else {
		printf("Memory allocated at %p\n",vaddr);
	} 

   RBTreePrint(tree);	  
   exit(1); 
  */

  size_t size;
  lvaddr_t addr;
  char str[256];

  while(option!=5) {
    printf("\n\nchoose one of the following:\n");
    printf("(1) Allocate memory\n(2) Check if it is mapped\n(3) Print tree\n(4) Print root of tree\n");

    do option=fgetc(stdin); while(-1 != option && isspace(option));
    option-='0';

    switch(option)
      {
      case 1:
	{
	  printf("Type size of memory in decimal\n");
	  scanf("%zu",&size);
      printf("%zu\n",size);
	 addr = allocate_memory(tree, size);
	 if (addr == -1)
		printf("Can not allocate\n");
	 else {
		printf("Memory allocated at %p\n",addr);
	 } 

	}
	break;
	
      case 2:
	{
	  printf("type address in decimal to check if is mapped\n");
	  scanf("%d",&addr);
	  if (is_virtual_address_mapped(tree, addr))
		printf("Address is mapped!\n");
	  else 
		printf("Address NOT mapped\n");
	}
	break;

      case 3:
	{
	  printf("----------The Tree---------\n");
	  RBTreePrint(tree);
	}
	break;

      case 4:
	{
	  printf("----------Root of tree---------\n");
      rb_red_blk_node* node = (rb_red_blk_node*) tree->root->left;
	  if (node == NULL) 
		printf("node == null\n");
      if (node->key == NULL)
		printf("root key == null\n");

      lvaddr_t* rootAddr = (lvaddr_t*) node->key;
	  
      printf("Virtual address at root of tree = %llu\n", *rootAddr );
	}
	break;


		}
	
	}
  return 0;
 }



