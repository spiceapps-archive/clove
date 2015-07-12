<?php
Library::import('recess.framework.Application');

class CloveAppApplication extends Application {
	public function __construct() {
		
		$this->name = 'Clove';
		
		$this->viewsDir = $_ENV['dir.apps'] . 'cloveApp/views/';
		
		$this->assetUrl = $_ENV['url.base'] . 'apps/cloveApp/public/';
		
		$this->modelsPrefix = 'cloveApp.models.';
		
		$this->controllersPrefix = 'cloveApp.controllers.';
		
		$this->routingPrefix = 'cloveApp/';
				
	}
}
?>