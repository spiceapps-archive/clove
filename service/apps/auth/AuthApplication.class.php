<?php
Library::import('recess.framework.Application');

class AuthApplication extends Application {
	public function __construct() {
		
		$this->name = 'Spice Auth';
		
		$this->viewsDir = $_ENV['dir.apps'] . 'auth/views/';
		
		$this->assetUrl = $_ENV['url.base'] . 'apps/auth/public/';
		
		$this->modelsPrefix = 'auth.models.';
		
		$this->controllersPrefix = 'auth.controllers.';
		
		$this->routingPrefix = 'auth/';
				
	}
}
?>