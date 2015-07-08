package com.architectd.digg.calls
{
	import com.architectd.digg.data.handle.IResponseHandler;
	import com.architectd.digg.events.DiggEvent;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	[Event(name="newData",type="com.architectd.digg.events.DiggEvent")]
	public class DiggCall extends Cue
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const APP_KEY:String = "http://cloveapp.com";
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _params:Object;
		private var _requestUrl:String;
		private var _responseHandler:IResponseHandler;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggCall(requestUrl:String,
								 responseHandler:IResponseHandler,
								 params:Object = null)
		{
			_params	    	 = params ? params : {};
			_requestUrl 	 = requestUrl;
			_responseHandler = responseHandler;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get params():Object
		{
			return _params;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function init():void
		{
			this._params = this.addDefaultParams(_params);
			
			this.loadData(this._requestUrl);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function addDefaultParams(params:Object):Object
		{
			params.appkey = APP_KEY;
			params.type   = "xml";
			
			return params;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		private function loadData(url:String):void
		{
			var req:URLRequest = new URLRequest(url);
			
			var vars:URLVariables = new URLVariables();
			for(var i:String in this._params)
			{
				vars[i] = this._params[i];
			}
			
			req.data = vars;
			req.method = URLRequestMethod.GET;
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onDataLoad);
			loader.load(req);
		}
		
		/**
		 */
		
		private function onDataLoad(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onDataLoad);
			
			var data:* = this._responseHandler.getResult(event.target.data);
			
			
			this.dispatchEvent(new DiggEvent(DiggEvent.NEW_DATA,data));
			
			this.complete();
		}
	}
}