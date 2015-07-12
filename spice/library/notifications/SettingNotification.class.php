<?php
	
	require_once dirname(__FILE__)."/Notification.class.php";

	class SettingNotification extends Notification
	{
	
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        const SETTING_CHANGE = "settingChange";
        
        public $value;
        public $setting;
	
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		
		public function __construct($type,$setting,$value)
		{
			parent::__construct($type);
			
			
			$this->setting = $setting;
			$this->value   = $value;
		}
	}
?>