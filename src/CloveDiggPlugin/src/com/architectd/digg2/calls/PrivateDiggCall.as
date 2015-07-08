package com.architectd.digg2.calls
{
	import com.architectd.digg2.data.handle.IResponseHandler;
	import com.yahoo.oauth.OAuthConsumer;
	import com.yahoo.oauth.OAuthRequest;
	import com.yahoo.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import com.yahoo.oauth.OAuthToken;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	/*import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;*/

	
	public class PrivateDiggCall extends DiggCall implements IPrivateDiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _dumpQueueOnFail:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function PrivateDiggCall(method:String,params:Object = null,handler:IResponseHandler = null,dumpQueueOnFail:Boolean = true,loginOnFail:Boolean = true)
		{
			super(method,params,handler,URLRequestMethod.POST,dumpQueueOnFail,loginOnFail);
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function init() : void
		{
			var oac:OAuthConsumer = this.service.consumer;
			var tok:OAuthToken    = this.token;
			
			
			
			//build the request
			var oar:OAuthRequest = new OAuthRequest(URLRequestMethod.POST,DiggCall.ENDPOINT,this.getAllParams(),oac,tok);
			
			
			//set the headers
			var header:URLRequestHeader = oar.buildRequest(new OAuthSignatureMethod_HMAC_SHA1(),OAuthRequest.OAUTH_REQUEST_TYPE_HEADER,DiggCall.HOST);
			
			var req:URLRequest = super.getUrlRequest();
			req.requestHeaders = [header];
			
			
			//load the content
			req.manageCookies = false;
			var loader:URLLoader = new URLLoader(req);
			
			loader.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			loader.addEventListener(Event.COMPLETE,onComplete);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function get token():OAuthToken
		{
			return this.service.settings.accessToken;
		}
		
		/**
		 */
		
		override protected function getRequestParams() : Object
		{
			var p:Object = super.getRequestParams();
			
			var p2:Object = {};
			
			for(var i:String in p)
			{
				if(p[i] && i.indexOf("oauth") != 0)
				{
					p2[i] = p[i];
				}
			}
			
			return p2;
		}
		
		
		
		/**
		 */
		
		protected function getAllParams():Object
		{
			return super.getRequestParams();
		}
		
		
		/**
		 */
		
		protected function onComplete(event:Event):void
		{
			Logger.log("onComplete",this);
			this.completeCall(event.target.data);
		}
	}
}