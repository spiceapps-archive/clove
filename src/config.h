//#define DEBUG_MODE

//platform specific
#define AIR_PLATFORM 1
#define WEB_PLATFORM 2
#define MOBILE_PLATFORM 3

#define PLATFORM AIR_PLATFORM

//REGEXP
#define __REGEXP_URL "((?<=^|\\s)((ht|f)tp(s?)://)?(\\w+:\\w+@)?([-\\w]+\\.)+(com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum|travel|[a-z]{2})((?=([^\\w]|$)))(:\\d+)?.*?)(?=[,:!?.]*(\\s|$))"

//DEBUGGING MACROS

#define __LOG_ERROR(t_err) Logger.logError(t_err);

#define __LOG(sss,type) Logger.log(sss,this,type);
#define __NOTICE(x) __LOG(x,1)
#define __WARNING(m) __LOG(m,2)
#define __ERROR(m) __LOG(m,3)
#define __FATAL(m) __LOG(m,4)


#define __FATAL_M(m,target) Logger.log(m,target,4)

#ifdef DEBUG_MODE
	#define __TRACE(m) __LOG(m,0)
	#define __MEMORY(m) __LOG(m,5)
#else
	#define __TRACE(m)
	#define __MEMORY(m)
#endif


//HELPERS

#define __SET_EV_TARGET_WR(_var,_value,_ev,_func) \*

if(_var)
	_var.removeEventListener(_ev,_func);

_var = _value;

_var.addEventListener(_ev,_func,false,0,true);
#endef




