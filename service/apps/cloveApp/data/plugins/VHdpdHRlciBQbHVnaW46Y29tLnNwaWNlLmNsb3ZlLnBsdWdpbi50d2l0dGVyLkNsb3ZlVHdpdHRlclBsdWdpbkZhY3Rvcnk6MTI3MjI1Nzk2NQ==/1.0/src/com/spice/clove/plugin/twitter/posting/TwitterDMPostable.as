package com.spice.clove.plugin.twitter.posting
{
	import com.architectd.twitter.Twitter;
	import com.architectd.twitter.calls.dm.SendDirectMessageCall;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.posting.Attachment;
	import com.spice.clove.plugin.posting.IPostable;
	import com.spice.clove.plugin.posting.Postable;
	import com.spice.clove.plugin.twitter.CloveTwitterPlugin;
	import com.spice.clove.plugin.twitter.cue.TwitterServiceCue;
	import com.swfjunkie.tweetr.events.TweetEvent;

	public class TwitterDMPostable extends Postable implements IPostable
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _user:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		public function TwitterDMPostable(controller:IPluginController,user:String)
		{
			super(controller,"DM: "+user);
			
			_user = user;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function prepareAttachment(attachment:Attachment):void
		{
			//nothing
		}
		
		
		/*
		 */
	
		override public function init() : void
		{
			var connection:Twitter = CloveTwitterPlugin(this.pluginController.plugin).connection;
			
			
			//we add a twutter cue since only one request can be 
			//called at a time
			this.twitterPlugin.call(new TwitterServiceCue(connection,new SendDirectMessageCall(this._user,this.message.text),this.onPostComplete));
			
		
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		private function onPostComplete(dat:*):void
		{
			this.complete();
		}
		
		/*
		 */
		
		
		private function get twitterPlugin():CloveTwitterPlugin
		{
			return CloveTwitterPlugin(this.pluginController.plugin);
		}
	}
}