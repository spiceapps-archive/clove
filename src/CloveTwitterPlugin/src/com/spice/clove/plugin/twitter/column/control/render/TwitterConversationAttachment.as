package com.spice.clove.plugin.twitter.column.control.render
{
	import com.spice.clove.events.plugin.ColumnControllerEvent;
	import com.spice.clove.plugin.column.render.link.RenderedColumnDataLinkAttachment;
	import com.spice.clove.plugin.twitter.column.control.sub.TwitterConversationController;
	import com.spice.clove.views.icons.attachment.AttachmentIcons;
	
	[RemoteClass(alias="com.spice.clove.plugin.twitter.column.control.render.TwitterConversationAttachment")]
	
	public class TwitterConversationAttachment extends RenderedColumnDataLinkAttachment
	{
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function TwitterConversationAttachment()
		{
			super("View Conversation", "View Conversation", AttachmentIcons.CONVERSATION);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function select():void
		{
			
			var userController:TwitterConversationController = new TwitterConversationController(Number(this.data.rowuid));
			
			this.data.column.controller.dispatchEvent(new ColumnControllerEvent(ColumnControllerEvent.SET_BREADCRUMB,userController));
			
		}

	}
}