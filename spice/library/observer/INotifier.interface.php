<?php
	require_once dirname(__FILE__)."/../notifications/Notification.class.php";
	
	interface INotifier
	{
		function notifyObservers(Notification $note);
		function registerObserver($ype,$callback,$observer = null);
		function removeObserver($type,$callback,$observer = null);
	}
	
?>