package com.spice.clove.plugin.twitter.cue
{
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.twitter.column.attachments.TwitterConversationAttachment;
	import com.spice.clove.plugin.twitter.conversation.ConversationTracker;
	import com.spice.display.controls.list.ImpatientCue;
	
	import mx.rpc.IResponder;
	
	public class ConversationTrackNumCue extends ImpatientCue implements IResponder
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _data:RenderedColumnData;
		private var _tracker:ConversationTracker;
		
		private const WAIT_TIME:Number = 2000;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ConversationTrackNumCue(data:RenderedColumnData)
		{
			super(WAIT_TIME);
			
			_data = data;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
		
		/*
		 */
		
		public function result(data:Object):void
		{
			var length:int = int(data);
			
			//1 comment is the comment
//				_data.addAttachment(new TwitterConversationAttachment(length));
			if(length > 1)
			{
				
				_data.addAttachment(new TwitterConversationAttachment(length));

			}
			
			
			
			this.complete();
		}
		
		/*
		 */
		
		public function fault(data:Object):void
		{
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------

		/*
		 */
		
		override protected function init2():void
		{
			if(this._data.hasAttachmentType(TwitterConversationAttachment))
			{
				this.complete();
				return;
			}	
			Logger.log("Tracking twitter conversation");
			
			_tracker = new ConversationTracker(this);
			_tracker.getConversationLength(_data.rowuid);
		}
		

	}
}