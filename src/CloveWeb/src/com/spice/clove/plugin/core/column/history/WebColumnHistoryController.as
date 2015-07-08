package com.spice.clove.plugin.core.column.history
{
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.ColumnHistoryController;
	import com.spice.clove.plugin.column.IColumnHistory;
	
	public class WebColumnHistoryController extends ColumnHistoryController
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function WebColumnHistoryController()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function getHistManager(target:ClovePluginColumn):IColumnHistory
		{
			return new WebColumnHistory(target);
		}

	}
}