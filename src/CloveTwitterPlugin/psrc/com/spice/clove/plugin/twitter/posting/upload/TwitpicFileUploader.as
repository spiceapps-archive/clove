package com.spice.clove.plugin.twitter.posting.upload
{
	import com.spice.clove.plugin.posting.Attachment;
	import com.spice.clove.plugin.twitter.CloveTwitterPlugin;
	import com.spice.utils.queue.cue.IDataReturnableCue;
	
	public class TwitpicFileUploader implements ITwitterFileUploader
	{
		
		/**
		 */
		
		public function upload(att:Attachment,plugin:CloveTwitterPlugin):IDataReturnableCue
		{
			return new TwitpicRequest(att.file,plugin.connection.username,plugin.connection.password);
		}
	}
}