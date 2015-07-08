package com.spice.clove.plugin.twitter.column.control
{
	import com.architectd.twitter.calls.timeline.FriendsTimelineCall;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.control.IPluginController;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class TwitterUserTimelineColumnController extends TwitterUserBasedColumnController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitterUserTimelineColumnController(controller:IPluginController = null)
		{
			super(controller);
			
			this.title = "Timeline";
			
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
			
			
			if(!_twitter)
				return;
			
			this.loadContent();
		}
		
		
		/**
		 */
		
		override protected function loadContent(maxID:Number=NaN) : void
		{
			
			this.call(new FriendsTimelineCall(15,0,NaN,maxID),onSearch);
		}
		
		
		
	}
}