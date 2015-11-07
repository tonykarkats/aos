#ifdef DMALLOC
#include <dmalloc.h>
#endif
#include<stdint.h>
#include<barrelfish/stack.h>
#include<barrelfish/caddr.h>
#ifndef HAVE_BARELLFISH_RED_BLACK 
#define HAVE_BARELLFISH_RED_BLACK
#endif

#include <stdbool.h>
typedef uintptr_t lvaddr_t;

/* comment out the line below to remove all the debugging assertion */
/* checks from the compiled code.  */
#define DEBUG_ASSERT 1

/*  This is the chunk that the info pointer of the tree points to.
 *  It holds information about the memory chunks that are allocated.
 *  size        : the size of the chunk
 *  reserved    : set when the memory is reserved
 *  frame cap   : the physical frame capability corresponding to the chunk
 *  l2_mapped   : boolean array that shows which l2 pages have been mapped
 *  l2_table_cap: the capabilities for the l2 pages
*/
  

typedef struct memory_chunk {
	size_t size;
	int reserved;

    int current_frame_used;
    int total_frames_needed;
    int size_of_last_frame;
	size_t frame_offset;
	
    struct capref* frame_caps_for_region;

} memory_chunk;

/* Our paging state struct is a Red-Black tree whose nodes represent the
 * memory chunks allocated fot the demand paging. The key for each node is the 
 * virtual address of the start of the chunk and the 'info' field is a pointer
 * to a memory_chunk struct described above. The rest are needed for the actual
 * implementation of the red-black tree.
 * Note: Our implementation is based on the following implementation from
 * Emin Martinian at MIT
 * URL : http://web.mit.edu/~emin/Desktop/ref_to_emin/www.old/source_code/red_black_tree/index.html
*/


typedef struct rb_red_blk_node {
  void* key;
  void* info;
  int red; /* if red=0 then the node is black */
  struct rb_red_blk_node* left;
  struct rb_red_blk_node* right;
  struct rb_red_blk_node* parent;

} rb_red_blk_node;


/* Compare(a,b) should return 1 if *a > *b, -1 if *a < *b, and 0 otherwise */
/* Destroy(a) takes a pointer to whatever key might be and frees it accordingly */
typedef struct rb_red_blk_tree {
  int (*Compare)(const void* a, const void* b); 
  void (*DestroyKey)(void* a);
  void (*DestroyInfo)(void* a);
  void (*PrintKey)(const void* a);
  void (*PrintInfo)(const void* a);
  /*  A sentinel is used for root and for nil.  These sentinels are */
  /*  created when RBTreeCreate is caled.  root->left should always */
  /*  point to the node which is the root of the tree.  nil points to a */
  /*  node which should always be black but has aribtrary children and */
  /*  parent and no key or info.  The point of using these sentinels is so */
  /*  that the root and nil nodes do not require special cases in the code */
  rb_red_blk_node* root;             
  rb_red_blk_node* nil;              

  struct capref l2_tables[4096];
  bool l2_maps[4096];
} rb_red_blk_tree;

/* The functions below are described in the .c file */ 
rb_red_blk_tree* RBTreeCreate(int  (*CompFunc)(const void*, const void*),
			     void (*DestFunc)(void*), 
			     void (*InfoDestFunc)(void*), 
			     void (*PrintFunc)(const void*),
			     void (*PrintInfo)(const void*));

rb_red_blk_node * RBTreeInsert(rb_red_blk_tree*, void* key, void* info);
void RBTreePrint(rb_red_blk_tree*);
void RBDelete(rb_red_blk_tree* , rb_red_blk_node* );
void RBTreeDestroy(rb_red_blk_tree*);
rb_red_blk_node* TreePredecessor(rb_red_blk_tree*,rb_red_blk_node*);
rb_red_blk_node* TreeSuccessor(rb_red_blk_tree*,rb_red_blk_node*);
rb_red_blk_node* RBExactQuery(rb_red_blk_tree*, void*);
stk_stack * RBEnumerate(rb_red_blk_tree* tree,void* low, void* high);

void VirtaddrDest(void* a);
int VirtaddrComp(const void* a,const void* b);
void VirtaddrInfoDest(void *);
void VirtaddrPrint(const void*);
void VirtaddrInfo(const void*);
void LeftRotate(rb_red_blk_tree* tree, rb_red_blk_node* x);
int is_virtual_address_mapped(rb_red_blk_tree*, lvaddr_t);
void RightRotate(rb_red_blk_tree* tree, rb_red_blk_node* y);

void RBDeleteFixUp(rb_red_blk_tree* tree, rb_red_blk_node* x);
void InorderTreePrint(rb_red_blk_tree* tree, rb_red_blk_node* x);
void TreeInsertHelp(rb_red_blk_tree* tree, rb_red_blk_node* z);
void TreeDestHelper(rb_red_blk_tree* tree, rb_red_blk_node* x);
lvaddr_t allocate_memory(rb_red_blk_tree*, size_t);

rb_red_blk_node* find_memory_chunk (rb_red_blk_tree* tree, rb_red_blk_node* x, size_t bytes, rb_red_blk_node* guard);

