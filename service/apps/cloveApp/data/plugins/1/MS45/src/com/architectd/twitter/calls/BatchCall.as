package com.architectd.twitter.calls
{
	import com.spice.events.QueueManagerEvent;
	import com.spice.utils.queue.QueueManager;
	import com.spice.utils.queue.cue.Cue;

	public class BatchCall extends Cue
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _calls:Array;
		private var _queue:QueueManager;
		private var _response:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function BatchCall(...calls:Array)
		{
			_calls = calls;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/*
		 */
		
		public function get response():Array
		{
			return _response;
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
			_queue = new QueueManager();
			_queue.addEventListener(QueueManagerEvent.QUEUE_COMPLETE,onQueueComplete);
			
			for each(var call:Cue in this._calls)
			{
				_queue.addCue(call);
			}
			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
	
		private function onQueueComplete(event:QueueManagerEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onQueueComplete);
			
		}
		
	}
}