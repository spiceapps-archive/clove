package com.spice.launcher.models
{
	import flash.display.Loader;
	
	public class CloveLauncherModelLocator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private static var _instance:CloveLauncherModelLocator;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CloveLauncherModelLocator()
		{
			if(_instance)
			{
				throw new Error("Only one instanceof CloveLauncherModelLocator can be instantiated.");
			}
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public static function getInstance():CloveLauncherModelLocator
		{
			if(!_instance)
			{
				_instance = new CloveLauncherModelLocator();
			}
			
			return _instance;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var airSWF:*;

	}
}