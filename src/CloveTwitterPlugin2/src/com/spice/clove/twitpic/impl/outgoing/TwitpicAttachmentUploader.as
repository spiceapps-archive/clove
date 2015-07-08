package com.spice.clove.twitpic.impl.outgoing
{
	import com.spice.clove.post.core.outgoing.CloveAttachmentUploaderType;
	import com.spice.clove.post.core.outgoing.ICloveAttachment;
	import com.spice.clove.post.impl.outgoing.AbstractAttachmentUploader;
	import com.spice.clove.twitter.core.calls.CallTwitterPluginType;
	import com.spice.core.queue.ICue;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.net.URLRequestHeader;

	public class TwitpicAttachmentUploader extends AbstractAttachmentUploader
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitpicAttachmentUploader()
		{		
			super("Twitpic",["jpg","jpeg","png","gif"]);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function upload(value:ICloveAttachment):ICue
		{
			var header:URLRequestHeader = ProxyCallUtils.getResponse(CallTwitterPluginType.TWITTER_PLUGIN_GET_OAUTH_HEADER,this.getOwner().getProxy())[0];
			
			
			return new TwitpicUploadCue("",value,header);
		}
	}
}