package com.spice.clove.plugin.twitter.column.control
{
	import com.architectd.twitter.calls.timeline.PublicTimelineCall;
	import com.spice.clove.events.CloveColumnEvent;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class TwitterPublicTimelineColumnController extends TwitterUserBasedColumnController
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitterPublicTimelineColumnController()
		{
			this.title = "Public Timeline";
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
			
			this.call(new PublicTimelineCall(NaN,maxID),onSearch);
		}
	}
}