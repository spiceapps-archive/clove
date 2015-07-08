package com.spice.clove.service.impl.account
{
	import com.spice.clove.plugin.core.calls.CallCloveContentControllerType;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.post.core.calls.CallFromPostPluginType;
	import com.spice.clove.post.core.notifications.ServiceAccountNotification;
	import com.spice.clove.post.core.outgoing.IClovePostable;
	import com.spice.clove.service.core.account.IServiceAccount;
	import com.spice.clove.service.core.calls.CallToServiceAccountType;
	import com.spice.clove.service.impl.AbstractServicePlugin;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	import com.spice.vanilla.impl.settings.SettingTable;

	public class AbstractServiceAccount extends ProxyOwner implements IServiceAccount
	{  
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _settings:SettingTable;
		private var _name:String;
		private var _plugin:AbstractServicePlugin;
		private var _defaultPostables:Vector.<IClovePostable>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AbstractServiceAccount(settings:SettingTable)
		{
			_settings = settings;
			this._defaultPostables = new Vector.<IClovePostable>();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		public function getPostables():Vector.<IClovePostable>
		{
			return this._defaultPostables;
		}
		
		/**
		 */
		
		public function addPostable(value:IClovePostable):void
		{
			this._defaultPostables.push(value);
			
		}

		/**
		 */
		
		override public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{
				case CallToServiceAccountType.GET_NAME: return this.respond(c,this.getName());
				case CallToServiceAccountType.GET_AVAILABLE_CONTENT_CONTROLLERS: return this.respond(c,this.getAvailableContentControllers());
				case CallToServiceAccountType.GET_PLUGIN: return this.respond(c,this._plugin);
				case CallToServiceAccountType.SERVICE_ACCOUNT_UNINSTALL: return this.uninstall();
				case CallToServiceAccountType.GET_NEW_CONTENT_CONTROLLER: 
					this.respond(c,this._plugin.getNewContentControllerWithAccount(c.getData(),_plugin.getAccountIndex(this)));
				return;
			}
		}
		/**
		 */
		
		public function initialize(value:AbstractServicePlugin):void
		{ 
			_plugin = value;
		}
		
		
		public function getPlugin():IPlugin
		{
			return this._plugin;
		}
		/**
		 */
		public function getAvailableContentControllers():Vector.<String>
		{
			return _plugin.getContentControllerFactory().getAvailableContentControllers();
		}
		
		/**
		 */
		
		public function applicationInitialized():void
		{
			//abstract
		}
		
		
		/**
		 */
		public function getName():String
		{
			return this._name;
		}
		
		/**
		 */
		
		public function setName(value:String):void
		{
			this._name = value;
			
			this.notifyChange(CallToServiceAccountType.GET_NAME,value);
		}
		
		/**
		 */
		
		public function getPluginMediator():IProxyMediator
		{
			return this._plugin.getPluginMediator();
		}
		
		/**
		 */
		
		public function getPluginFactory():ClovePluginFactory
		{
			return this._plugin.getPluginFactory();
		}
		
		
		/**
		 */
		
		public function getSettings():SettingTable
		{
			return this._settings;
		}
		
		/**
		 */
		
		public function uninstall():void
		{
			
			
			this._plugin.removeAccount(this);
			
			//notify the bound observers listening via the proxy
			this.notifyBoundObservers(new ServiceAccountNotification(ServiceAccountNotification.SERVICE_ACCOUNT_UNINSTALL));
			
			
			this.dispose();
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			
			this.addAvailableCalls([CallToServiceAccountType.GET_NAME,
								    CallToServiceAccountType.GET_NEW_CONTENT_CONTROLLER,
									CallToServiceAccountType.GET_AVAILABLE_CONTENT_CONTROLLERS,
									CallToServiceAccountType.GET_PLUGIN,
									CallToServiceAccountType.SERVICE_ACCOUNT_UNINSTALL]);
		}
		
		
	}
}