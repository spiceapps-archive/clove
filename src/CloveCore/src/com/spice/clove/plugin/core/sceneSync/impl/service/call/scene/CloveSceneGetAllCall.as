package com.spice.clove.plugin.core.sceneSync.impl.service.call.scene
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveSceneDataHandler;
	import com.architectd.service.IRemoteService;
	
	public class CloveSceneGetAllCall extends CloveServiceCall
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable]	
        [Setting]
        public var email:String;
		
		
		[Bindable] 
		[Setting]
		public var user_id:Number;
		
		[Bindable] 
		[Setting]
		public var username:String;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveSceneGetAllCall(email:String = null,userId:Number = NaN,username:String = null)
		{
			super( CloveUrls.SCENE_GET_ALL_URL,new CloveSceneDataHandler());
			
			this.email = email;
			this.user_id = userId;
			this.username = username;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		override public function set service(value:IRemoteService):void
		{
			super.service = value;
			
			
			if(this.username || this.email || !isNaN(this.user_id))
				return;
			
			
			this.email = this._cloveService.settings.getUsername().getData();
			
		}

	}
}