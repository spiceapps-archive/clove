<?php
	
	//http://localhost/work/clove3/spice/driver/amfGateway.php?app=bugTrack
	
	require_once(dirname(__FILE__)."/AccountService.php");
	
	require_once CORE_SERVICES_DIR.'/UserService.php';
	

	class BugTrackingUserService extends UserService
	{
	
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		function __construct()
		{
			parent::__construct("`users`");
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function register($company,$user,$email,$password)
		{
			$accountService = new AccountService();
			
			
			if(!$accountService->getCompanyById($company))
			{
				throw new Exception("The company id ".$company." is not registered in our database.");
			}
			
			
			$execQuery = "INSERT INTO `users` (`company`,`user`,`email`,`password`) VALUES(:company,:user,:email,:pass)";
		
			return $this->executeRegisterQuery($execQuery,array("company"=>$company,"user"=>$user,"email"=>$email,"pass"=>$password));
			
			
		}
		
		/**
		 */
		
		public function login($user,$pass)
		{
			return parent::loginUser("`company`,`id`,`user`,`email`,`privileges`",$user,$pass);
		}
		
		/**
		 */
		
		public function verifySession($permissions = 0)
		{
			$info = parent::verifySession();
			
			if($info["privileges"] < $permissions)
			{
				throw new Exception("Not enough privileges.");
			}
			
			
			return $info;
			
		}
		
		
		/**
		 */
		
		public function getUserCompany()
		{
			$info = $this->loggedInUser();
			
			return $info["company"];
		}
		
		
		/**
		 */
		
		public function getUserCompanyInfo($userId)
		{
			$query = "SELECT * FROM `accounts` WHERE `id` = (SELECT `company` FROM `users` WHERE `id` = :0) LIMIT 1";
			
			
			$result = $this->getResult($query,array($userId))->toAssocArray();
			
			return $result[0];
		}
		
		
	}
	
	

?>