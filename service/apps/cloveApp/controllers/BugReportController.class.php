<?php
Library::import('cloveApp.models.BugReport');
Library::import('cloveApp.helpers.BugUtil');
Library::import('recess.framework.forms.ModelForm');
Library::import('spice.library.security.InputSafety');

Library::import('spice.library.recess.SpiceController');
Library::import('cloveApp.controllers.CloveController');

/**
 * !RespondsWith Layouts
 * !Prefix bugs/
 */
 
class BugReportController extends CloveController 
{
	
	/** @var Screen */
	protected $screen;
	
	
	/** @var Form */
	protected $_form;
	
	function init()
	{
		$this->screen = new Screen();
		
		
		InputSafety::setMode(InputSafety::ON_DUMP);
		
		
		$this->_form  = new ModelForm('screens', $this->request->data('screen'),$this->screen);
	}
	
	
	/** !Route GET */
	function index() 
	{
		return $this->ok_success("Success","index");
	}
	
	
	
	/** !Route POST
	 	!Route POST, new
	 	!Route GET, new
		*/
	
	function insert()
	{
		
		
			
		$title    = InputSafety::cleanse($this->request->data('title'),"*");
		$desc     = InputSafety::cleanse($this->request->data('description'),"*");
		$priority = InputSafety::cleanse($this->request->data('priority'),"*");
		$replyTo  = InputSafety::cleanse($this->request->data('replyTo'),"*");
		
		
		if(InputSafety::hasErrors())
		{
			return $this->ok_error("Invalid submission.",1,"index");
		}
		
		
		
		$bug = new BugReport();
		$bug->title       = $title;
		$bug->priority    = $priority;
		$bug->description = $desc;
		$bug->reply_to     = $replyTo;
		
		$bug->uid = substr(base64_encode(microtime().rand()),0,255);
		
		if(isset($_FILES["settings"]))
		{
			if(!move_uploaded_file($_FILES["settings"]["tmp_name"],BugUtil::getBuggedCodeZip($bug)))
			{
				
				return $this->ok_error("Unable to upload settings file.",1,"index");
			}
		}
		
		
		$bug->insert();
		
		
		
		
		
		$headers  = "MIME-Version:1.0\r\n";
		$headers .= "Content-type: text/html; charset=iso-8859-1\r\n";
		$headers .= "From: $replyTo\r\n";
		$headers .= "Reply-To: $replyTo\r\n";
		$headers .= "X-Mailer: PHP/" . phpversion();
		
		$dlUrl = "http://".$_SERVER["HTTP_HOST"].$this->urlTo("downloadBuggedCode",$bug->uid);
		
		
		$dlhtml = "<a href=\"$dlUrl\">Download Bugged Code</a>";
		
		$message = 
		"
		priority: $priority
		<BR />
		<BR />
		Title: $title
		<BR />
		<BR />
		$dlhtml
		<BR />
		<BR />
		----------------------------------------------------------------
		<BR />
		<BR />
		$desc
		";
		
		mail("craig.j.condon@gmail.com","A bug with a \"$priority\" priority has been submitted.",$message,$headers);
		
		
		
		return $this->ok_success("Thank you for submitting a bug. We will take a look into this as soon as we can.","newBug");
	}
	
	/** !Route GET, download/$uid */

	public function downloadBuggedCode($uid)
	{
		if($mes = $this->getLoginMessage(AccountPrivs::ADMIN)) return $this->ok_unauthorized("Unauthorized","index");
		
		
		$bug = new BugReport();
		$bug->uid = $uid;
		
		
		
		if(!BugUtil::download($bug))
		{
			return $this->ok_error("File doesn't exist.");
		}
		
		die();
		
		
	}
	
	/** !Route GET, remove
	 */
	
	
	function removeScreen()
	{
		$this->setBasicHTTPAuth();
		
		
		//$ids = explode(",",$this->screen->id);
		
		
		if($this->screen->exists())
		{
			$this->screen->delete();
			
			return $this->ok_success("Success");
		}
		
		return $this->ok_notFound("Scene doesn't exist");
		
		
	}
	
	
	
	
	private function setScreenUser()
	{
			$this->screen->user = CurrentUser::getInstance()->getUser()->id;
	}
	
}
?>