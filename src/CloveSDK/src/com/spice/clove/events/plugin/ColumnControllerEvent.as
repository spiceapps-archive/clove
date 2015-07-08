package com.spice.clove.events.plugin
{
	import flash.events.Event;
	
	public class ColumnControllerEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		
        /*
          the controller settings with [Setting] metadata
         */		
         
        public static const SET_SETTINGS:String 		  = "setSettings";
        
        /*
          sets the item renderer to process the row data 
         */
                 
        public static const SET_ITEM_RENDERER:String 	  = "setItemRenderer";
        
        
        /*
          column data option for handling row rendered data 
         */        
         
//        public static const ADD_COLUMN_DATA_OPTION:String = "addColumnDataOption";
        
        
        public static const ADD_MENU_OPTIONS:String = "addMenuOptions";
        
        /*
          adds a sub controller to the current, turning it into a breadcrumbed column
         */
        
        public static const SET_BREADCRUMB:String = "setBreadcrumb";
        
        
        /*
          focuses on the selected column so that it turns into a breadcrumb 
         */        
        
        public static const FOCUS:String = "focus";
        
        /*
          handles text replacements in messages. these replacements will be saved in the SQLite database
         */        
         
        public static const ADD_CACHED_MESSAGE_HANDLER:String    = "addCachedMessageHandler";
        
        /*
          handles text replacements at runtime 
         */
                 
        public static const ADD_MESSAGE_HANDLER:String    = "addMessageHandler";
		
		
		/*
		  handles the column load state
		 */
	
		public static const SET_LOAD_CUE:String = "setLoadStateCue";
        
        
        /*
          the value object  
         */        
         
        public var value:*;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ColumnControllerEvent(type:String,value:Object)
		{
			super(type);
			
			this.value = value;
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
			return new ColumnControllerEvent(type,value);
		}
		
		

	}
}