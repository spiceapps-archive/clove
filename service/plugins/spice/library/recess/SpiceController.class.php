<?php
Library::import('recess.framework.controllers.Controller');

 

			require_once dirname(__FILE__).'/../utils/load.php';
/**
 * provides methods the Controller doesn't, such as Basic HTTP Auth
 */
 
abstract class SpiceController extends Controller 
{
	
	protected $_sessID = "SpiceController";
	
	
	
	/*public function __construct()
	{
		parent::__construct("");
		
		@session_start();
	}*/
	
	protected function setBasicHTTPAuth($unauthorizedCallback = 'basicHTTPAuthFail',
										$loginCallback = 'getBasicHTTPAuthCredentials',
										$realm 		  = 'Authorization')
	{
		@session_start();
		
		
		/*if (empty($_SERVER['PHP_AUTH_DIGEST'])) 
		{
			
    		$this->promptAuth($unauthorizedCallback,$realm);		
			
		}
		
		if (!($data = $this->parseHTTPDigest($_SERVER['PHP_AUTH_DIGEST'])))
    	{
    		return false;
   		}
   		
   		
   		$username = $data['username'];
   		
   		$cache = false;
   		
   		//check for the cached user. If it doesn't exist, then call the login function
   		//provided.
   		if(!($users = $this->getCachedLogin($username)))
   		{
   			
			$users = $this->$loginCallback($username);
   			   			if(!$users || !@isset($users[$username]))
   			{
   			
				$this->promptAuth($unauthorizedCallback,$realm);	
   				return false;
   			}
   			
   			$cache = true;
   			
   		}
   		
   		
   		$eq = $users[$username];
   		
   		
   		
   		$A1 = md5($username . ':' . $realm . ':' . @$users[$username]);
		$A2 = md5($_SERVER['REQUEST_METHOD'].':'.$data['uri']);
		$valid_response = md5($A1.':'.$data['nonce'].':'.$data['nc'].':'.$data['cnonce'].':'.$data['qop'].':'.$A2);
		
		if($data['response'] != $valid_response)
		{
			$this->promptAuth($unauthorizedCallback,$realm);
			
			return false;
		}
		
		if($cache)
		{	
   			$this->cacheLogin($username,$users[$username]);
		}*/
		
		
		if(!isset($_SERVER['PHP_AUTH_USER']))
		{
    		
    		$this->promptAuth($unauthorizedCallback,$realm);	
    		
    	}
    	
   		
   		$username = $_SERVER['PHP_AUTH_USER'];
   		$password = $_SERVER['PHP_AUTH_PW'];
   		
   		
   		$cache = false;
   		
   		//check for the cached user. If it doesn't exist, then call the login function
   		//provided.
   		if(!($users = $this->getCachedLogin($username,$password)))
   		{
   			
   			
			$users = $this->$loginCallback($username,$password);
			
			//die($password);
			
   			if(!$users || !@isset($users[$username]))
   			{
   			
				$this->promptAuth($unauthorizedCallback,$realm);	
   				return false;
   			}
   			
   			$cache = true;
   			
   		}
   		
		
		if($password != $users[$username])
		{
			$this->promptAuth($unauthorizedCallback,$realm);
			
			return false;
		}
		
		if($cache)
		{	
   			$this->cacheLogin($username,$users[$username]);
		}
		
		
		return true;
	}
	
	
	private function promptAuth($unauthorizedCallback,$realm)
	{
		    /*header('WWW-Authenticate: Digest realm="'.$realm.
           '",qop="auth",nonce="'.uniqid().'",opaque="'.md5($realm).'"');
    		header('HTTP/1.1 401 Unauthorized');*/
    		
    		
			header("WWW-Authenticate: Basic realm=\"$realm\"");
    		header('HTTP/1.0 401 Unauthorized');
    		
    		
			    //header('WWW-Authenticate: Basic realm="Secret page"');

            
//			$policy = new DefaultPolicy();
//			$response = $this->$unauthorizedCallback();
//			$desc = Controller::getClassDescriptor($this);
//			$response->meta->viewClass = $desc->viewClass;
//			$response->meta->viewsPrefix = $desc->viewsPrefix;
//			$response->data= get_object_vars($this);
//			$response->meta->viewsName = $desc->viewsName;
//			$view = $policy->getViewFor($response);
//			
			
			$root = $this->application->routingPrefix.$this->getViewsPrefix($this);
			$root = str_replace('/', '\/', $root);
			$url = $_SERVER['REQUEST_URI'];
			
			
			
			
			//comment out
			header('content-type:text/xml');
			
			$htmlpath = preg_replace('/(.*?'.$root.').*/',"http://".$_SERVER['HTTP_HOST']."$1".$unauthorizedCallback."/",$url);
			
			die(load($htmlpath));
			//header("Location:$htmlpath");
			//print_r($_SERVER);
			//exit;
			//echo file_get_contents($htmlpath);
			//print_r($this);
			//ob_start();
			
			//echo file_get_contents("http://www.google.com/search?hl=en&client=firefox-a&hs=v5p&rls=org.mozilla%3Aen-US%3Aofficial&q=php+WWW-authenticat//+parameters&aq=f&aqi=&aql=&oq=&gs_rfai=");
			//$view->respondWith($response);
			

	}
	
	
	
	// function to parse the http auth header
	/*private function parseHTTPDigest($txt)
	{
	    // protect against missing data
	    $needed_parts = array('nonce'=>1, 'nc'=>1, 'cnonce'=>1, 'qop'=>1, 'username'=>1, 'uri'=>1, 'response'=>1);
	    $data = array();
	    $keys = implode('|', array_keys($needed_parts));
	
	    preg_match_all('@(' . $keys . ')=(?:([\'"])([^\2]+?)\2|([^\s,]+))@', $txt, $matches, PREG_SET_ORDER);
	
	    foreach ($matches as $m) {
	        $data[$m[1]] = $m[3] ? $m[3] : $m[4];
	        unset($needed_parts[$m[1]]);
	    }
	
	    return $needed_parts ? false : $data;
	}*/
	
	
	abstract protected function cacheLogin($user,$pass);
	abstract protected function getCachedLogin($user,&$password);
	abstract protected function getBasicHTTPAuthCredentials(&$user);
}

?>