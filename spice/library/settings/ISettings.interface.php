<?php

	interface ISettings
	{
		function saveSetting($name,$value);
		function getSetting($name);
		function hasSetting($name);
		function removeSetting($name);
		function getId();
	}

?>