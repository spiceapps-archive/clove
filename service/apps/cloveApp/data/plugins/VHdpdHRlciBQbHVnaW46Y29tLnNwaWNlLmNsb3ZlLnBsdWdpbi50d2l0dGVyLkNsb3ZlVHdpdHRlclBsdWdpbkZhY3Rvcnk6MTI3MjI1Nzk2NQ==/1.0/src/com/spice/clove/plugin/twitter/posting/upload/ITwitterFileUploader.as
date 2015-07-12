package com.spice.clove.plugin.twitter.posting.upload
{
	import com.spice.clove.plugin.posting.Attachment;
	import com.spice.clove.plugin.twitter.CloveTwitterPlugin;
	import com.spice.utils.queue.cue.IDataReturnableCue;
	
	
	/*
	  any uploading service registered to twitter must implement this interface 
	  @author craigcondon
	  
	 */	
	 
	public interface ITwitterFileUploader
	{
		
		/*
		  
		  @param attachment the attachment of the post
		  @param plugin the twitter plugin
		  @return the returnable data cue
		  
		 */		
		function upload(attachment:Attachment,plugin:CloveTwitterPlugin):IDataReturnableCue;
	}
}