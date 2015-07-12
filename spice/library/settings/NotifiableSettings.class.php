<?php
	
	require_once dirname(__FILE__)."/../observer/Notifier.class.php";
	require_once dirname(__FILE__)."/../notifications/SettingNotification.class.php";
	
	class NotifiableSettings extends Notifier
	{
		function __construct()
		{
			parent::__construct();
		}
		
		function saveSetting($name,$value)
		{
			//abstract
			
			$this->notifyObservers(new SettingNotification(SettingNotification::SETTING_CHANGE,$name,$value));
			
		}
		
		function removeSetting($name)
		{
		
			$this->notifyObservers(new SettingNotification(SettingNotification::SETTING_CHANGE,$name,null));
		}
	}

?>