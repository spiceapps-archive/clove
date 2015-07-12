<?php

	function htmlpath($relative_path)
	{
		$realpath = realpath($relative_path);
		
		$root_dir = basename($_SERVER['DOCUMENT_ROOT']);
	
		$regexp = '/.*?'.$root_dir.'(?=\/)/';
		
		
		$htmlpath = preg_replace($regexp,"http://".$_SERVER['HTTP_HOST'],$realpath);
		
		return $htmlpath;

	}

?>