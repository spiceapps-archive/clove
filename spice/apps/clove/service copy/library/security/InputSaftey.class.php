<?php

	class InputSaftey
	{
	
		//--------------------------------------------------------------------------
   	    //
        //  Public Constants
        //
        //--------------------------------------------------------------------------
        
        public static $EMAIL  			= '/^\w+@\w+(\.\w+)+$/';
        public static $STRING 			= '/^\w+$/';
		public static $MYSQL_SAFE_CHARS = '/^[\w\s]+$/';
		public static $INTEGER			= '/^-*\d+$/';
		public static $NUMBER			= '/^[\d.-]+$/';
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		/**
		 */
		
		public static function cleanse($value,$regex = null)
		{
			$new_value = mysql_escape_string($value);
			
			if($regex == null)
				return $new_value;
				
			if(preg_match($regex,$value))
				return $new_value;
		}
		

		
	}

	
?>