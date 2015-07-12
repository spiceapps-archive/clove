<?php
	
	//http://localhost/work/clove3/spice/driver/amfGateway.php?app=bugTrack
	
	require_once dirname(__FILE__).'/Service.php';
	

	abstract class UserService extends Service
	{
	
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private $_userTable;
		private $_userField;
		private $_passField;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		function __construct($userTable,$userField = "user", $passField = "password")
		{
			parent::__construct();
			
			
			
			$this->_userTable = $userTable;
			$this->_userField = $userField;
			$this->_passField = $passField;
			
			@session_start();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        abstract public function login($user,$pass,$usemd5 = false);
   
		
		/**
		 */
		
		public function logout()
		{
			unset($_SESSION["userInfo"]);
		}
		
		
		/**
		 */
		
		public function hasUser($user)
		{
			$uField = $this->_userField;
			
			$result = $this->getResult("SELECT `$uField` FROM `users` WHERE `$uField` = #sc:0 LIMIT 1",array($user))->toArray();
			
			
			return count($result) > 0;
		}
		
		
		/**
		 */
		
		public function isLoggedIn()
		{
			return isset($_SESSION['userInfo']);
		}
		
		/**
		 */
		
		public function loggedInUser()
		{
			return $this->isLoggedIn() ? $_SESSION["userInfo"] : null;
		}
		
		/**
		 */
		
		public function userId()
		{
			$user = $this->loggedInUser();
			
			return $user["id"];
		}
		
		/**
		 */
		
		public function verifySession()
		{
			if(!$this->isLoggedIn())
			{
				throw new Exception("Not logged in.");
			}
			
			return $this->loggedInUser();
			
			
			
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		protected function executeRegisterQuery($query,$params)
		{
			//if the user exists, then throw an exception
			
			$user = $params[$this->_userField];
			
			
			//get the query so we can grab the errors. This is important so the user
			//know's what to fix
			$query = self::$connection->getQuery($query,$params);
			
			
			if(!$query)
			{
				return false;
			}
			
			if($this->hasUser($user))
			{
				throw new Exception("The username \"".(is_array($user) ? $user[0] : $user)."\" already exists");
			}
			
			
			$this->executeQuery($query);
			
			return self::$connection->getLastInsertedId();
		}
		
		
		
		/**
		 */
		
		protected function loginUser($selectItems,$user,$pass,$usemd5 = false)
		{
		
			$uField = $this->_userField;
			$pField = $this->_passField;
			
			if(!$this->isLoggedIn())
			{
				$query = "SELECT $selectItems FROM `users` WHERE `$uField` = #sc:0 AND `$pField` = #sc:1 LIMIT 1";
				
				
				// return $this->getQuery($query,array($user,'39865afa936e98f49357f1448433cd '.md5($pass)));
				
				$result = $this->getResult($query,array($user,$usemd5 ? md5($pass) : $pass))->toAssocArray();
				
				
				$this->checkLoggedInUser(count($result) > 0 ? $result[0] : null);
				
				$_SESSION['userInfo'] = $result[0];
			}
			
			return true;
		}
		
		
		/*public function updatePasswords()
		{
			// $this->executeQuery("UPDATE `users` SET `password` = MD5(`password`) WHERE `email` =  craig@spiceapps.com' LIMIT 1");
			
			$e = $this->getResult("SELECT * FROM `users` WHERE `id`")->toAssocArray();
			
			
			foreach($e as $user)
			{
				 $this->executeQuery("UPDATE `users` SET `password` = MD5(:0) WHERE `email` =  :1 LIMIT 1",array($user["password"],$user["email"]));
				
			}
			
			
			
		}*/
		
		/**
		 */
		
		protected function checkLoggedInUser($info)
		{
			if(!$info)
			{
				throw new Exception("Incorrect username / password");
			}
		}
		
		
		
		
	}


	

?>