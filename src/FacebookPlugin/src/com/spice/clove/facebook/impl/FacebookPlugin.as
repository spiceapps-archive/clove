package com.spice.clove.facebook.impl
{
	import com.facebook.Facebook;
	import com.facebook.net.FacebookCall;
	import com.facebook.session.DesktopSession;
	import com.facebook.session.WebSession;
	import com.spice.clove.facebook.impl.account.FacebookAccount;
	import com.spice.clove.facebook.impl.content.control.FacebookContentControllerFactory;
	import com.spice.clove.facebook.impl.cue.FacebookCallCue;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.service.core.account.IServiceAccount;
	import com.spice.clove.service.impl.AbstractServicePlugin;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.service.impl.settings.AbstractServicePluginSettings;
	import com.spice.clove.service.impl.settings.ISettingAccountFactory;
	import com.spice.clove.service.impl.settings.ServiceSettingFactory;
	import com.spice.impl.queue.Queue;

	public class FacebookPlugin extends AbstractServicePlugin implements ISettingAccountFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const API_KEY:String = "fdb2dd8fb51838f5f36d69556f0d4604";
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _contentControllerFactory:FacebookContentControllerFactory;
		private var _session:WebSession;
		private var _connection:Facebook;
		private var _queue:Queue;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookPlugin(factory:FacebookPluginFactory)
		{
			super("Facebook","com.spice.clove.facebook",factory,new AbstractServicePluginSettings(new ServiceSettingFactory(this)));
			
			_contentControllerFactory = new FacebookContentControllerFactory(this);
			
			this.setContentControllerFactory(_contentControllerFactory);
			_queue = new Queue();
			_queue.start();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getNewServiceAccount():AbstractServiceAccount
		{
			return new FacebookAccount();
		}
		
		/**
		 */
		
		public function getPublicConnection():Facebook
		{
			if(!_connection)
			{
				_connection = new Facebook();
				_session = new WebSession(FacebookPlugin.API_KEY,null);
				_connection.startSession(_session);
			}
			
			return _connection;
		}
		
		/**
		 */
		
		public function call(value:FacebookCall):FacebookCall
		{
			_queue.addCue(new FacebookCallCue(value,this.getPublicConnection()));
			return value;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function getAvailableContentControllers():Vector.<String>
		{
			return _contentControllerFactory.getPublicContentControllers();
		}
		
		
	}
}