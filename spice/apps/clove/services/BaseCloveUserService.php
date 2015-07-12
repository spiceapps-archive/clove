<?php
	
	//http://localhost/work/clove3/spice/driver/amfGateway.php?app=bugTrack
	
	require_once(dirname(__FILE__)."/../includes/headers.inc.php");
	
	require_once CORE_SERVICES_DIR.'/UserService.php';
	

	class BaseCloveUserService extends UserService
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
			parent::__construct("`users`","email","password");
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        		
		/**
		 */
		
		public function login($user,$pass,$usemd5 = true)
		{
		
			return parent::loginUser("`id`,`email`,`permissions`,`activation_code`,`invite_code`,`activated`",$user,$pass,$usemd5);
		}
		
		/**
		 */
		
		
		protected function checkLoggedInUser($info)
		{
			parent::checkLoggedInUser($info);
			
			
			if($info["invite_code"] == 0)
			{
				throw new Exception("Your account has not been invited for beta yet.");
			}
			
			if(!$info["activated"])
			{
				throw new Exception("Your account has not been activated yet.");
			}
		}
		
		
		/**
		 */
		
		public function userName()
		{
			$info = $this->loggedInUser();
			
			return $info ? $info["email"] : null; 
		}
		
		/**
	     */
	    
	    public function invited()
	    {
	    	$info = $this->loggedInUser();
	    	
	    	return $info ? $info["invite_code"] > 0 : false;
	    }
		
		public function userId()
		{
			$info = $this->loggedInUser();
			
			return $info ? $info["id"] : null; 
		}
		
		/**
		 */
		
		public function userPermissions()
		{
			$info = $this->loggedInUser();
			
			return $info ? $info["permissions"] : null;
		}
		
		/**
		 */
		
		
		public function verifySession($permissions = 0)
		{
			parent::verifySession();
			
			if($this->userPermissions() < $permissions)
			{
				throw new Exception("Not enough permissions");
			}
		}
		
		
	}
	
	

?>