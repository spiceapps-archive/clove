<?php
Library::import('cloveApp.models.Test');
Library::import('recess.framework.forms.ModelForm');

/**
 * !RespondsWith Layouts
 * !Prefix test/
 */
class TestController extends Controller {
	
	/** @var Test */
	protected $test;
	
	/** @var Form */
	protected $_form;
	
	function init() {
		$this->test = new Test();
		$this->_form = new ModelForm('test', $this->request->data('test'), $this->test);
	}
	
	/** !Route GET */
	function index() {
		$this->testSet = $this->test->all();
		if(isset($this->request->get['flash'])) {
			$this->flash = $this->request->get['flash'];
		}
	}
	
	/** !Route GET, $id */
	function details($id) {
		$this->test->id = $id;
		if($this->test->exists()) {
			return $this->ok('details');
		} else {
			return $this->forwardNotFound($this->urlTo('index'));
		}
	}
	
	/** !Route GET, new */
	function newForm() 
	{
		$this->_form->to(Methods::POST, $this->urlTo('insert'));
		return $this->ok('editForm');
	}
	
	/** !Route POST */
	function insert() {
		try {
			$this->test->insert();
			return $this->created($this->urlTo('details', $this->test->id));		
		} catch(Exception $exception) {
			return $this->conflict('editForm');
		}
	}
	
	/** !Route GET, $id/edit */
	function editForm($id) {
		$this->test->id = $id;
		if($this->test->exists()) {
			$this->_form->to(Methods::PUT, $this->urlTo('update', $id));
		} else {
			return $this->forwardNotFound($this->urlTo('index'), 'Test does not exist.');
		}
	}
	
	/** !Route PUT, $id */
	function update($id) {
		$oldTest = new Test($id);
		if($oldTest->exists()) {
			$oldTest->copy($this->test)->save();
			return $this->forwardOk($this->urlTo('details', $id));
		} else {
			return $this->forwardNotFound($this->urlTo('index'), 'Test does not exist.');
		}
	}
	
	/** !Route DELETE, $id */
	function delete($id) {
		$this->test->id = $id;
		if($this->test->delete()) {
			return $this->forwardOk($this->urlTo('index'));
		} else {
			return $this->forwardNotFound($this->urlTo('index'), 'Test does not exist.');
		}
	}
}
?>