<?php


	require_once dirname(__FILE__)."/../model/Singleton.class.php";
	require_once dirname(__FILE__)."/LogHandler.class.php";
	
	
	class Logger extends Singleton
	{
	
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private $_logHandlers;
		private $_logs;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function __construct()
		{
			parent::__construct();
			
			
			$this->_logs = array();
			$this->_logHandlers = array();
			
			$this->registerLogHandler(new LogHandler(E_ERROR));
			$this->registerLogHandler(new LogHandler(E_NOTICE));
			$this->registerLogHandler(new LogHandler(E_WARNING));
		}	
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public static function getInstance()
		{
			return Singleton::getInstance('Logger');
		}
		
		
		public static function log($message,$type = E_NOTICE,$caller = null,$metadata = null)
		{
			
			//if the given logger doesn't exist, then don't log the data
			if(!self::getInstance()->hasLogger($type))
				return;
				
				
			
			self::getInstance()->getLogger($type)->log($message,$caller,$metadata);
		}
		
		
		/**
		 */
		
		public static function getLogs($type = E_ALL)
		{
			$logs = array();
			
			foreach(self::getInstance()->getLoggers() as $k => $v)
			{
				if($type & $k)
				{
					$logs = array_merge($logs,$v->logs);
				}
			}
				
			return $logs;
		}
		
		
		/**
		 */
		
		public static function hasLogs($type= E_ALL)
		{
			return count(self::getLogs($type)) > 0;
		}
		
		
		/**
		 */
		
		public static function toString($type= E_ALL)
		{
			$logs = self::getLogs($type);
			
			return implode("\n",$logs);
		}
		
		public static function getLogMessages($type = E_ALL)
		{
			$logs = self::getLogs($type);
			
			
			$lg = array();
			
			foreach($logs as $log)
			{
				$lg[] = $log->message;
			}
			
			return $lg;
		}
		
		/**
		 */
		
		public static function logError(Exception $e,$type = E_ERROR,$caller = null)
		{
			Logger::log($e->getMessage(),$type,$caller,$e);
		}
		
		
		
		
		/**
		 */
		
		public function hasLogger($type)
		{	
			
			
			return array_key_exists($type,$this->_logHandlers);
		}
		
		
		/**
		 */
		
		public function getLogger($type)
		{
			return $this->_logHandlers[$type];
		}
		
		/**
		 */
		
		public function getLoggers()
		{
			return $this->_logHandlers;
		}
		
		
		/**
		 */
		
		public function registerLogHandler(LogHandler $handler)
		{
			
			
			//register the logger
			$this->_logHandlers[$handler->type] = $handler;
			
			
		}
		
	}
	
	
?>