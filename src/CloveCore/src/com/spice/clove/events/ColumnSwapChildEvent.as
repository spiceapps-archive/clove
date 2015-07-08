package com.spice.clove.events
{
	import com.spice.clove.plugin.column.ClovePluginColumn;
	
	import flash.events.Event;
	
	public class ColumnSwapChildEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const SWAP_CHILD:String = "swapChild";
        public var child1:ClovePluginColumn;
        public var child2:ClovePluginColumn;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ColumnSwapChildEvent(type:String,child1:ClovePluginColumn,child2:ClovePluginColumn)
		{
			super(type,true);
			this.child1 = child1;
			this.child2 = child2;
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
			return new ColumnSwapChildEvent(type,child1,child2);
		}

	}
}