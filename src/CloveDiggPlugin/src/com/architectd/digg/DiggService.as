package com.architectd.digg
{
	import com.architectd.digg.calls.DiggCall;
	import com.spice.utils.queue.QueueManager;

	public class DiggService
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _queue:QueueManager;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DiggService()
		{
			_queue = new QueueManager();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function call(call:DiggCall):DiggCall
		{
			_queue.addCue(call);
			
			return call;
		}
	}
}