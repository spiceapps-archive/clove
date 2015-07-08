package com.spice.clove.plugin.core.sceneSync.impl.service.call.sync
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveDataHandler;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveSyncDataHandler;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	public class CloveSyncAddCall extends CloveServiceCall
	{
		
        
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveSyncAddCall(scene:Number,screen:Number,data:ByteArray)
		{
			data.compress();
			
			super(CloveUrls.SYNC_NEW_URL+"?scene_id="+scene+"&screen_id="+screen+"&compressed=true",new CloveSyncDataHandler(scene), URLRequestMethod.POST);
			
			this.request.contentType = "application/octet-stream";
			this.request.data = data;
		}
		
	}
}