package com.architectd.digg2.calls
{
	import com.architectd.digg2.data.handle.IResponseHandler;
	import com.architectd.digg2.events.DiggEvent;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	[Event(name="newData",type="com.architectd.digg2.events.DiggEvent")]
	public class PublicDiggCall extends DiggCall
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function PublicDiggCall(method:String,
									   arguments:Object = null,
								 	   responseHandler:IResponseHandler = null,
									   type:String = URLRequestMethod.GET)
		{
			
			super(method,arguments,responseHandler,type);
			
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
			var req:URLRequest = this.getUrlRequest();
			
			var loader:URLLoader = new URLLoader(req);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			loader.addEventListener(Event.COMPLETE,onDataLoad);
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onDataLoad(event:Event):void
		{
			this.completeCall(event.target.data);
			
		}
		
		
		
	}
}