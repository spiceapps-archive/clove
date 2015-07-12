<?php
Library::import('auth.controllers.AuthController');
Library::import('cloveApp.helpers.ErrorCodes');

/**
 * !RespondsWith Layouts
 * !Prefix root/
 */
class CloveController extends AuthController 
{
	
	/** !Route GET */
	function index() {
		
		die('');
		
	}
	
	public function success($message,$display = "index")
	{
		$this->statusCode = ErrorCodes::SUCCESS;
		$this->statusMessage = $message;
		return $this->ok($display);
	}

	public function unauthorized($message)
	{
		$this->statusCode = ErrorCodes::UNAUTHORIZED;
		$this->statusMessage = $message;
		return 	$this->ok("unauthorized");
	}

	public function unknownError($message)
	{
		$this->statusCode = ErrorCodes::UNKNOWN;
		$this->statusMessage = $message;
		return $this->ok("unauthorized");
	}
	
	public function error($message,$display="index")
	{
		$this->statusCode = ErrorCodes::ERROR;
		$this->statusMessage = $message;
		return $this->ok($display);
	}
	
	public function notFound($message,$display="index")
	{
		$this->statusCode = ErrorCodes::NOT_FOUND;
		$this->statusMessage = $message;
		return $this->ok($display);
	}
	
	public function alreadyExists($message,$display="index")
	{
		return $this->finished($message,ErrorCodes::ALREADY_EXISTS,$display);
	}

	/** !Route GET, basicHTTPAuthFail */

	public function basicHTTPAuthFail()
	{
		return $this->unauthorized("Incorrect Authentication Credentials.");
	}
	
	protected function getInputErrors($display="index")
	{
		if(InputSafety::hasErrors())
			return $this->error(InputSafety::errorsToStr("<br />"),$display);
			
		return false;
	}
}
?>