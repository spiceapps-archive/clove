package com.architectd.twitter
{
	import com.architectd.twitter.calls.ITwitterCall;
	import com.spice.utils.queue.QueueManager;

	public class Twitter
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var username:String;
		public var password:String;
		
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
		
		/*
		 */
		
		public function Twitter(user:String = null,pass:String = null)
		{
			this.username = user;
			this.password = pass;
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function call(call:ITwitterCall):ITwitterCall
		{
			if(!_queue)
			{
				_queue = new QueueManager();
			}
			
				
			this.linkCall(call);
			
			
			_queue.addCue(call);
			
			
			
			return call;
		}
		
		
		/*
		 */
		
		public function linkCall(call:ITwitterCall):ITwitterCall
		{
			call.setCredentials(this.username,this.password);
			call.connection = this;
			return call;
		}
		
		
		
		
	}
}