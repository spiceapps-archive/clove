package com.spice.clove.plugin.twitter.column.control.sub
{
	import com.architectd.twitter.calls.status.GetConversationCall;
	import com.architectd.twitter.events.TwitterEvent;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.twitter.column.control.TwitterUserBasedColumnController;
	import com.spice.clove.plugin.twitter.column.control.render.TwitterRowItemRenderer;
	
	public class TwitterConversationController extends TwitterUserBasedColumnController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable] 
        [Setting]
        public var inReplyTo:Number;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function TwitterConversationController(inReplyTo:Number = NaN)
		{
			super(null,new TwitterRowItemRenderer(false));
			
			this.inReplyTo = inReplyTo;
			
			this.title = "Conversation";
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
			this.call(new GetConversationCall(this.inReplyTo.toString()),onConversation);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onConversation(event:TwitterEvent):void
		{
			this.fillColumn(event.result.response);
		}
		

	}
}