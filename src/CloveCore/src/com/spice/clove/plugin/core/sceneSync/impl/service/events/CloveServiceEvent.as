package com.spice.clove.plugin.core.sceneSync.impl.service.events
{
	import com.architectd.service.events.ServiceEvent;
	import com.spice.clove.sceneSync.core.service.data.CloveStatusCode;
	
	import flash.events.Event;
	
	public class CloveServiceEvent extends ServiceEvent
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public static const RESULT:String = "result";
		public static const NEW_SYNC:String = "newSync";
		public static const NEW_SUBSCRIPTION_SYNC:String = "newSubscriptionSync";
		public static const GET_ALL_SCENES:String = "getAllScenes";
		public static const ERROR:String = "error";
		public static const FATAL_ERROR:String = "fatalError";
		public static const GET_UNSUBSCRIBED_SCENE_DATA:String = "getUnsubscribedSceeData";
		public static const SCENE_CHANGED:String = "sceneChanged";
		public static const SCENE_CREATED:String = "sceneCreated";
		public static const SCENE_SWITCHED:String = "sceneSwitched";
		public static const ADDED_FAVORITE:String = "addedFavorite";
		public static const GET_AVAILABLE_FAVORITE_CATEGORIES:String = "getAvailableFavoriteCategories";
        public var statusCode:int;
        public var message:String;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveServiceEvent(type:String,statusCode:int = 1,message:String = "",data:Object = null)
		{
			super(type,statusCode == CloveStatusCode.SUCCESS,data);
			this.statusCode = statusCode;
			this.message    = message;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function clone():Event
		{
			return new CloveServiceEvent(type,statusCode,message,data);
		}

	}
}