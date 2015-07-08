package com.spice.clove.plugin.core.sceneSync.impl.service.call.scene
{
	import com.architectd.service.IRemoteService;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveSceneDataHandler;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveScreenDataHandler;
	
	import flash.net.URLRequestMethod;
	
	public class CloveSceneUpdateCall extends CloveServiceCall
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
		
		[Bindable] 
		[Setting]
		public var scene_id:int;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		public function CloveSceneUpdateCall(scene_id:int,name:String,description:String = null)
		{
			this.name = name;
			this.description = description;
			this.scene_id = scene_id;
			
			
			super(CloveUrls.SCENE_SYNC_UPDATE_URL,new CloveSceneDataHandler(), URLRequestMethod.GET);
			
		}
		
		
	}
}