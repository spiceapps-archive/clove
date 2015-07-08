package com.spice.clove.commandEvents
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	public class CloveEvent extends CairngormEvent
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

        /*
          adds a column to a group 
         */        
        public static const ADD_COLUMN:String  = "addColumn";
        
        
        
        /*
          adds a column to a group 
         */        
        public static const ADD_GROUP:String  = "addGroupColumn";
        
        /*
          adds a core plugin to Clove. NOTE: the installed plugin data will not appear on Clove.settings 
         */        
        public static const ADD_CORE_PLUGIN:String = "addCorePlugin";
        
        /*
          adds a postable to the current post window
         */        
         
        public static const ADD_ACTIVE_POSTABLE:String = "addActivePostable";
        
        /*
          adds a plugin object in ClovePluginList. this happens immediately 
         */        
         
//        public static const ADD_PLUGIN:String = "addPlugin";
        
        /*
          called on APP init, plugins are thrown in a queue
         */
         
        public static const LOAD_PLUGIN:String = "loadPlugin";
        
        
        /*
          copies text to the current post window 
         */        
         
        public static const COPY_TO_POSTER:String = "copyText";
        
        
		public static const DISPLAY_ERROR_MESSAGE:String = "displayErrorMessage";
        
        
        /*
          removes a clove column 
         */        
         
        public static const REMOVE_COLUMN:String = "removeColumn";
        
        /*
          minimizes a column  
         */        
         
//        public static const MINIMIZE_COLUMN:String = "minimizeColumn";
        
        
       	public static const OPEN_PREFERENCES:String  = "openPreferences";
       	
       	
		/*
		  loads a minimized column 
		 */       	
		 
		public static const LOAD_MINIMIZED:String	 = "loadMinimized";
		
		/*
		  initializes Clove. This can only be called once 
		 */		
		 
		public static const INITIALIZE:String		 = "initialize";
		
		/*
		  check for updates 
		 */		
		 
		public static const CHECK_UPDATE:String		 = "checkUpdate";
		
        
		
		//public static const LOAD_COLUMNS:String		 = "loadColumns";
        /*
          uninstalls a plugin 
         */        
		public static const UNINSTALL_PLUGIN:String = "uninstall";
		public static const UNINSTALL_PLUGIN_COMPLETELY:String = "uninstallCompletely";
        
        /*
          installs a plugin 
         */        
         
        public static const INSTALL_PLUGIN:String   = "installPlugin";
        public static const INSTALL_PLUGIN_WITH_CONFIRM:String   = "installPluginWithConfirm";
        public static const DOWNLOAD_PLUGIN:String			     = "downloadPlugin";
        
        
        
        public static const SET_MAIN_HEADER_VIEW:String = "setMainHeaderView";
        public static const ADD_HEADER_VIEW:String = "addHeaderView";
        public static const ADD_FOOTER_VIEW:String = "addFooterView";
        
		
		
		public static const ADD_POSTER_ACTION:String = "addPosterAction";
		
        
        public var voData:*;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function CloveEvent(type:String,data:Object = null)
		{
			super(type);
			
			
			this.voData = data;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function clone():Event
		{
			return new CloveEvent(type,voData);
		}

	}
}