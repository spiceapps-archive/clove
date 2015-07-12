<?php
	
	require_once dirname(__FILE__).'/BaseCloveUserService.php';
	require_once CORE_SERVICES_DIR.'/Service.php';
	require_once APP_LIB_DIR.'/swiftMailer/lib/swift_required.php';
	
	
	class InviteCodeService extends Service
	{
	
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function __construct()
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
		
		public function addInviteCode($code = null,$invitesLeft = -1)
		{
			
			$query = "INSERT INTO `invite_codes` (`invites_left`,`code`) VALUES(:0,:1)";
			
			
			return $this->executeQuery($query,array($invitesLeft,$code));
			
		}
		
		
		/**
		 */
		
		public function getInviteCode($code)
		{
			
			$query = "SELECT * FROM `invite_codes` WHERE `code` = :0 AND (`invites_left` > '0' OR `invites_left` <= '-1') LIMIT 1";
			
			$result = $this->getResult($query,array($code))->toAssocArray();
			
			return @$result[0];
		}
		
		/**
		 */
		
		public function getInviteCodeId($code)
		{
			
			$query = "SELECT `id` FROM `invite_codes` WHERE `code` = :0 AND (`invites_left` > '0' OR `invites_left` <= '-1') LIMIT 1";
			
			$result = $this->getResult($query,array($code))->toAssocArray();
			
			return @$result[0]["id"];
		}
		
		
		/**
		 */
		
		public function inviteUsers($limit)
		{
			$query = "SELECT * FROM `users` WHERE `invite_code` = '0' LIMIT $limit";
			
			
			$result = $this->getResult($query,array($limit));
			
			$used = array();
			
			
			
			while($data = $result->fetchAssoc())
			{	
				$email = $data["email"];
				$aCode = $data["activation_code"];
				
				$used[] = "`email`= '".$email."'";
			
				
				
				
				$this->notifyInvited($email,$aCode);
			}
			
			
			
			
			//update the selected users
			$query = "UPDATE `users` SET `invite_code` = '1' WHERE ".implode(" OR ",$used);
			
			
			
			
			$this->executeQuery($query);
			
		}
		
		
		/**
		 */
		
		public function inviteUser($email)
		{
			if($this->executeQuery("UPDATE `users` SET `invite_code` = '1' WHERE `email` = :0",array($email)))
			{
				$info = $this->getResult("SELECT `activation_code` FROM `users` WHERE `email` = :0 LIMIT 1",array($email))->toAssocArray();
				
				$code = $info[0]["activation_code"];
				
				$this->notifyInvited($email,$code);
				
				return true;
			}
			
			return false;
		}
		
		/**
		 */
		
		public function useInviteCode($code,$userName)
		{
			$codeInfo = $this->getInviteCode($code);
			
			
			if(!$codeInfo)
				return false;
				
			$query = "UPDATE `invite_codes` SET `invites_left` = :0 WHERE `code` = #sc:1";
			
			
			$this->executeQuery($query,array($codeInfo["invites_left"]-1,$code));
			
			
			$query = "UPDATE `users` SET `invite_code` = :0 WHERE `email` = :1";
			
			
			$this->executeQuery($query,array($codeInfo["id"],$userName)); 
			
			return $codeInfo;
		}
		
		/**
		 */
		
		public function getInviteCodes()
		{
			$query = "SELECT * FROM `invite_codes` WHERE `id`";
			
			return $this->getResult($query)->toAssocArray();
		}
		
		/**
		 */
		
		public function removeInvite($code)
		{
			$query = "DELETE FROM `invite_codes` WHERE `id` = :0";
			
			return $this->executeQuery($query,array($code));
		}
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		private function notifyInvited($email,$activation)
		{
			smtp_mail($email,"You've been invited to the Clove beta!","Thanks for your interest in Clove! You can download Clove at http://cloveapp.com/activate/?code=$activation.");
			
		}
		
		
	}
	
?>