package com.spice.clove.core.storage
{
	import com.spice.utils.storage.ChildSettings;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.utils.storage.persistent.SettingManager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.styles.StyleManager;
	
	
	/*
	  main UI settings 
	  @author craigcondon
	  
	 */	
	 
	public class ApplicationSettings extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
        
        
        //boolean TRUE when the group is expanded
        [Setting]
		[Bindable] 
        public var groupExpanded:Boolean = true;
        
        [Setting]
		[Bindable] 
        public var refreshRate:int = 10;//10 minutes
        
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ApplicationSettings(mainSettings:INotifiableSettings)
		{
			new SettingManager(new ChildSettings(mainSettings,"ApplicationSettings"),this);
		}

	}
}