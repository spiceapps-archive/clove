<?php
	
	require_once dirname(__FILE__).'/../exceptions/InputSafetyException.class.php';
	require_once dirname(__FILE__).'/ISafeValueHandler.interface.php';

	class RegexpSafetyHandler implements ISafeValueHandler
	{
	
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public $regexp;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		function __construct($regexp = '')
		{
			$this->regexp = $regexp;
		}	
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function test($value)
		{
			return preg_match($this->regexp,$value);
		}
		
	}
	
?>