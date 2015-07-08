package com.spice.clove.plugin.core
{
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.core.column.control.WebRootColumnController;
	import com.spice.clove.plugin.core.column.history.WebColumnHistoryController;
	import com.spice.clove.plugin.core.root.CloveRootPlugin;
	import com.spice.utils.storage.SharedObjectSettings;
	
	public class WebRootPlugin extends CloveRootPlugin
	{
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function WebRootPlugin()
		{
			super(null,null,null);
			//super(new WebRootColumnController(),new WebColumnHistoryController(),new WebRootPluginSettings());
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override public function initialize(controller:IPluginController):void
		{
			super.initialize(controller);
			
//			new SharedObjectSettings
			
			
			
			WebRootPluginSettings(this.settings).testName = "FAST!";
		}
	}
}