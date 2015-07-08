package com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler
{
	import com.spice.clove.sceneSync.core.service.data.SceneData;
	
	public class CloveSceneDataHandler extends CloveDataHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveSceneDataHandler()
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
			var response:Array = [];
			
			for each(var scene:XML in data.scene)
			{
				response.push(SceneData.fromXML(scene));
			}
			
			
			return response;
		}

	}
}