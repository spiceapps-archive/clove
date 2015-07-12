<?php
Library::import('auth.controllers.AuthController');
Library::import('recess.framework.forms.ModelForm');

// !RespondsWith Layouts
/**
 * !Prefix session/
 */
class SessionController extends AuthController {
	
	
	/** @var Form */
	protected $_form;
	
	function init() {
		$this->_form = new ModelForm('session', $this->request->data('session'));
	}
	
	/** !Route GET */
	function index() {
		die("");
		/*$this->sessionSet = $this->session->all();
		if(isset($this->request->get['flash'])) {
			$this->flash = $this->request->get['flash'];
*/
	}
	
	/** !Route GET, $id */
	/*function details($id) {
		
		$this->session->id = $id;
		if($this->session->exists()) {
			return $this->ok('details');
		} else {
			return $this->forwardNotFound($this->urlTo('index'));
		}
	}*/
	
	/** !Route GET, new */
	function newForm() {
		if($this->current_user instanceOf User) return $this->redirect($this->urlTo('DefaultController::index')); 
		$this->user = new User();
		$this->_form->to(Methods::POST, $this->urlTo('insert'));
		return $this->ok('editForm');
	}
	
	/** !Route GET,login */
	function insert() {
		
		
		$this->user = new User();
		$this->user->username = $this->request->data('user');
		$this->user->password = $this->_crypt->encrypt($this->request->data('password'));
		
		
		if($this->user->exists()) {
			
			try {
				
				
				CurrentUser::getInstance()->setUser($this->user);
				
				
				return $this->created($this->urlTo('DefaultController::index'));
			} catch(Exception $exception) {
				return $this->conflict('editForm');
			}
		} else 
		{
			header('HTTP/1.0 401 Unauthorized');
			die("Unauthorized");
			
			$this->flash = 'Username or Password not found.';
			$this->_form->to(Methods::POST, $this->urlTo('insert'));
			return $this->conflict('editForm');
		}
	}
	
	
	/** !Route GET, noAcc */
	
	
	function noAccessTest()
	{
		$this->setBasicHTTPAuth();
		
		die("");
	}
	
	
	
//	/** !Route GET, $id/edit */
//	function editForm($id) {
//		$this->session->id = $id;
//		if($this->session->exists()) {
//			$this->_form->to(Methods::PUT, $this->urlTo('update', $id));
//		} else {
//			return $this->forwardNotFound($this->urlTo('index'), 'Session does not exist.');
//		}
//	}
//	
//	/** !Route PUT, $id */
//	function update($id) {
//		$oldSession = new Session($id);
//		if($oldSession->exists()) {
//			$oldSession->copy($this->session)->save();
//			return $this->forwardOk($this->urlTo('details', $id));
//		} else {
//			return $this->forwardNotFound($this->urlTo('index'), 'Session does not exist.');
//		}
//	}
	
	/** !Route DELETE, $id */
	function delete($id) {
		session_regenerate_id(true);
		$this->flash = 'You are now signed out.';
		return $this->redirect('/');
	}
}
?>