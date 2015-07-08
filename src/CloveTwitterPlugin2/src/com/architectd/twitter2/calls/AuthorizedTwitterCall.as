package com.architectd.twitter2.calls
{
	import com.architectd.service.oauth.OAuthServiceCue;
	import com.architectd.twitter2.TwitterUrls;
	import com.spice.impl.service.IRemoteServiceResponseHandler;
	import com.spice.impl.service.RemoteServiceLoadCue;
	import com.spice.impl.service.RemoteServiceRequest;
	import com.spice.impl.service.loaders.TextLoader;
	
	import flash.net.URLRequestMethod;
	
	import org.iotashan.utils.URLEncoding;
	
	public class AuthorizedTwitterCall extends RemoteServiceLoadCue
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _oauthService:OAuthServiceCue;
		protected var _baseUrl:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AuthorizedTwitterCall(url:String,
											  oauthService:OAuthServiceCue,
											  responseHandler:IRemoteServiceResponseHandler,
											  params:Object,
											  requestMethod:String = URLRequestMethod.GET)
		{
			super(new RemoteServiceRequest(url,params,responseHandler,requestMethod),new TextLoader());
			_baseUrl = url;
			this._oauthService = oauthService;
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function initialize():void
		{
			
			var request:RemoteServiceRequest = super.getRequest();
			
			var params:Object = request.getUsableParams();
			
			var oauthUrl:String = this._oauthService.getRequestUrl(_baseUrl,params,request.getMethod());
				
			//adds more params, so we need to refresh it
			params = request.getUsableParams();
			
			if(request.getMethod() != URLRequestMethod.GET)
			{
				for(var i:String in params)
				{
					oauthUrl = oauthUrl.replace(new RegExp("[&?]"+i+"=[^&]+","is"),"");
				}
				
				if(oauthUrl.indexOf("?") == -1)
					oauthUrl = oauthUrl.replace(/\&(\w+)=/is,"?$1=");
				
				
			}
			else
			{
				request.setParams({});
			}
			
			request.setUrl(oauthUrl);
			
				
			super.initialize();
		}
	}
}