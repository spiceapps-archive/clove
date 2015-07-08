package com.spice.clove.twitter.impl.content.control.search
{
	import com.architectd.twitter2.TwitterErrorCodes;
	import com.architectd.twitter2.calls.TwitterCall;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerState;
	import com.spice.clove.plugin.impl.content.control.search.CloveSearchBasedContentController;
	import com.spice.clove.plugin.impl.views.menu.AbstractRegisteredMenuItemButtonViewController;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.service.impl.account.content.control.search.AccountSearchBasedContentController;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.account.TwitterPluginAccount;
	import com.spice.clove.twitter.impl.content.control.ITwitterContentController;
	import com.spice.clove.twitter.impl.content.control.option.TwitterDataOptionType;
	import com.spice.clove.twitter.impl.content.control.option.TwitterDataOptionViewController;
	import com.spice.clove.twitter.impl.content.control.render.TwitterSearchDataRenderer;
	import com.spice.core.calls.CallRemoteServiceLoadCueType;
	import com.spice.impl.service.RemoteServiceResult;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	
	import mx.rpc.Fault;

	public class TwitterSearchBasedContentController extends AccountSearchBasedContentController implements IProxyBinding, ITwitterContentController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:TwitterPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterSearchBasedContentController(name:String,
															plugin:ClovePlugin,
															prefix:String = null,
															searchTerm:String = null)
		{
			super(name,
				  plugin,
				  new TwitterSearchDataRenderer(this,plugin.getPluginMediator()),
				  prefix,
				  searchTerm);
			
			
			_plugin = TwitterPlugin(plugin);
			
			
			
			var dataOption:TwitterDataOptionViewController = new TwitterDataOptionViewController(this._plugin.getPluginMediator(),this,[TwitterDataOptionType.RETWEET]);
			
			this.addDataOptionController(new AbstractRegisteredMenuItemButtonViewController(CallRegisteredViewType.GET_NEW_REGISTERED_MENU_BUTTON_VIEW_CONTROLLER,this._plugin.getPluginMediator(),dataOption));
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case CallRemoteServiceLoadCueType.SERVICE_RESULT: 
					callComplete(n.getData());
				return;
			}
		}
		
		/**
		 */
		
		public function getTwitterAccount():TwitterPluginAccount
		{
			return TwitterPluginAccount(this.getAccount());
		}
		
		/**
		 */
		
		public function getTwitterPlugin():TwitterPlugin
		{
			return this._plugin;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function fillonCueComplete(cue:TwitterCall):void
		{
			
			new ProxyBind(cue.getProxy(),this,[CallRemoteServiceLoadCueType.SERVICE_RESULT],true);
		}
		
		/**
		 */
		
		protected function callComplete(data:RemoteServiceResult):void
		{
			
			this.setLoadingState( data.success() ? CloveContentControllerState.COMPLETE : CloveContentControllerState.ERROR);
			
			if(!data.success())
			{
				this.showErrorMessage(this.handleAndGetErrorMessage(Number(Fault(data.getData()).faultCode)));
				
//				this.lookupErrorMessage(data.);
				return;
			}
			
			try
			{
				this.fillColumn(data.getData());
			}catch(e:Error)
			{
				Logger.logError(e);
			}
		}
		
		/**
		 */
		
		
		protected function handleAndGetErrorMessage(id:Number):String
		{
			switch(id)
			{
				case TwitterErrorCodes.INTERNAL_SERVER_ERROR: 
				case TwitterErrorCodes.BAD_GATEWAY: return "Twitter is down or being upgraded";
				case TwitterErrorCodes.SERVICE_UNUVAILABLE: return "Twitter is currently overloaded";
				case TwitterErrorCodes.NO_NEW_DATA_TO_RETURN: return "No new data to return";
				case TwitterErrorCodes.INVALID_REQUEST: return "Rate limit exceeded";
				case TwitterErrorCodes.UNAUTHORIZED: 
					this.getAccountOrMake();
					return "Unauthorized";
				case TwitterErrorCodes.FORBIDDEN: return "Forbidden";
				case TwitterErrorCodes.NOT_FOUND: return "404 not found";
				case TwitterErrorCodes.NOT_ACCEPTABLE: return "The URI requested is invalid";
				case TwitterErrorCodes.RATE_LIMIT_THROTTLE: return "Too many API calls";
			}
			
			return "Unknown error";
		}
	}
}