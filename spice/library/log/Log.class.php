<?php

	class Log
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public $type;
        public $caller;
        public $message;
        public $metadata;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function Log($type,$message,$caller,$metadata)
		{
			$this->type 	= $type;
			$this->caller   = $caller;
			$this->message  = $message;
			$this->metadata = $metadata;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		
		function __toString()
		{
			return $this->message;
		}
	}

?>