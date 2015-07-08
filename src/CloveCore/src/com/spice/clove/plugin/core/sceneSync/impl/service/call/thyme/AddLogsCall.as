package com.spice.clove.plugin.core.sceneSync.impl.service.call.thyme
{
	import com.adobe.serialization.json.JSON;
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveDataHandler;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;

	public class AddLogsCall extends CloveServiceCall
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		[Bindable] 
		[Setting]
		public var logs:String;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AddLogsCall(lg:Array)
		{
			this.logs = escape(JSON.encode(lg));
			   
			super(CloveUrls.THYME_ADD_LOGS_URL,new CloveDataHandler(false),URLRequestMethod.POST);
		}
	}
}