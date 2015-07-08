package com.spice.clove.plugin.rss.cue
{
	import com.spice.utils.queue.cue.StateCue;
	import com.spice.utils.queue.cue.URLCue;
	
	import flash.events.Event;
	import flash.net.URLRequest;

	public class LoadRSSCue extends StateCue
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var feed:String;
		public var callback:Function;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function LoadRSSCue(feed:String,onComplete:Function)
		{
			this.feed = feed;
			this.callback = onComplete;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		
		
		override public function init() : void
		{
			new URLCue(new URLRequest(this.feed),onComplete,10000).init();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		private function onComplete(event:Event):void
		{
			this.callback(event);
			
			this.complete();
		}
	}
}