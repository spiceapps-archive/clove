package com.spice.clove.core.storage
{
	import com.spice.utils.storage.ChildSettings;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.utils.storage.persistent.SettingManager;
	
	import flash.system.Capabilities;
	
	
	public class UISettings
	{
		
		
		[Setting]
		public var dockVisible:Boolean = true;
		
		//for rows
		[Setting(min=0,max=200)]
		public var iconSize:int = 50;
		
		[Setting(min=9,max=72)]
		public var fontSize:int = 14;
		
		
		[Setting(min=0,max=32)]
		public var headerFontSize:int = 12;
		
		
		[Setting(min=0,max=300)]
		public var rowPadding:int = 8;
		
		
		[Setting(min=0,max=30)]
		public var rowGap:int  = 8;
		
		
		[Setting]
		public var showGroupLabels:Boolean = true;
		
		
		
		[Setting]
		public var mainWindowWidth:int = Capabilities.screenResolutionX;
		
		
		
		[Setting]
		public var mainWindowHeight:int = Capabilities.screenResolutionY;
		
		
		[Setting]
		public var mainWindowX:int = 0;
		
		
		[Setting]
		public var mainWindowY:int = 0;
		
		
		
		
		 
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function UISettings(s:INotifiableSettings = null,name:String = "")
		{
			
			new SettingManager(new ChildSettings(s,"UISettings"),this);
		}
		
		
		
	}
}