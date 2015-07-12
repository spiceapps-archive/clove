#define DEBUG_MODE
#define IS_AIR


#ifdef DEBUG_MODE
	#define TRACE(m) trace(m);
#else
	#define TRACE(m)
#endif

