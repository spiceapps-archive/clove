<?php
	
	//http://localhost/work/clove3/spice/driver/amfGateway.php?app=bugTrack
	
	require_once dirname(__FILE__).'/../InviteCodeService.php';
	

	class CloveUserService extends BaseCloveUserService
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private $_inviteService;
		
		
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
			
			$this->_inviteService = new InviteCodeService();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function register($fullName,$email,$password,$inviteCode = 'setThisWithSomeKeyOnceOutOfBeta-The-DB-invites_left-should-be- -1',$registerWithNewsberry = true)
		{
			
			
			$execQuery = "INSERT INTO `users` (`fullName`,`email`,`password`,`activation_code`) VALUES(#sc:fullName,#e:email,#sc:pass,#sc:actCode)";
			
			
			
			//create a random activation key need for email
			$randActivationKey = md5($email.rand()*99999999999999);
			
			//insert the user into the database
			$result = false;
			try
			{
				$result = $this->executeRegisterQuery($execQuery,array("email"=>array($email,"Please enter a valid email address."),
																       "pass"=>array(md5($password),"Please enter a valid password."),
																       "actCode"=>array($randActivationKey,"Please enter a valid activation code."),
																       "fullName"=>array($fullName,"Please enter a valid full name.")));
			
			}catch(Exception $e)
			{
				Logger::logError($e);
				
			}
			
			
			if(!$result)
			{
				return new Message(Logger::toString(),1);
			}
			
	
			
				
			if($registerWithNewsberry)
			{
				$this->registerWithNewsberry($email,$fullName);
			}
			
			
			
			
			
			$useInvite = $this->_inviteService->useInviteCode($inviteCode,$email);
			
			
			
			if(!$useInvite)
			{
				$message = "Thanks for signing up for the Clove beta. Please check your email for your confirmation url. After you have confirmed your account, we will notify you when you have been approved for beta.";
				
				
				
			}
			else
			{
				$message = "Thanks for signing up for the Clove beta. Please check your email for your confirmation url.";
			}
			
			
			
			$this->mailUserActivationCode($email,$randActivationKey);
			
		
			return new Message($message,0);
			
			
		}
		
		/**
		 */
		
		public function activateWithInvite($inviteCode)
		{
		
			$this->verifyLogin();
			
			if(!$this->_inviteService->useInviteCode($inviteCode,$this->userName()))
				throw new Exception("Whoops, looks like you entered an invalid invitation code!");
			
		}
		
		/**
		 */
		
		public function activateWithByEmail($code)
		{
			if(!$this->loginWithActivationCode($code,false))
			{
				return false;
			}
			
			$query = "UPDATE `users` SET `activated` = '1' WHERE `activation_code` = :0";
			
			return $this->executeQuery($query,array($code));
		}
		
		
		/**
		 */
		
		public function resendActivationCode($email,$password)
		{
			$query = "SELECT * FROM `users` WHERE `user` = :0 AND `password` = :1 LIMIT 1";
			
			$result = $this->getResult($query,array($email,$password))->toAssocArray();
			
			if(count($result) == 0)
			{
				throw new Exception("The username or password you supplied is incorrect.");
			}
			
			
			
			$this->mailUserActivationCode($email,$result["activation_code"]);
			return true;
		}
		
		/**
		 */
		
		public function checkInvitedWithActivationCode($code)
		{
			$query = "SELECT `invite_code` FROM `users` WHERE `activation_code` = :0 LIMIT 1";
			
			$info = $this->getSingleResult($query,array($code));
			
			return $info["invite_code"] > 0;
		}
		
		
		/**
		*/
		
		public function loginWithActivationCode($code,$login = true)
		{
			$query = "SELECT `email`,`password` FROM `users` WHERE `activation_code` = #sc:0 LIMIT 1";
			
			
			$user = $this->getSingleResult($query,array($code));
			
			if(!$user)
				return false;
				
			
			return $login ? $this->login($user["email"],$user["password"],false) : true;
		}
		
				
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function registerWithNewsberry($email,$fullName)
		{
			//nothing yet
			do_post_request("http://app.newsberry.com/Subscribe.aspx?auto=True",array("listID"=>6906,"Email"=>$email,"Full Name"=>$fullName));
		}
		
		
		/**
		 */
		
		private function mailUserActivationCode($email,$code)
		{
			$code = "http://cloveapp.com/activate/?code=$code";
			
    		smtp_mail($email,"Please confirm your account","Thanks for signing up for the Clove beta! Before you can download Clove, please activate your account. You can do so at $code");
		}
		
		
		/**
		 */
		
		private function activateWithInvite2($invite,$user)
		{
			$query = "UPDATE `users` SET `invite_code` = :0 WHERE `user` = :0";
			
			return $this->executeQuery($query,array($code,$user));
		}
		
	}
	
	
	

?>