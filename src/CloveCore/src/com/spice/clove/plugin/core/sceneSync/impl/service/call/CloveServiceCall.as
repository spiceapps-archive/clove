package com.spice.clove.plugin.core.sceneSync.impl.service.call
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveService;
	import com.architectd.service.IRemoteService;
	import com.architectd.service.calls.ServiceCall;
	import com.architectd.service.loaders.ServiceLoader;
	import com.architectd.service.loaders.TextLoader;
	import com.architectd.service.responseHandlers.IResponseHandler;
	
	public class CloveServiceCall extends ServiceCall
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
		protected var _cloveService:CloveService;
        
        //--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable]	
        [Setting]
        public var screen_id:Number;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveServiceCall(url:String,responseHandler:IResponseHandler,requestMethod:String = 'get',loader:ServiceLoader = null)
		{
			super(url,loader || new TextLoader(),responseHandler,requestMethod);
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
			
			this._cloveService = CloveService(value);
			
			//this._request.authenticationType = "Digest";
			this._request.setBasicAuthCredentials(this._cloveService.settings.getUsername().getData(),this._cloveService.settings.getPassword().getData());
			
			if(this._cloveService.settings.getScreen())
			{
				this.screen_id = this._cloveService.settings.getScreen().id;
			}
			
		}
		
		

	}
}