<?php
Library::import('recess.framework.controllers.Controller');
Library::import('spice.library.recess.SpiceController');
Library::import('auth.helpers.CurrentUser');
Library::import('spice.library.crypt.ProCrypt');

/**
 * !RespondsWith Layouts
 * !Prefix Views: init/, Routes: init/
 */

define("AUTH_UNKNOWN_ERROR",-1);
define("AUTH_SUCCESS",0);
define("AUTH_ERROR",1);
define("AUTH_UNAUTHORIZED",1);

class AuthController extends SpiceController {
	
	/** @var statusCode */
	public $statusCode = 0;
	
	/** @var statusMessage */
	public $statusMessage = "";
	
	protected $_crypt;
	
	public function __construct($application = null) {
		parent::__construct($application);
		
		$this->_crypt = new ProCrypt();
		$this->_crypt->Mode = CRYPT_MODE_BASE64;
		$this->_crypt->Key = "j4t9034dg";
		
		$this->current_user = CurrentUser::getInstance()->getUser();
	}
	
	/** !Route GET */
	public function index()
	{
		
	}
	
	
	protected function getBasicHTTPAuthCredentials(&$uname)
	{
		
		
		
		$user = new User();
		$user->email = $uname;
		$user = $user->select()->first();
		
		
		
		if(!($user instanceOf User))
			return false;
			
		
		
		$inf[$uname] = $user->password;//$this->_crypt->decrypt($user->password);
		return $inf;
	}
	
	protected function cacheLogin($email,$pass)
	{
		
		$user = new User();
		$user->email    = $email;
		$user->password = $pass;//$this->_crypt->encrypt($pass);
		$user		    = $user->select()->first();
		
		
		if($user instanceOf User)
		{
			CurrentUser::getInstance()->setUser($user);
		}
		return true;
	}
	
	protected function loginUser(User $user)
	{	
		if((!$user instanceOf User))
		{
			return false;
		}
		
		if(!$user->exists())
		{
			return false;
		}
		
		CurrentUser::getInstance()->setUser($user);
		
		$this->current_user = $user;
		
		return true;
	}
	
	
	protected function getCachedLogin($user,&$password)
	{
		$user = CurrentUser::getInstance()->getUser();
		
		$password = md5($password);
		
		if($user instanceOf User) 
		{
			
			$inf = array();
			$inf[$user->email] = $user->password;//$this->_crypt->decrypt($user->password);
			return $inf;
		}
		
		
		return false;
		
	}
	
	
	public function finished($message,$code,$display = "index")
	{
		$this->statusCode    = $code;
		$this->statusMessage = $message;
		return $this->ok($display);	
	}
	
	public function error($message,$display = "index")
	{
		$this->statusCode    = 1;
		$this->statusMessage = $message;
		return $this->ok($display);	
	}
	
	protected function loggedIn()
	{
		return $this->current_user instanceOf User;
	}
	
	protected function getLoginMessage($privs = 0,$index1 = "main/notLoggedIn",$index2 = "main/unauthorized")
	{
		if(!$this->loggedIn())
			return $this->ok($index1);
		
		if($privs && !($this->current_user->permissions & $privs)) return $this->ok($index2);
		
		return false;
	}
	
}
?>