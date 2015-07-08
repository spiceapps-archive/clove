package com.spice.clove.service.impl
{
	import com.spice.clove.plugin.core.calls.data.SceneSyncData;
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.post.core.calls.CallFromPostPluginType;
	import com.spice.clove.post.core.notifications.ServiceAccountNotification;
	import com.spice.clove.post.core.outgoing.IClovePostable;
	import com.spice.clove.service.core.account.IServiceAccount;
	import com.spice.clove.service.core.account.content.control.IAccountContentController;
	import com.spice.clove.service.core.calls.CallFromServicePluginType;
	import com.spice.clove.service.core.calls.CallServiceContentControllerType;
	import com.spice.clove.service.core.calls.CallServicePluginType;
	import com.spice.clove.service.core.calls.CallToServiceAccountType;
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.clove.service.impl.settings.AbstractServicePluginSettings;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.observer.CallbackObserver;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	/**
	 * A plugin that allows for multiple threads to 
	 * @author craigcondon
	 * 
	 */	
	
	public class AbstractServicePlugin extends ClovePlugin  
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _settings:AbstractServicePluginSettings;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AbstractServicePlugin(name:String,uid:String,factory:ClovePluginFactory,settings:AbstractServicePluginSettings)
		{  
			super(name,uid,(_settings = settings),factory);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function addAcount():AbstractServiceAccount
		{
			var acc:AbstractServiceAccount = this._settings.getAccountList().addAccount();
			
			if(this.initialized())
			{
				this.initializeAccount(acc);
				this.notifyChange(CallFromPostPluginType.GET_DEFAULT_POSTABLES,acc.getPostables());
			}
			
			this.notifyChange(CallServicePluginType.SERVICE_PLUGIN_GET_ACCOUNTS,this.getAccounts());
			
			return acc;
		}
		
		/**
		 */
		
		public function removeAccount(value:AbstractServiceAccount):void
		{
			this._settings.getAccountList().removeAccount(value);
			
			
			this.notifyChange(CallServicePluginType.SERVICE_PLUGIN_GET_ACCOUNTS,this.getAccounts());
			ProxyCallUtils.quickCall(CallFromServicePluginType.SERVICE_ACCOUNT_UNINSTALL,this.getPluginMediator());
		}
		
		
		/**
		 */
		
		public function getAccountAt(index:int):AbstractServiceAccount
		{
			if(index == -1 || index >= this.getAccounts().length)
				return null;
			
			return this._settings.getAccountList().getAccountAt(index);
		}
		
		/**
		 */
		
		
		public function getAccountOrMake():AbstractServiceAccount
		{
			if(this.getAccounts().length == 0)
			{
				return this.addAcount();
				//this._account = this._plugin.addAcount();
			}
			
			
			return this.getAccountAt(0);
		}
		
		
		/**
		 */
		
		public function getAccountIndex(value:AbstractServiceAccount):int
		{
			return this._settings.getAccountList().getAccounts().indexOf(value);
		}
		
		/**
		 */
		
		public function getAccounts():Vector.<IServiceAccount>
		{
			return this._settings.getAccountList().getAccounts();
		}
		
		/**
		 */
		
		public function getNewContentControllerWithAccount(type:String,account:int):ICloveContentController
		{
			var controller:ICloveContentController = this.getNewContentController(type);
			
			IAccountContentController(controller).setAccount(this.getAccountAt(account));
//			ProxyCallUtils.quickCall(CallServiceContentControllerType.SET_ACCOUNT,controller.getProxy(),account);
			return controller;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function getPostables():Vector.<IClovePostable>
		{
			var cp:Vector.<IClovePostable> = super.getPostables();
			
			for each(var acc:IServiceAccount in this.getAccounts())
			{
				cp = cp.concat(AbstractServiceAccount(acc).getPostables());
			}
			
			return cp;
		}
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallServicePluginType.SERVICE_PLUGIN_GET_ACCOUNTS: return this.respond(call,this.getAccounts());
				case CallServicePluginType.GET_SERVICE_PLUGIN: return this.respond(call,this);
			}
			
			
			super.answerProxyCall(call);
		}
		
		
		
		

		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function sceneSyncReadExternal(input:SceneSyncData):void
		{
			var n:int = input.getData().readUnsignedInt();
			
			for(var i:int = this.getAccounts().length; i < n ; i++)
			{
				this.addAcount();
			}
			
		}
		
		/**
		 */
		
		override protected function sceneSyncWriteExternal(output:IDataOutput):void
		{
			//sync the accounts
			output.writeUnsignedInt(this.getAccounts().length);
		}
		
		/**
		 */
		
		override protected function sceneSyncReadSubscribedExternal(input:SceneSyncData):void
		{  
//			this.sceneSyncReadExternal(input);
		}
		
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();
			  
			
			for each(var account:AbstractServiceAccount in this._settings.getAccountList().getAccounts())
			{
				this.initializeAccount(account);
			}
			
			this.finishInitialization();
		}
		
		
		/**
		 */
		
		protected function initializeAccount(value:AbstractServiceAccount):void
		{
			value.initialize(this);
			
		}
		
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
			for each(var account:AbstractServiceAccount in this._settings.getAccountList().getAccounts())
			{
				account.applicationInitialized();
			}
		}
		
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallServicePluginType.SERVICE_PLUGIN_GET_ACCOUNTS,CallServicePluginType.GET_SERVICE_PLUGIN]);
		}
		
		
	}
}