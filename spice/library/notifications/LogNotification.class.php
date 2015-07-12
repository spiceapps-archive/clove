<?php
	require_once dirname(__FILE__)."/Notification.class.php";
	require_once dirname(__FILE__)."/../log/Log.class.php";
	
	
	class LogNotification extends Notification
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Constants
        //
        //--------------------------------------------------------------------------
        
        const NEW_LOG    = "newLog";
        
        public $log;
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function __construct($type,Log $log)
		{
			parent::__construct($type);
			
			$this->log = $log;
			
		}
	}


?>