package com.spice.clove.events.plugin
{
	import com.spice.clove.plugin.column.ColumnSaveType;
	
	import flash.events.Event;
	
	import mx.controls.Alert;
	
	public class FillColumnEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		
		public static const FILL_COLUMN:String = "fillColumn";

        public var saveType:int;
        public var data:*;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function FillColumnEvent(data:*,saveType:int = ColumnSaveType.FILL_NEW)
		{
			
			super(FILL_COLUMN);
			
			
			this.data     = data;
			this.saveType = saveType;
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
			return new FillColumnEvent(data,saveType);
		}

	}
}