package com.spice.clove.plugin.twitter.column.control
{
	import com.architectd.twitter.calls.timeline.MentionsCall;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.control.IPluginController;
	
	public class TwitterMentionsColumnController extends TwitterUserBasedColumnController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function TwitterMentionsColumnController(controller:IPluginController = null)
		{
			super(controller);
			
			this.title = "Mentions";
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
		
		override protected function loadContent(maxID:Number = NaN):void
		{
			
			this.call(new MentionsCall(15,0,NaN,maxID),this.onSearch);
		}
		
		
		

	}
}