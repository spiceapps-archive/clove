package com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler
{
	import com.spice.clove.sceneSync.core.service.data.SceneSubscriptionData;
	
	public class CloveSceneSubscriptionDataHandler extends CloveDataHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CloveSceneSubscriptionDataHandler()
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
			var subs:Array = [];
			
			for each(var sub:XML in data.subscription)
			{
				subs.push( SceneSubscriptionData.fromXML(sub));
			}
			
			
			return subs;
		}

	}
}