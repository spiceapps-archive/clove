package com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler
{
	import com.spice.clove.sceneSync.core.service.data.ScreenData;
	
	public class CloveScreenDataHandler extends CloveDataHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveScreenDataHandler()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		override protected function getData(data:*):Object
		{
			var screen:XMLList = data.screen;
			
			return ScreenData.fromXML(screen);
		}

	}
}