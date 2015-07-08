package com.spice.clove.twitpic.impl
{
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.post.core.outgoing.ICloveAttachmentUploader;
	import com.spice.clove.twitpic.impl.outgoing.TwitpicAttachmentUploader;
	import com.spice.clove.twitter.core.calls.CallTwitterPluginType;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	
	/**
	 * twitpic plugin for the twitter plugin 
	 * @author craigcondon
	 * 
	 */
	
	public class TwitpicPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitpicPlugin(factory:TwitpicPluginFactory)
		{
			super("Twitpic Plugin","com.spice.clove.twitpic",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
		}
		
		
		/**
		 */
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();
			this.finishInitialization();
		}
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
			new ProxyCall(CallTwitterPluginType.TWITTER_PLUGIN_REGISTER_ATTACHMENT_UPLOADER,this.getPluginMediator(),new TwitpicAttachmentUploader()).dispatch().dispose();
			
		}
		
		

	}
}