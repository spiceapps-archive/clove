package com.spice.clove.plugin.core.sceneSync.impl.service.call.scene
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveDataHandler;
	
	import flash.net.URLRequestMethod;
	
	public class CloveSceneDeleteCall extends CloveServiceCall
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


       	[Bindable]	
       	[Setting]
       	public var scene_id:Number;
       	
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveSceneDeleteCall(sceneID:Number)
		{
			this.scene_id = sceneID;
			
			
			super(CloveUrls.SCENE_DELETE_URL,new CloveDataHandler(), URLRequestMethod.GET);
		}

	}
}