<?php
Library::import('auth.models.User');


define("CURRENT_USER_SESSID","CurrentUser");

class CurrentUser
{
	
	
	private static $_instance;
	
	
	public function __construct()
	{
		session_start();

		if(!isset($_SESSION[CURRENT_USER_SESSID]))
		{
			$_SESSION[CURRENT_USER_SESSID] = array();
		}
	}
	
	
	public static function getInstance() 
	{
		if(self::$_instance instanceOf CurrentUser) return self::$_instance;
		
		
		return self::$_instance = new CurrentUser();
		
	}
	
	
	public function isAdmin()
	{
		return $this->current_user instanceOf User && $this->current_user->exists() && $this->current_user->is_admin;
	}
	
	public function setUser(User $user)
	{
		$_SESSION[CURRENT_USER_SESSID] = $user;
	}
	
	public function getUser()
	{
		return $_SESSION[CURRENT_USER_SESSID];
	}
	
	
	
	
}
?>