<?php

	class Message
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public $message;
        public $errorCode;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		
		public function __construct($message,$errorCode = null)
		{
			$this->message   = $message;
			$this->errorCode = $errorCode;
		}
	}
?>