package com.spice.clove.plugin.core.sceneSync.impl.service.call.plugins
{
	dynamic public class CloveUpdateInfo
	{
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        
		
		/**
		 */
		
		public static function buildRequest(version:String,name:String = null,uid:String = null,factory:String = null):Object
		{
			var request:Object = {};
			request.currentVersion = version;
			if(name) request.name = name;
			if(uid) request.uid = uid;
			if(factory) request.factory = factory;
			
			return request;
		}

	}
}