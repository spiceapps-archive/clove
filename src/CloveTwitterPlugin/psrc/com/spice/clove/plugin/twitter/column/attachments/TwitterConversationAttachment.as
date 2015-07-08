package com.spice.clove.plugin.twitter.column.attachments
{
	import com.spice.clove.plugin.column.render.link.RenderedColumnDataLinkAttachment;
	import com.spice.clove.plugin.twitter.conversation.ConversationTracker;
	import com.spice.clove.views.icons.attachment.AttachmentIcons;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class TwitterConversationAttachment extends RenderedColumnDataLinkAttachment implements IResponder
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _tracker:ConversationTracker;
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        [Bindable] 
        public var conversation:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitterConversationAttachment(length:int)
		{
			
			//minus THIS RCD
			super("tca","View "+(length-1)+" comments", AttachmentIcons.CONVERSATION);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function get attachmentView():Class
		{
			return RenderedColumnDataCommentAttachmentView;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function select():void
		{
			super.select();
			
			_tracker = _tracker ? _tracker : new ConversationTracker(this);
			_tracker.getConversation(this.data.rowuid);
			
			
		}
		
		
		/**
		 */
		
		public function result(data:Object):void
		{
			this.conversation = data as Array;
			
		}
		
		/**
		 */
		
		public function fault(data:Object):void
		{
			//nothing
		}
		

	}
}