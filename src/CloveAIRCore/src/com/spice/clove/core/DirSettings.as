package com.spice.clove.core
{
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.utils.storage.persistent.SettingManager;
	
	import flash.filesystem.File;
	
	
	
	/*
	  contains info about where the core app settings are stored. This is important for synchronizing content. 
	  @author craigcondon
	  
	 */	
	
	[Bindable] 
	public class DirSettings
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		
        [Setting]
        public var appStorageDir:String = File.separator+"Library"+File.separator;
		
		[Setting]
		public var deleteDir:String;
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function DirSettings(settings:INotifiableSettings)
		{
			new SettingManager(settings,this);

		}

	}
}