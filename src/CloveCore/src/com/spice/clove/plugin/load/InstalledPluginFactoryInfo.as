package com.spice.clove.plugin.load
{
	import com.spice.clove.events.plugin.InstalledPluginEvent;
	
	import flash.events.EventDispatcher;
	
	public class InstalledPluginFactoryInfo extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function InstalledPluginFactoryInfo()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		protected function complete():void
		{
			this.dispatchEvent(new InstalledPluginEvent(InstalledPluginEvent.PLUGIN_LOADED));
		}

	}
}