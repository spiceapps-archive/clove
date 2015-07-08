package com.spice.clove.events
{
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	
	import flash.events.Event;
	
	public class ColumnMetaDataEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
        
        public var dataValue:Object;  
        public var targetColumn:CloveColumn;
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ColumnMetaDataEvent(type:String,dataValue:Object,targetCol:CloveColumn)
		{
			super(type,true);
			
			this.dataValue 	  = dataValue;
			this.targetColumn = targetCol;
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public static function DATA_CHANGE(name:String):String
		{
			return "dataChange"+name;
		}
		
		
		/*
		 */
		
		override public function clone():Event
		{
			return new ColumnMetaDataEvent(type,dataValue,this.targetColumn);
		}

	}
}