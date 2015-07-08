package com.spice.clove.events
{
	//import com.spice.clove.plugin.column.ICloveColumn;
	
	import flash.events.Event;
	
	public class CloveColumnEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

        public static const CHANGE:String         = "columnChange";
        public static const CONTROLLER_SET:String = "controllerSet";
		public static const CONTROLLER_CHANGE:String = "controllerChange";
		public static const LOAD_STATE_CHANGE:String = "loadStateChange";
        public static const FOCUS:String   		  = "focus";
        
		
		public static const ADD_DELETE_COL_UID:String = "addDeleteColUID";
		public static const REMOVE_DELETE_COL_UID:String = "removeColUIDSync";
        /*
          outside command for the column to load the data 
         */        
         
        public static const LOAD:String			  = "load";
        
        
        
        //RENDERED DATA INTERACTION
        
        public static const RENDERED_DATA_ICON_CLICK:String			  = "renderedDataIconClick";
		public static const RENDERED_DATA_ROW_DOUBLE_CLICK:String	  = "renderedDataRowDoubleClick";
		
		
		//called once scrolled to the bottom
		public static const LOAD_OLDER_CONTENT:String	  = "loadOlderContent";
        
		public static const DISPLAY_ERROR_MESSAGE:String = "displayErrorMessage";
        
        
        
        
        public var targetColumn:*;
        public var data:*;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function CloveColumnEvent(type:String,
										 targetColumn:* = null,
										 bubble:Boolean = true,
										 data:Object = null)
		{
			
			
			super(type,bubble);
			
			this.targetColumn = targetColumn;
			this.data    = data;
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
			return new CloveColumnEvent(this.type,this.targetColumn,bubbles,this.data);
		}

	}
}