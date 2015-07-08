package com.spice.clove.plugin.core.urlShortener.impl.shorteners
{
	import com.adobe.serialization.json.JSON;
	import com.spice.clove.urlExpander.core.CallUrlExpanderType;
	import com.spice.clove.urlExpander.core.data.AddExpandedUrlData;
	import com.spice.clove.urlShortener.core.IUrlShortener;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class BitlyUrlShortenerCue extends AbstractCue
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const API_KEY:String = "R_221e759a54ff4345985f576dbc3bd988";
		public static const API_LOGIN:String = "architectd";
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _longUrl:String;
		private var _mediator:IProxyMediator;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function BitlyUrlShortenerCue(url:String,mediator:IProxyMediator)
		{
			this._longUrl = url;
			this._mediator = mediator;
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
			super.initialize();
			
			
			var request:URLRequest = new URLRequest("http://api.bit.ly/v3/shorten");
			var vars:URLVariables = new URLVariables();
			vars.longUrl = this._longUrl;
			vars.apiKey = API_KEY;
			vars.login = API_LOGIN;
			vars.format = "json";
			request.data = vars;
			
			request.method = URLRequestMethod.GET;
			
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE,onUrlShortened);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		private function onUrlShortened(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onUrlShortened);
			
			
			var url:String = JSON.decode(event.target.data).data.url;
			
			
			ProxyCallUtils.quickCall(CallUrlExpanderType.SET_EXPANDED_URL,
									 this._mediator,
									 new AddExpandedUrlData(this._longUrl,url));
			
			this.complete(url);
		}
	}
}