package com.spice.clove.plugin.core.sceneSync.impl.service.call.scene
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveSceneDataHandler;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveScreenDataHandler;
	import com.architectd.service.IRemoteService;
	
	import flash.net.URLRequestMethod;
	
	public class CloveSceneNewCall extends CloveServiceCall
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable]	
        [Setting]
        public var name:String;
        
        [Bindable]	
        [Setting]
        public var description:String;
        
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveSceneNewCall(name:String,description:String)
		{
			this.name = name;
			this.description = description;
			
			
			super(CloveUrls.SCENE_NEW_URL,new CloveSceneDataHandler(), URLRequestMethod.GET);
		
		}
		
		
	}
}