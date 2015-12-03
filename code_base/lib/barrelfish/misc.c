#include <barrelfish/misc.h>
#include <barrelfish/debug.h>
#include <stdlib.h>

/***********************************************************************/
/*  FUNCTION:  void Assert(int assertion, char* error)  */
/**/
/*  INPUTS: assertion should be a predicated that the programmer */
/*  assumes to be true.  If this assumption is not true the message */
/*  error is printed and the program exits. */
/**/
/*  OUTPUT: None. */
/**/
/*  Modifies input:  none */
/**/
/*  Note:  If DEBUG_ASSERT is not defined then assertions should not */
/*         be in use as they will slow down the code.  Therefore the */
/*         compiler will complain if an assertion is used when */
/*         DEBUG_ASSERT is undefined. */
/***********************************************************************/


void Assert(int assertion, char* error) {
  if(!assertion) {
    debug_printf("Assertion Failed: %s\n",error);
    exit(-1);
  }
}



/***********************************************************************/
/*  FUNCTION:  SafeMalloc */
/**/
/*    INPUTS:  size is the size to malloc */
/**/
/*    OUTPUT:  returns pointer to allocated memory if succesful */
/**/
/*    EFFECT:  mallocs new memory.  If malloc fails, prints error message */
/*             and terminates program. */
/**/
/*    Modifies Input: none */
/**/
/***********************************************************************/

/*
void * SafeMalloc(size_t size) {
  void * result;

  if ( (result = malloc(size)) ) {
    return(result);
  } else {
    printf("memory overflow: malloc failed in SafeMalloc.");
    printf("  Exiting Program.\n");
    exit(-1);
    return(0);
  }
}
*/


/*  NullFunction does nothing it is included so that it can be passed */
/*  as a function to RBTreeCreate when no other suitable function has */
/*  been defined */
bool use_system_wide_malloc = false;

#define BUFFER_SIZE 10UL*1024*1024
static char memory_buffer[BUFFER_SIZE];
static int pointer = 0;

void * SafeMalloc(size_t size) {

	if (!use_system_wide_malloc) {
		if ((pointer + size)>BUFFER_SIZE) {
			debug_printf("OUT OF STATIC MEMORY!");
			abort();
		}
		char* return_address = memory_buffer+pointer;
    
    	pointer += size;
		return (void *) return_address;  
    }
	else {
		debug_printf("Using real malloc!\n");
		char* return_address = malloc(size);	
		debug_printf("Used real malloc!\n");
		return (void *) return_address;
	}	

}

void set_real_malloc(void) 
{
	use_system_wide_malloc = true;
}

void SafeFree(void* addr) {
}

void NullFunction(void * junk) { ; }
