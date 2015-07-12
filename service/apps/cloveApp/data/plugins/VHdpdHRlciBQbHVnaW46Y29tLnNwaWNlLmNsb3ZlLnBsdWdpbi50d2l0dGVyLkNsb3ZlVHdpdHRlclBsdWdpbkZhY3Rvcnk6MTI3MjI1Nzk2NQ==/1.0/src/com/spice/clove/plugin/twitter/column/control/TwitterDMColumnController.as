package com.spice.clove.plugin.twitter.column.control
{
	import com.architectd.twitter.calls.dm.GetDirectMessageCall;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.control.IPluginController;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class TwitterDMColumnController extends TwitterUserBasedColumnController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function TwitterDMColumnController(controller:IPluginController = null)
		{
			super(controller);
			
			
			this.title = "Direct Messages";
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		override protected function onColumnStartLoad(event:CloveColumnEvent):void
		{
			super.onColumnStartLoad(event);
			
			
			if(!_twitter)
				return;
			
			
			this.loadContent();
		}
		
		/*
		 */
		
		override protected function loadContent(maxID:Number=NaN) : void
		{
			
			this.call(new GetDirectMessageCall(150,0,NaN,maxID),onSearch);
		}

	}
}