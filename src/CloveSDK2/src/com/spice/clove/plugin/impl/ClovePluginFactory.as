package com.spice.clove.plugin.impl
{
	import com.spice.clove.plugin.core.calls.CallClovePluginFactoryType;
	import com.spice.clove.plugin.core.calls.CallClovePluginInstallerType;
	import com.spice.clove.plugin.core.install.IClovePluginInstaller;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.core.recycle.IDisposable;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.plugin.factory.AbstractPluginFactory;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	import com.spice.vanilla.impl.proxy.ProxyCall;

	public class ClovePluginFactory extends AbstractPluginFactory implements IProxyResponder
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _installer:IClovePluginInstaller;
		private var _icon32:*;
		private var _icon16:*;
		private var _plugin:IPlugin;
		private var _name:String;
		private var _mediator:IProxyMediator;
		private var _hasUserAccount:Boolean;

		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function ClovePluginFactory()
		{
			super();

			//AS3 only
			Singleton.enforce(this);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallClovePluginFactoryType.GET_ICON_16:return this.respond(call,this.getIcon16());
				case CallClovePluginFactoryType.GET_ICON_32:return this.respond(call,this.getIcon32());
				case CallClovePluginFactoryType.GET_NAME: return this.respond(call,this.getName());
				case CallClovePluginFactoryType.GET_INSTALLER:return this.respond(call,this.getPluginInstaller());
				case CallClovePluginFactoryType.HAS_USER_ACCOUNT:return this.respond(call,this.hasUserAccount());
				case CallClovePluginFactoryType.SET_PLUGIN_MEDIATOR: this._mediator = call.getData(); this.onSetPluginMediator(); return;
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function hasUserAccount():Boolean
		{
			return this._hasUserAccount;
		}
		
		/**
		 */
		
		public function setHasUserAccount(value:Boolean):void
		{
			this._hasUserAccount = value;
		}
		/**
		 */
		
		final public function getName():String
		{
			return _name;
		}
		
		
		/**
		 */
		public function setName(value:String):void
		{
			this._name = value;
			this.notifyChange(CallClovePluginFactoryType.GET_NAME,value);
		}
		
		/**
		 */
		
		final public function getIcon32():*
		{
			return _icon32;
		}
		
		/**
		 */
		
		public function setIcon32(value:*):void
		{
			this._icon32 = value;
			
			this.notifyChange(CallClovePluginFactoryType.GET_ICON_32,value);
			
		}
		
		/**
		 */
		
		final public function getIcon16():*
		{
			return _icon16;
		}
		
		/**
		 */
		  
		public function setIcon16(value:*):void
		{
			this._icon16 = value;
			
			this.notifyChange(CallClovePluginFactoryType.GET_ICON_16,value);
		}
		
		
		
		/**
		 */
		public function getPluginMediator():IProxyMediator
		{
			return this._mediator;
		}
		
		
		 override final public function getPlugin():IPlugin
		{
			if(!_plugin)
			{
				_plugin = this.newPlugin();
			}
			
			return this._plugin;
			
			
		}
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function newPlugin():IPlugin
		{
			return null;
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallClovePluginFactoryType.GET_INSTALLER,
									CallClovePluginFactoryType.GET_ICON_16,
									CallClovePluginFactoryType.GET_ICON_32,
									CallClovePluginFactoryType.GET_NAME,
									CallClovePluginFactoryType.GET_PREFERENCES,
									CallClovePluginFactoryType.SET_PLUGIN_MEDIATOR,
									CallClovePluginFactoryType.HAS_USER_ACCOUNT]);
			
		}
		
		/**
		 */
		
		protected function getNewPluginInstaller(plugin:IPlugin):IClovePluginInstaller
		{
			throw new Error("getNewPluginInstaller must be overridden");
		}
		
		
		
		/**
		 */
		
		protected function onSetPluginMediator():void
		{
			//abstract
		}
		  
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function getPluginInstaller():IClovePluginInstaller
		{
			if(!this._installer)
			{ 
				this._installer = this.getNewPluginInstaller(this.getPlugin());
			}
			
			return this._installer;
		}
	}
}