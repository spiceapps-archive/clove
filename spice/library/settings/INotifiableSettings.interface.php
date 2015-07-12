<?php
	require_once dirname(__FILE__)."/../observer/INotifier.interface.php";
	require_once dirname(__FILE__)."/ISettings.interface.php";
	
	interface INotifiableSettings extends INotifier, ISettings
	{
		
	}
	
?>