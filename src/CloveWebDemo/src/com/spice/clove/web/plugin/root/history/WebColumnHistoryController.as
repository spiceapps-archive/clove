package com.spice.clove.web.plugin.root.history
{
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.ColumnHistoryController;
	import com.spice.clove.plugin.column.IColumnHistory;
	import com.spice.clove.web.plugin.root.WebRootPlugin;
	
	public class WebColumnHistoryController extends ColumnHistoryController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:WebRootPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function WebColumnHistoryController(plugin:WebRootPlugin)
		{
			_plugin = plugin;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		
		override public function getHistManager(target:CloveColumn):IColumnHistory
		{
			return new WebColumnHistory(target,_plugin);
		}

	}
}