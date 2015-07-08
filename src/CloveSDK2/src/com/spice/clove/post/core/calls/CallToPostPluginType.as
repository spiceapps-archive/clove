package com.spice.clove.post.core.calls
{
	public class CallToPostPluginType
	{
		
		/**
		 * adds an active postable to the window. This is used when replying to messages, Direct Messages, etc.
		 */
		
		public static const ADD_ACTIVE_POSTABLE:String = "addActivePostable";

		/**
		 */
		
		public static const OPEN_POST_WINDOW:String = "openPostWindow";
		
		/**
		 */
		
		public static const ADD_TEXT_TO_POST_WINDOW:String = "addTextToPostWindow";

		/**
		 * browse for an attachment to add to the current post window. if the current post window is not yet open, then open it.
		 */
		
		public static const POST_BROWSE_FOR_ATTACHMENT:String = "postBrowseForAttachment";
		
		
	}
}