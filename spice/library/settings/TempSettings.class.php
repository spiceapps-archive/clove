<?php
	
	require_once dirname(__FILE__)."/INotifiableSettings.interface.php";
	require_once dirname(__FILE__)."/NotifiableSettings.class.php";
	
	
	class TempSettings extends NotifiableSettings implements INotifiableSettings
	{
	
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        private $_settings;
        private $_id;
        
        //--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function __construct($id = null)
		{
			$this->_id = $id;
			$this->_settings = array();
			
			parent::__construct();
		}
	
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function toObject()
		{
			return $this->_settings;
		}
        /**
		 */
		
		public function getId()
		{
			return $this->_id;
		}
        /**
		 */
		
		
		public function saveSetting($name,$value)
		{
			$this->_settings[$name] = $value;
			
			
			parent::saveSetting($name,$value);
		}
		
		/**
		 */
		
		public function getSetting($name)
		{
			return $this->_settings[$name];
		}
		
		/**
		 */
		
		
		public function removeSetting($name)
		{
			$value = $this->getSetting($name);
			
			unset($this->_settings[$name]);
			
			parent::removeSetting($name);
			
			return $value;
		}
		
		/**
		 */
		
		public function hasSetting($name)
		{
			return array_key_exists($name,$this->_settings);
		}
		
	}


?>