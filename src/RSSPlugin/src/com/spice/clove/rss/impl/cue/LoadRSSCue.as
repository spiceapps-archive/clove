package com.spice.clove.rss.impl.cue
{
	import com.spice.impl.queue.AbstractCue;
	import com.spice.impl.queue.ImpatientCue;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class LoadRSSCue extends ImpatientCue
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _callback:Function;
		private var _feed:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**  
		 */
		
		public function LoadRSSCue(feed:String,callback:Function)
		{
			super(8000);//8 seconds
			
			_feed = feed;
			_callback = callback;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get feed():String
		{
			return this._feed;
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
			
			var loader:URLLoader = new URLLoader(new URLRequest(this._feed));
			loader.addEventListener(Event.COMPLETE,onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onComplete(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onComplete);
			
			this._callback(this,event);
			
			this.complete();
		}
		
		/**
		 */
		
		private function onIOError(event:Event):void
		{
			this._callback(this,event);
				this.complete();
		}
	}
}