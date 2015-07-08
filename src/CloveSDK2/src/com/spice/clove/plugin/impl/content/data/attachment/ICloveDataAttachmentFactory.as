package com.spice.clove.plugin.impl.content.data.attachment
{
	public interface ICloveDataAttachmentFactory
	{
		/**
		 * the available attachments for useable for the rendered column data.
		 * This is also used to load any attachments stored in SQLite. 
		 * @return 
		 * 
		 */
		  
//		function getAvailableAttachments():Vector.<String>;
		
		/**
		 * returns a new rendered column data attachment 
		 * @return 
		 * 
		 */		
		
		function getNewAttachment(type:String):ICloveDataAttachment;
	}
}