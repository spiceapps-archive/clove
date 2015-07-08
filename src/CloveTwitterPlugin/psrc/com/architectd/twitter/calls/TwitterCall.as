package com.architectd.twitter.calls
{
	import com.architectd.twitter.Twitter;
	import com.architectd.twitter.data.TwitterResult;
	import com.architectd.twitter.dataHandle.IDataHandler;
	import com.architectd.twitter.events.TwitterEvent;
	import com.spice.display.controls.list.ImpatientCue;
	import com.spice.utils.SystemUtil;
	import com.spice.utils.queue.cue.CueStateType;
	import com.swfjunkie.tweetr.utils.Base64Encoder;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	[Event(name="callComplete",type="com.architectd.twitter.events.TwitterEvent")]
	
	
	public class TwitterCall extends ImpatientCue implements ITwitterCall
	{
		
		new ImpatientCue
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _data:*;
		private var _url:String;
		private var _params:Object;
		private var _dataHandler:IDataHandler;
		private var _user:String;
		private var _pass:String;
		private var _authenticate:Boolean;
		private var _requestMethod:String;
		private var _connection:Twitter;
		
		
		private var _callResponseCode:int;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterCall(url:String,
									dataHandler:IDataHandler,
									params:Object = null,
									authenticate:Boolean = true,
									httpMethod:String = URLRequestMethod.GET/* ,
									maxTime:int = -1 */)
		{
			super(-1);//4 seconds
			url = url.replace("http://","");
			
			_requestMethod = httpMethod;
			_dataHandler = dataHandler;
			_params	   = params ? params : {};
			_authenticate = authenticate;
			_url = url;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function get url():String
		{
			return this._url;
		}
		
		/**
		 */
		
		public function set url(value:String):void
		{
			this._url = value;
		}
		
		/**
		 */
		
		public function get data():*
		{
			return _data;
		}
		
		
		/**
		 */
		
		public function get connection():Twitter
		{
			return _connection;
		}
		
		/**
		 */
		
		public function set connection(value:Twitter):void
		{
			this._connection = value;
		}
		
		/**
		 */
		
		public function get dataHandler():IDataHandler
		{
			return this._dataHandler;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		public function setCredentials(user:String,pass:String):void
		{
			_user = user;
			_pass = pass;
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override protected function init2():void
		{
			this.state = CueStateType.LOADING;
			
			this.dispatchEvent(new TwitterEvent(TwitterEvent.CALLING));
			
			
			this.loadData(this.getRequestUrl(this._url));
		}
		/**
		 */
		
		protected function loadData(url:URLRequest):void
		{
			
			Logger.log("calling "+url.url,this);
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onDataLoad);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			
			#if PLATFORM == AIR_PLATFORM
			loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,onHTTPResponseStatus);
			url.cacheResponse = false;
			//url.manageCookies = false;
			url.useCache = false;
			url.authenticate = false;
			#endif
			
			
			loader.load(url);
		}
		
		
		/**
		 */
		
		protected function onDataLoad(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onDataLoad);
			
			Logger.log("onDataLoad",this);
			
			
			
			this.setData(event.target.data);
		}
		
		/**
		 */
		
		protected function onHTTPResponseStatus(event:HTTPStatusEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onHTTPResponseStatus);	
			
			this._callResponseCode = event.status;
			
			Logger.log("onHTTPResponseStatus="+event.status,this);
			
		}
		
		/**
		 */
		
		protected function onIOError(event:IOErrorEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onIOError);
			
			
			
			Logger.log("onIOError e="+(SystemUtil.runningAIR ? event["errorID"] : event.text),this);
			
			var result:TwitterResult = new TwitterResult(event.text,this._callResponseCode);
			
			this.dispatchComplete(result);
			
			this.complete(result.success ? CueStateType.COMPLETE : CueStateType.ERROR);
		}
		
		/**
		 */
		
		protected function onSecurityError(event:SecurityErrorEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onSecurityError);
			
			Logger.log("onSecurityError",false);
		}
		
		/**
		 */
		
		protected function getData(data:*):*
		{
			if(this._dataHandler)
				this._data = this._dataHandler.getResponseData(data);
			
			return this._data;
		}
		
		/**
		 */
		
		protected function setData(data:*):void
		{
			var rdata:* = this.getData(data);
			
			var result:TwitterResult = new TwitterResult(rdata,this._callResponseCode);
			
			this.dispatchComplete(result);
			
			
			this.complete(result.success ? CueStateType.COMPLETE : CueStateType.ERROR);
		}
		
		/**
		 */
		
		private function getRequestUrl(url:String):URLRequest
		{
			
//			url = this.applyParams(url,this._params);
			
			var req:URLRequest = new URLRequest();
			
			
			var vars:URLVariables = new URLVariables();
			
			for(var i:String in this._params)
			{
				if(_params[i])
				{
					vars[i] = _params[i];
				}
			}
			
			req.method = this._requestMethod;
			req.data   = vars;
			
			
			

			req.requestHeaders.push(new URLRequestHeader("pragma", "no-cache"));
			req.requestHeaders.push(new URLRequestHeader("Expires", "Thu, 01 Jan 1970 00:00:00 GMT, -1"));
			req.requestHeaders.push(new URLRequestHeader("Cache-Control", "no-cache, no-store, must-revalidate"));
			
			
			if(!_user && !_pass)
			{
				req.url = "http://"+url;
			}
			else 
			if(this._authenticate)
			{
				
				var base64:Base64Encoder = new Base64Encoder();
				base64.encode(_user+":"+_pass);
				
				
				
				req.requestHeaders.push(new URLRequestHeader("authorization", "Basic "+base64.toString()));
				
				req.url = "http://"+url;
				
				
				
			}
			else
			{
				req.url = "http://"+_user+":"+_pass+"@"+url;
				
			}
		
			
			return req;
			
		}
		
		
		
		/**
		 */
		
		protected function dispatchComplete(result:TwitterResult):void
		{
			
			this.dispatchEvent(new TwitterEvent(TwitterEvent.CALL_COMPLETE,result));
		}
		
		/**
		 */
		
		protected function applyParams(url:String,params:Object):String
		{
			var p:Array = [];
			
			for(var i:String in params)
			{
				if(params[i])
					p.push(i+"="+params[i]);
			}
			
			return url+(p.length > 0 ? "?"+p.join("&") : "");
		}
	}
}