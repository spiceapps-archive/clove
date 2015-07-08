package com.spice.clove.plugin.core.sceneSync.impl.service.call.sync
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveDataHandler;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveSyncDataHandler;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	public class CloveSyncShareCall extends CloveServiceCall
	{
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		public function CloveSyncShareCall(data:ByteArray)
		{
			
			super(CloveUrls.SYNC_SHARE_URL,new CloveSyncDataHandler(0), URLRequestMethod.POST);
			
			this.request.contentType = "application/octet-stream";
			this.request.data = data;
		}
		
	}
}