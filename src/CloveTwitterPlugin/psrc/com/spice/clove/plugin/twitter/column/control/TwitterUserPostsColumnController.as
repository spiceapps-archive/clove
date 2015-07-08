package com.spice.clove.plugin.twitter.column.control
{
	import com.architectd.twitter.calls.timeline.UserTimelineCall;
	import com.spice.clove.events.CloveColumnEvent;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class TwitterUserPostsColumnController extends TwitterUserBasedColumnController
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitterUserPostsColumnController()
		{
			this.title = "My Posts";
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function onColumnStartLoad(event:CloveColumnEvent):void
		{
			super.onColumnStartLoad(event);
			
			if(!this._twitter)
				return;
			
			this.loadContent();
		}
		
		/**
		 */
		
		override protected function loadContent(maxID:Number=NaN) : void
		{
			this.call(new UserTimelineCall(this._twitter.username,15,0,NaN,maxID),onSearch);
		}

	}
}