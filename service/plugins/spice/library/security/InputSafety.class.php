<?php
	require_once dirname(__FILE__).'/RegexpSafetyHandler.class.php';
	
	
	class InputSafety
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private $_regexps;
		private static $_instance;
		private static $_errors;
		
		const ON_PROBLEM = "onProblem";
		const ON_DUMP    = "onDump";
		public static $mode = self::ON_PROBLEM;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		function __construct()
		{
		
			self::$_errors = array();
			
			self::$mode =  self::ON_PROBLEM;
		
			//initial string handlers
			
			//long
			$h = $this->registerInputHandler('email','/^[\w\.]+@\w+(\.\w+)+$/');
			
			//short--- don't create loitering objects, re-register.
			$this->registerInputHandler('e',$h);
			
			$h = $this->registerInputHandler('string','/^\w+$/');
			$this->registerInputHandler('s',$h);
			
			
			$h = $this->registerInputHandler('integer','/^-*\d+$/');
			$this->registerInputHandler('i',$h);
			
			$h = $this->registerInputHandler('number','/^[\d.-]+$/');
			$this->registerInputHandler('n',$h);
			
			/*$h = $this->registerInputHandler('fullName','/^[\w\s]+$/');
			$this->registerInputHandler('fn',$h);*/
			
			$h = $this->registerInputHandler('mysqlSafeChars','/^[^;\'\"]+$/');
			$this->registerInputHandler('sc',$h);
			
			//
			$h = $this->registerInputHandler('anything','/.*/');
			$this->registerInputHandler('*',$h);
			
			
		}
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        public static function hasErrors()
        {
        	return count(self::$_errors) > 0;
        }
        
        public static function errorsToStr($delim = ",")
        {
        	
        	return implode($delim,self::dumpErrors());
        }
        public static function setMode($mode)
        {
        	self::getInstance();
        	
        	self::$mode = $mode;
        }
		
		public static function getInstance()
		{
			if(!self::$_instance)
			{
				self::$_instance = new InputSafety();
			}
			
			return self::$_instance;
			
			
		}
		/**
		 */
		
		public function __cleanse($value,$handler = null,$errorMessage = null)
		{
			$new_value = mysql_escape_string($value);
			
			
			if($handler == null)
			{
				return $new_value;
			}
			else
			if($handler instanceof ISafeValueHandler)
			{
			
				if($handler->test($value))
					return $new_value;
			}
			else	
			if($this->test($handler,$value))
			{
			
				return $new_value;
			}
			
			$message = $errorMessage ? $errorMessage : "\"$value\" has a few invalid characters.";
			
			
			if(self::$mode == self::ON_PROBLEM)
			{
				throw new InputSafetyException($message); 
			}
			else
			if(self::$mode == self::ON_DUMP)
			{
				self::$_errors[] = $message;
			}
			
		}
		
		/**
		 */
		
		
		public static function cleanse($value,$handler = null,$errorMessage = null)
		{
			return self::getInstance()->__cleanse($value,$handler,$errorMessage);
		}
		
		/**
	     */
	    
	    public static function dumpErrors()
	    {
	    	$errors = self::$_errors;
	    	self::$_errors = array();
	    	return $errors;
	    }
	    
	    /**
	     */
	     
	    public static function getErrors()
	    {
	    	return self::$_errors;
	    }
		/**
		 */
		
		public function registerInputHandler($name,$handler)
		{
		
			//if the handler is a savevaluehandler then register that, otherwise register as a regexp handler
			$h = ($handler instanceof ISafeValueHandler) ? $handler : new RegexpSafetyHandler($handler);
			
			$this->_regexps[$name] = $h;
			
			return $h;
		}
		
		/**
		 */
		
		public function test($name,$value)
		{
			if(array_key_exists($name, $this->_regexps))
			{
				$handler = $this->_regexps[$name];
				
				return $handler->test($value);
			}
			
			
			throw new InputSafetyException($name.' is not a registered input handler.');
			
			
			
		}
		
		
		
	}




	
?>