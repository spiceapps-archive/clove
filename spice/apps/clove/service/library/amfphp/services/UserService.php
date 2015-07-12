<?php

	require_once(dirname(__FILE__).'/../../core/MysqlConnector.class.php'); 
	
	class UserService extends MysqlConnector
	{
		
		
		
		function UserService()
		{
			parent::__construct();
			
			
			session_start();
		}
		
		
		function signup($email,$password)
		{
			$result = self::$connection->getResult(get_query("GET_USER"),array($email));
			
			if($result)
			{
				throw new Exception("That username already exists.");
			}
			
			
			
			$result = self::$connection->execute(get_query('REGISTER_USER'),array($email,$password));
			
			
			if(!$result)
			{
				throw new Exception(implode("\n",ErrorLog::get_errors()));
			}
			
			$this->login($email,$password);
			
			return "Thank you for signing up.";
		}
		
		
		
		function login($email,$password)
		{
			
			if(!$this->isLoggedIn())
			{
				$result = self::$connection->getResult(get_query('LOGIN_USER'),array($email,$password));
			
				if(!$result)
				{
					throw new Exception("The username or password specified is incorrect.");
				}
			
				
				$this->addSession($result[0]);
			}
			
			return "You're now logged in.".$this->isLoggedIn();
		}
		
		
		function logoutUser()
		{
			unset($_SESSION['userInfo']);
		}
		
		function loggedInUser()
		{
			if(!$this->isLoggedIn())
				return null; 
				
			return $_SESSION['userInfo'];
		}
		
		
		function verifySession($permissions = 0)
		{
			if(!$this->isLoggedIn())
			{
				throw new Exception('Not logged in.');
			}
			
			
			$info = $this->loggedInUser();
			
			if(false && $info["permissions"] < $permissions)
			{
				throw new Exception("Not enough privileges.");
			}
			
			return;
		}
		
		
		function isLoggedIn()
		{
			return isset($_SESSION['userInfo']);
		}
		
		private function addSession($info)
		{
			$_SESSION['userInfo'] = $info;
		}
		
		
		
		
		
		
		
	}
	
	
	
?>