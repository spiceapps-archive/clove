package com.spice.clove.post.core.outgoing
{
	import com.spice.core.queue.ICue;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	
	/**
	 * uploads an attachment to a server 
	 * @author craigcondon
	 * 
	 */	
	
	public interface ICloveAttachmentUploader extends IProxyOwner
	{
		
		
		/**
		 * the file types this uploader can handler
		 */
		
		function getSupportedFileTypes():Vector.<String>;
		
		
		/**
		 * the name of the attachment uploader 
		 * @return 
		 * 
		 */		
		
		function getName():String;
		
		
		/**
		 * initializes the upload 
		 * @param value the attachment to upload
		 * @return 
		 * 
		 */
		
		function upload(value:ICloveAttachment):ICue;
	}
}