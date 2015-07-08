package com.spice.clove.plugin.twitter.posting
{
	import com.architectd.twitter.Twitter;
	import com.architectd.twitter.calls.status.StatusUpdateCall;
	import com.spice.clove.commandEvents.CloveCueEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.posting.Attachment;
	import com.spice.clove.plugin.posting.IPostable;
	import com.spice.clove.plugin.posting.Postable;
	import com.spice.clove.plugin.twitter.CloveTwitterPlugin;
	import com.spice.clove.plugin.twitter.cue.TwitterServiceCue;
	import com.spice.clove.plugin.twitter.posting.upload.ITwitterFileUploader;
	import com.spice.clove.plugin.twitter.posting.upload.TwitterUploadType;
	import com.spice.events.QueueManagerEvent;
	import com.spice.utils.queue.cue.IDataReturnableCue;
	
	
	/**
	 * Wall postable handles any messages/ attachments and places them on the wall 
	 * @author craig condon
	 * 
	 */	
	[Bindable]
	public class TwitterWallPostable extends Postable implements IPostable
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitterWallPostable(plugin:IPluginController,
											name:String)
		{
			super(plugin,name);
			
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function init():void
		{
			
			var connection:Twitter = this.twitterPlugin.connection;
			
			
			//we add a twutter cue since only one request can be 
			//called at a time
			
			this.twitterPlugin.call(new TwitterServiceCue(connection,new StatusUpdateCall(this.message.text),this.onPostComplete));
			
											   
		}
		
		/**
		 */
		 
		public function prepareAttachment(att:Attachment):void
		{
			
			
			
			//if the file is already being uploaded, then ignore this 
			if(att.metadata.getSetting('uploading') == true)
				return;
				
			//grab the service we're using for attaching documents
			var photoUploader:ITwitterFileUploader = this.twitterPlugin.getDefaultService(TwitterUploadType.PHOTO);
			
			//if there is an uploader than initialize
			if(photoUploader)
			{
				var up:IDataReturnableCue = photoUploader.upload(att,this.twitterPlugin);
				
				att.addProgressCue(up);
				//dispatch the cue
				new CloveCueEvent(up,Math.random().toString()).dispatch();
				
				up.addEventListener(QueueManagerEvent.CUE_COMPLETE,onFileUpload,false,0,true);
			}
			
			att.metadata.saveSetting('uploading',true);
			
		}
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		private function onPostComplete(dat:*):void
		{
			this.complete();
		}
		
		/**
		 */
		
		private function onFileUpload(event:QueueManagerEvent):void
		{
			
			var cue:IDataReturnableCue = IDataReturnableCue(event.target);
			
			
			Logger.log("onFileUpload success="+cue.success);
			//if successful, copy and paste the new link to the poster
			if(cue.success)
			{
				new CloveEvent(CloveEvent.COPY_TO_POSTER," "+String(cue.data)).dispatch();
			}
		}
		
		
		private function get twitterPlugin():CloveTwitterPlugin
		{
			return CloveTwitterPlugin(this.pluginController.plugin);
		}
		
		
	}
}