package com.spice.clove.plugin.core.sceneSync.impl.service.call.screen
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveService;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.sceneSync.core.service.data.ScreenData;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveScreenDataHandler;
	import com.architectd.service.events.ServiceEvent;
	
	public class CloveScreenNewCall extends CloveServiceCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveScreenNewCall()
		{
			super(CloveUrls.SCREEN_NEW_URL,new CloveScreenDataHandler());
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		override protected function onResult(event:ServiceEvent):void
		{
			super.onResult(event);
			
			if(event.success)
			{
				CloveService(service).settings.setScreen(ScreenData(event.data));
			}
		}
		
		
	}
}