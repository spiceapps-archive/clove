package com.spice.clove.plugin.core.calls
{
	public class CallClovePostableType
	{
		
		/**
		 * called when an attachment has been added
		 */
		
		public static const PREPARE_ATTACHMENT:String = "prepareAttachment";
		
		/**
		 * returns the name of the postable 
		 */		
		
		public static const GET_NAME:String = "getName";
		
		/**
		 * returns any attachments that may be processed. This is bound by the posting window.
		 */		
		
		public static const GET_PROCESSING_ATTACHMENT:String = "getProcessingAttachment";
	}
}