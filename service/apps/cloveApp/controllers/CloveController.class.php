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
	
	public function ok_success($message,$display = "index")
	{
		$this->statusCode = ErrorCodes::SUCCESS;
		$this->statusMessage = $message;
		return $this->ok($display);
	}

	public function ok_unauthorized($message,$display="unauthorized")
	{
		$this->statusCode = ErrorCodes::UNAUTHORIZED;
		$this->statusMessage = $message;
		return 	$this->ok($display);
	}

	public function ok_unknownError($message)
	{
		$this->statusCode = ErrorCodes::UNKNOWN;
		$this->statusMessage = $message;
		return $this->ok("unauthorized");
	}
	
	public function ok_error($message,$display="index")
	{
		$this->statusCode = ErrorCodes::ERROR;
		$this->statusMessage = $message;
		return $this->ok($display);
	}
	
	public function ok_notFound($message,$display="index")
	{
		$this->statusCode = ErrorCodes::NOT_FOUND;
		$this->statusMessage = $message;
		return $this->ok($display);
	}
	
	public function ok_alreadyExists($message,$display="index")
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