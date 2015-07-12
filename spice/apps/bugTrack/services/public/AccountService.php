<?php

	//http://localhost/work/clove3/spice/driver/amfGateway.php?app=bugTrack
	
	require_once(dirname(__FILE__)."/../includes/headers.inc.php");
	
	
	require_once CORE_SERVICES_DIR.'/Service.php';
	
	class AccountService extends Service
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private $_userService;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		function __construct()
		{
			parent::__construct();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        

        /**
		 */
		
		public function registerAccount($company,$plan = 0)
		{
		
			if($this->getCompanyByName($company))
			{
				throw new Exception("The company ".$company." already exists");
			}
			
			$query = "INSERT INTO `accounts` (`company`,`plan`) VALUES(:0,:1)";
	
			$this->executeQuery($query,array($company,$plan));
			
			return true;
		}
		
		/**
		 */
		
		public function getCompanyById($id)
		{
			$query = "SELECT * FROM `accounts` WHERE `id` = :0 LIMIT 1";
	
			$result = $this->getResult($query,array($id))->toAssocArray();
			
			return count($result) > 0 ? $result[0] : 0;
		}
		
		/**
		 */
		
		public function getCompanyByName($company)
		{
			$query = "SELECT * FROM `accounts` WHERE `company` = :0 LIMIT 1";
			
			$result = $this->getResult($query,array($company))->toAssocArray();
			
			return count($result) > 0 ? $result[0] : 0;
		}
		
	}
	
	
?>