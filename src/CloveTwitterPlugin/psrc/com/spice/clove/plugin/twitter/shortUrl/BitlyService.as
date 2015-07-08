package com.spice.clove.plugin.twitter.shortUrl
{
	import com.adobe.serialization.json.JSON;
	import com.spice.clove.plugin.posting.Message;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	public class BitlyService extends ShortUrlService
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		public function BitlyService(url:String,message:Message)
		{
			super(url,message);
		}
		
		
		//http://api.bit.ly/shorten?version=2.0.1&longUrl=http://cnn.com&login=bitlyapidemo&apiKey=R_0da49e0a9118ff35f52f629d2d71bf07
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		
		override protected function init2() : void
		{
			
			
			var vars:URLVariables = new URLVariables();
			vars.version = "2.0.1";
			vars.longUrl = this.url;
			vars.login = "architectd";
			vars.apiKey = "R_221e759a54ff4345985f576dbc3bd988";
			
			var req:URLRequest = new URLRequest("http://api.bit.ly/shorten");
			req.data = vars;
			
			
			var loader:URLLoader = new URLLoader(req);
			loader.addEventListener(Event.COMPLETE,onUrlLoad);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onUrlLoad(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onUrlLoad);
			
			var obj:Object = JSON.decode(event.target.data);
			
			var url:String;
			
			for(var i:String in obj.results)
			{
				
				this.setUrl(obj.results[i].shortUrl);
			}
			
			
		}
	}
}