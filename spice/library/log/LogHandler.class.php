<?php
	
	
	require_once dirname(__FILE__)."/Log.class.php";
	require_once dirname(__FILE__)."/../observer/Notifier.class.php";
	require_once dirname(__FILE__)."/../notifications/LogNotification.class.php";

	class LogHandler extends Notifier
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		public $type;
		public $logs;
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function LogHandler($type)
		{
			$this->type = $type;
			$this->logs = array();
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function log($message,$caller,$metadata = null)
		{
		
		
			$log = new Log($this->type,$message,$caller,$metadata);
			
			
			$this->logs[] = $log;
			
			$this->notifyObservers(new LogNotification(LogNotification::NEW_LOG,$log));
		}
	}

?>