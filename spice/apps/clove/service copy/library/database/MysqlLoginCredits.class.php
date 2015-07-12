<?php


	class MysqlLoginCredits
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        public $server;
        public $user;
        public $pass;
        public $database;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function __construct($server,$user,$pass,$database = null)
		{
			$this->server   = $server;
			$this->user     = $user;
			$this->pass     = $pass;
			$this->database = $database;
		}
		
	}

?>