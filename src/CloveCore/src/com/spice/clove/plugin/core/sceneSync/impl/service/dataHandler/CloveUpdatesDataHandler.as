package com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler
{
	import com.spice.clove.sceneSync.core.service.data.PluginData;
	
	public class CloveUpdatesDataHandler extends CloveDataHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CloveUpdatesDataHandler()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function getData(data:*):Object
		{
			var plugins:Array = [];
			
			for each(var plugin:* in data.plugin)
			{
				plugins.push(PluginData.fromXML(plugin));
			}
			
			return plugins;
		}

	}
}