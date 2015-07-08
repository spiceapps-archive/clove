package com.spice.clove.twitter.impl.content.control
{
	import com.architectd.twitter2.TwitterService;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerState;
	import com.spice.clove.plugin.impl.views.menu.AbstractRegisteredMenuItemButtonViewController;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.service.impl.account.content.control.AccountContentController;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.account.TwitterPluginAccount;
	import com.spice.clove.twitter.impl.content.control.option.TwitterDataOptionType;
	import com.spice.clove.twitter.impl.content.control.option.TwitterDataOptionViewController;
	import com.spice.core.calls.CallCueType;
	import com.spice.core.calls.CallRemoteServiceLoadCueType;
	import com.spice.impl.service.RemoteServiceLoadCue;
	import com.spice.impl.service.RemoteServiceResult;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBind;
	
	public class AbstractTwitterContentController extends AccountContentController implements IProxyBinding, ITwitterContentController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:TwitterPlugin;
		private var _callBind:ProxyBind;
		private var _hasError:Boolean;
		private var _dataOptions:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AbstractTwitterContentController(factoryName:String,plugin:TwitterPlugin,itemRenderer:ICloveDataRenderer,dataOptions:Array = null)
		{
			_plugin = plugin;
			super(factoryName,plugin,itemRenderer);  
			_dataOptions = dataOptions;
			
			
			var dataOption:TwitterDataOptionViewController = new TwitterDataOptionViewController(plugin.getPluginMediator(),this,_dataOptions ? _dataOptions : [TwitterDataOptionType.RETWEET]);
			
			this.addDataOptionController(new AbstractRegisteredMenuItemButtonViewController(CallRegisteredViewType.GET_NEW_REGISTERED_MENU_BUTTON_VIEW_CONTROLLER,plugin.getPluginMediator(),dataOption));
			
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		public function getTwitterAccount():TwitterPluginAccount
		{
			return TwitterPluginAccount(this.getAccountOrMake());
		}
		
		public function getPublicOrPrivateConnection():TwitterService
		{
			return this.getAccount() ? TwitterPluginAccount(this.getAccount()).connection : _plugin.getPublicConnection();
		}
		/**
		 */
		
		public function getTwitterPlugin():TwitterPlugin
		{
			return this._plugin;
		}
		
		/**
		 */
		
		public function notifyProxyBinding(n:INotification):void
		{
			switch(n.getType())
			{
				case CallRemoteServiceLoadCueType.SERVICE_RESULT: return callComplete(n.getData());
				case CallCueType.COMPLETE: 
					this.setLoadingState(_hasError ? CloveContentControllerState.ERROR : CloveContentControllerState.COMPLETE);
					this._callBind.dispose();
					return;
			}
			
		}
		/**
		 */
		
		protected function fillonCueComplete(cue:RemoteServiceLoadCue):void
		{
			
			if(_callBind)
			{
				_callBind.dispose();
			}
			
			_hasError = false;
			
			
			this._callBind = new ProxyBind(cue.getProxy(),this,[CallCueType.COMPLETE,CallRemoteServiceLoadCueType.SERVICE_RESULT ]);
		}
		
		/**
		 */
		
		protected function callComplete(data:RemoteServiceResult):void
		{
			
			if(!data.success())
			{
				_hasError = true;
				return;
			}
			
			
			try
			{
				var d:* = data.getData();
				
				this.fillColumn(d is Array ? d : [d]);
			}catch(e:Error)
			{
				Logger.logError(e);
			}
		}
	}
}