<?php
	require_once dirname(__FILE__) ."/../exceptions/SingletonException.class.php";
	
	class Singleton
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private static $_instances;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function __construct()
		{
			
			$className =  get_class($this);
					
			
			//if the singleton exists, then throw an exception
			if(self::hasSingleton($className))
			{
				throw new SingletonException("Only one instance of $className can be instantiated.");
			}
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public static function getInstance($className)
		{
			
			//if the singleton does not exist, then create one
			if(!self::hasSingleton($className))
			{
				
				self::$_instances[$className] = new $className();
			}
			
			//return the singleton
			return self::$_instances[$className];
		}
		
		
		/**
		 */
		
		public static function hasSingleton($className)
		{
			self::init();
			
			return array_key_exists($className,self::$_instances);
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * initializes the singleton instances
       	 */
		
		private static function init()
		{
			if(!self::$_instances)
			{
				self::$_instances = array();
			}
		}
	}
	
	
	
	
	
	$sin = Singleton::getInstance('Singleton');
	
	
	
	
?>