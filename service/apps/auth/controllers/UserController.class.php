<?php
Library::import('auth.models.User');
Library::import('auth.models.LoginToken');
Library::import('auth.controllers.AuthController');
Library::import('recess.framework.forms.ModelForm');
Library::import('spice.library.security.InputSafety');
Library::import('spice.library.utils.RequestUtil');

define ("MAX_LOGIN_ATTEMPTS",5);
define ("LOCK_TIMEOUT",5*60); //seconds
/**
 * !RespondsWith Layouts
 * !Prefix user/
 */
class UserController extends AuthController {
	
	/** @var User */
	protected $user;
	
	/** @var Form */
	protected $_form;
	
	function init() {
		
		InputSafety::setMode(InputSafety::ON_DUMP);
		$this->user = new User();
		$this->_form = new ModelForm('user', $this->request->data('user'), $this->user);
	}
	
	/** !Route GET */
	function index() {
		return $this->ok('index');
	}
	
	/** !Route GET, $id */
	/*function details($id) {
		$this->user->id = $id;
		if($this->user->exists()) {
			return $this->ok('details');
		} else {
			return $this->forwardNotFound($this->urlTo('index'));
		}
	}*/
	
	/** !Route GET, new 
	 	!Route GET, signup
	 	!Route GET, register
	 */
	 
	function newForm() {
		if($this->current_user instanceOf User) return $this->ok('loggedIn');
		
		$this->_form->to(Methods::POST, $this->urlTo('insert'));
		return $this->ok('editForm');
	}
	
	
	/**
	  * !Route GET, lostpassword/
	  */

	function lostPassword()
	{	
		$this->_form->to(Methods::POST, $this->urlTo('lostPassword'));
		return $this->ok('lostPassword');
	}
	
	/**
	  * !Route GET, lostpassword/reset/$token
	  * !Route POST, lostpassword/reset/$token
	  */
	
	function resetLostPassword($token='')
	{
		$token = InputSafety::cleanse($token,'mysqlSafeChars','invalid token.');
		
		$errors = InputSafety::dumpErrors();
		
		if(count($errors))
		{
			return $this->error(implode("<br />",$errors),"index");
		}
		
		
		$loginToken 	   = new LoginToken();
		$loginToken->token = $token;
		
		$this->_form->to(Methods::POST, $this->urlTo('resetLostPassword',$token));
		
		
		
		if(!$loginToken->exists())
		{
			return $this->error("That token doesn't exist.","index");
		}
		
		if(!$this->request->data('password'))
		{
			
			return $this->ok("resetLostPassword");
		}
		else
		{
			$password = InputSafety::cleanse($this->request->data('password'),'string','invalid password.');
			
			$errors = InputSafety::dumpErrors();

			if(count($errors))
			{
				return $this->error(implode("<br />",$errors),"index");
			}
			
			$user = new User($loginToken->user);
			$user->password = md5($password);
			
			$user->update();
			
			$loginToken->delete();
			
			$this->_form->to(Methods::POST, $this->urlTo('login'));
			
			return $this->finished("Your password has been reset.",0,"login");
		}
		
	}
	
	
	/**
	  * !Route POST, lostpassword/
	  */

	function postLostPassword()
	{	
		$this->_form->to(Methods::POST, $this->urlTo('lostPassword'));
		
		
		$email  = InputSafety::cleanse($this->request->data('email'),'email','We could not find that email address in our database.');
		
		$errors = InputSafety::dumpErrors();
		
		//setup the post form 
		$this->_form->to(Methods::POST, $this->urlTo('lostPassword'));
		
		
		if(count($errors))
		{
			return $this->finished(implode("<br />",$errors),1,"lostPassword");
		}
		
		
		$user = new User();
		$user->email = $email;
		
		
		if(!$user->exists())
		{
			return $this->error("That email doesn't exist in our database.","lostPassword");
		}
		
		
		$loginToken = new LoginToken();
		$loginToken->user = $user->id;
		
		
		//only generate the token if it doesn't exist
		if(!$loginToken->exists())
		{
			$loginToken->token = substr(base64_encode($user->email.(string)(time()+rand()*99999)),0,200);
			$loginToken->insert();
		}
		
		
		
		
		$message = 
"
".$user->email.",

This email was sent in response to your request to recover your password. To reset your password and access your account, click on the link below.

http://".$_SERVER['HTTP_HOST']."/".$this->urlTo("resetLostPassword",$loginToken->token)."

The link will reset your forgotten password, and let you create a new one.

If you did not request that we send this Forgotten Password email to you, just ignore it.
";
		
		
		$this->send_email($user->email,"Forgotten Password",$message);
		
		
		return $this->finished("Please check your email for instructions on how to reset your password.",0,'lostPassword');
	}
	
	
	/**
	  * !Route GET, login
	  */
	
	function login()
	{	
		if($this->current_user instanceOf User) return $this->ok('loggedIn');
		$this->_form->to(Methods::POST, $this->urlTo('postLogin'));
		return $this->ok('login');
	}
	
	/**
	  * !Route POST, login
	  */
	
	function postLogin()
	{
		if($this->current_user instanceOf User) return $this->ok("loggedIn");
		
		
		
		$email  = InputSafety::cleanse($this->request->data('email'),'email','invalid email.');
		$password  = InputSafety::cleanse($this->request->data('password'),'mysqlSafeChars','invalid password.');
		
		
		$errors = InputSafety::dumpErrors();
		
		$this->_form->to(Methods::POST, $this->urlTo('postLogin'));
		
		if(count($errors))
		{
			return $this->finished(implode("<br />",$errors),1,"login");
		}
		
		
		$user = new User();
		$user->email = $email;
		
		if($user->exists())
		{
			
			//if the login attempts are greater than zero, and the last time the user has logged in was
			//more than the lock timeout, then reset the login attempts to zero.
			if($user->login_attempts > 0 && (time() - $user->last_login) > LOCK_TIMEOUT)
			{
				//reset the login attempts to zero after lockout timeout
				$user->login_attempts = 0;
			}
			
			if($user->login_attempts > MAX_LOGIN_ATTEMPTS)
			{
				
				return $this->error("You're account has been temporarily locked.","login");
			}
			
			$u = new User();
			$u->email = $email;
			
			$u->password = md5($password);
			
			if($this->loginUser($u))
			{
				return $this->ok('loggedIn');
			}
			$user->last_login = time();
			$user->login_attempts++;
			$user->update();
		}
		
		
		
		return $this->error("Incorrect login credentials.","login");
	}
	
	/** !Route POST 
	  */
	function insert() {
		if($this->current_user instanceOf User) return $this->ok('loggedIn');
		
		
		InputSafety::setMode(InputSafety::ON_DUMP);
		
		$username  = InputSafety::cleanse($this->request->data('username'),new RegexpSafetyHandler('/[\w\s]*/'),'Invalid Username');
		$full_name = InputSafety::cleanse($this->request->data('name'),'mysqlSafeChars','Invalid Full Name');
		$password  = InputSafety::cleanse($this->request->data('password'),'string','Invalid Password');
		$email     = InputSafety::cleanse($this->request->data('email'),'email','Invalid Email');
		
		$registerWithNewsberry = isset($_POST['subscribe']);//$this->request->data('subscribe');
		
		
		
		$errors = InputSafety::dumpErrors();
		
			//die("FSDf njkdfgbvj,kgfd mnfgdfjb,");
		if(count($errors))
		{
			$this->_form->to(Methods::POST, $this->urlTo('insert'));
			return $this->finished(implode("<br />",$errors),1,"editForm");
		}	
		
		
		$user = new User();
		$user->username = $username;
		
		
		$user2 = new User();
		$user2->email = $email;
		
		if($user->exists() && false) 
		{
				$this->_form->to(Methods::POST, $this->urlTo('insert'));
			return $this->finished('That username is already registered.',1,"editForm");
		}else if($user2->exists()) 
		{
				$this->_form->to(Methods::POST, $this->urlTo('insert'));
			return $this->finished('That email address is already registered.',1,"editForm");
		} else {
			try {
				//$this->user->is_active = 1;
				//$this->user->created_ip = $_SERVER['REMOTE_ADDR'];
				$this->user->password = md5($password);//$this->_crypt->encrypt($password);
				$this->user->fullName = $full_name;
				$this->user->username = $username;
				$this->user->email = $email;
				$this->user->subscribed = $registerWithNewsberry;
				
				
				if($registerWithNewsberry)
					RequestUtil::doPostRequest("http://app.newsberry.com/Subscribe.aspx?auto=True",array("listID"=>6906,"Email"=>$email,"Full Name"=>$full_name));
				
				$headers = 'From: hello@spiceapps.com' . "\r\n" .
				    'Reply-To: hello@spiceapps.com' . "\r\n" .
				    'X-Mailer: PHP/' . phpversion();
					
				
				mail($email,"You've been invited to the Clove beta!","Thanks for your interest in Clove! You can download Clove at http://cloveapp.com/download/",$headers);
				
				$this->user->insert();
				
				CurrentUser::getInstance()->setUser($this->user);
				$this->current_user = $this->user;
				
				return $this->finished("Thanks for signing up for Clove beta! <a href=\"/download/\">Download Clove</a>.",0);
			} catch(Exception $exception) {	
				return $this->finished($exception->getMessage(),1,"editForm");
			}
		}
	}
	
	
	private function send_email($to,$subject,$message)
	{
		return mail($to,$subject,$message);
	}
	
	// /** !Route GET, $id/edit */
	// function editForm($id) {
	// 	$this->user->id = $id;
	// 	if($this->user->exists()) {
	// 		$this->_form->to(Methods::PUT, $this->urlTo('update', $id));
	// 	} else {
	// 		return $this->forwardNotFound($this->urlTo('index'), 'User does not exist.');
	// 	}
	// }
//	
//	/** !Route PUT, $id */
//	function update($id) {
//		$oldUser = new User($id);
//		if($oldUser->exists()) {
//			$oldUser->copy($this->user)->save();
//			return $this->forwardOk($this->urlTo('details', $id));
//		} else {
//			return $this->forwardNotFound($this->urlTo('index'), 'User does not exist.');
//		}
//	}
//	
//	/** !Route DELETE, $id */
//	function delete($id) {
//		$this->user->id = $id;
//		if($this->user->delete()) {
//			return $this->forwardOk($this->urlTo('index'));
//		} else {
//			return $this->forwardNotFound($this->urlTo('index'), 'User does not exist.');
//		}
//	}
}
?>