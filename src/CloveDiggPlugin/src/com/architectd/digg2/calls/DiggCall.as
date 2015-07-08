package com.architectd.digg2.calls
{
	import com.architectd.digg2.DiggService;
	import com.architectd.digg2.data.DiggError;
	import com.architectd.digg2.data.handle.IResponseHandler;
	import com.architectd.digg2.events.DiggEvent;
	import com.spice.utils.queue.cue.CueStateType;
	import com.spice.utils.queue.cue.StateCue;
	
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	[Event(name="newData",type="com.architectd.digg2.events.DiggEvent")]
	[Event(name="error",type="com.architectd.digg2.events.DiggEvent")]
	public class DiggCall extends  StateCue implements IDiggCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _diggService:DiggService;
		private var _responseHandler:IResponseHandler;
		
		private var _data:*;
		private var _loginOnFail:Boolean;
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const ENDPOINT:String = "http://services.digg.com/1.0/endpoint";
		public static const HOST:String = "http://services.digg.com/";
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _params:Object;
		private var _dumpQueueOnFail:Boolean;
		private var _urlRequestMethod:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggCall(method:String,params:Object,responseHandler:IResponseHandler= null,urlRequestMethod:String = URLRequestMethod.GET,dumpQueueOnFail:Boolean = false,loginOnFail:Boolean = false)
		{
			_responseHandler = responseHandler;
			
			_params = params ? params : {};
			
			_params.method = method;
			_loginOnFail = loginOnFail;
			
			_urlRequestMethod = urlRequestMethod;
			this._dumpQueueOnFail = dumpQueueOnFail;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get service():DiggService
		{
			return this._diggService;
		}
		
		/**
		 */
		
		public function set service(value:DiggService):void
		{
			this._diggService = value;
		}
		
		/**
		 */
		
		public function get data():Array
		{
			return _data;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		protected function onIOError(event:IOErrorEvent):void
		{
			var error:XML = new XML(event.target.data);
			
			if(this._dumpQueueOnFail)
				this.fail();
			
			
			var de:DiggError = new DiggError(error.@code,error.@message);
			
			
			//invalid OAuth token
			if(de.errorCode == 5003 && _loginOnFail)
			{
				
				//make sure we break the loop if we fail again, so it's not infinite
				_loginOnFail = false;
				
				this.service.login();
				this.complete(CueStateType.ERROR);
				
				//recall this method
				this.service.call(this);
			}
			
			this.dispatchEvent(new DiggEvent(DiggEvent.ERROR,de));
			
			
			this.complete(CueStateType.ERROR);
			
		}
		
		/**
		 */
		
		protected function getUrlRequest():URLRequest
		{
			var p:Object = this.getRequestParams();
			
			var vars:Array = [];
			
			for(var i:String in p)
			{
				if(p[i])
					vars.push(i+"="+p[i]);				
			}
			
			var req:URLRequest = new URLRequest(DiggCall.ENDPOINT);
			req.method	       = this._urlRequestMethod;
			req.data 		   = vars.join("&");
			req.userAgent 	   = "HTTP_AIR/2.0";
			req.contentType    = "application/x-www-form-urlencoded";
			
			return req;
		}
		/**
		 */
		
		protected function getRequestParams():Object
		{
			return _params;
		}
		
		/**
		 */
		
		protected function setRawData(raw:String):void
		{
			
			if(_responseHandler)
				_data = _responseHandler.getResult(raw);
			
			this.dispatchEvent(new DiggEvent(DiggEvent.NEW_DATA,_data));
			
		}
		
		
		/**
		 */
		
		protected function completeCall(raw:String):void
		{
			this.setRawData(raw);
			
			
			this.complete();
		}
	}
}