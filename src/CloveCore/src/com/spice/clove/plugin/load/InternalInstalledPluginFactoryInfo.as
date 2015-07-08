package com.spice.clove.plugin.load
{
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.calls.CallCloveInstalledPluginType;
	import com.spice.clove.plugin.core.calls.CallClovePluginFactoryType;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.install.AvailableInternalService;
	import com.spice.clove.plugin.install.IAvailableService;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/*
	  Plugins installed that are already part of the compiled AIR app
	 */
	 	
	
	[Bindable] 
	[RemoteClass(alias='com.spice.clove.plugin.load.InternalInstalledPlugin')]
	public class InternalInstalledPluginFactoryInfo extends InstalledPluginFactoryInfo implements IInstalledPluginFactoryInfo, IProxyOwner, IProxyResponder
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var name:String;
        public var factoryClass:String;
        public var uid:String;
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _pluginFactoryClass:Class;
        private var _pluginFactory:IPluginFactory;
		
		
		
		private var _proxy:ProxyOwner;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function InternalInstalledPluginFactoryInfo(name:String = null,
												pluginFactory:* = null)
		{
			this.name		  = name;
			this.factoryClass = pluginFactory is String ? pluginFactory :  flash.utils.getQualifiedClassName(pluginFactory);
			this.uid 		  = factoryClass;
			
			
			if(pluginFactory is IPluginFactory)
			{
				_pluginFactory = pluginFactory;
			}
			
			
			_proxy = new ProxyOwner(this);
			_proxy.addAvailableCalls([CallCloveInstalledPluginType.GET_LOADED_PLUGIN_FACTORY]);
			
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		
		/** 
		 * @DEPRICATED
		 */
		
		
		public function get loadedPluginFactory():IPluginFactory
		{
			if(!_pluginFactoryClass)
			{
				this.loadPluginFactory();
			}
			
			if(!_pluginFactory)
			{
				_pluginFactory = Singleton.getInstance(_pluginFactoryClass);
				new ProxyCall( CallClovePluginFactoryType.SET_PLUGIN_MEDIATOR,_pluginFactory.getProxy(),ClovePluginMediator.getInstance()).dispatch().dispose();
			
			}
			
			return this._pluginFactory;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		/*
		 * DEPRICATED
		 */
		
		public function uninstall():void
		{
			//nothing
		}
		
		
		/** 
		 * @DEPRICATED
		 */
		
		public function getAvailableService():IAvailableService
		{
			return new AvailableInternalService(this.name,this._pluginFactory);
		}
		
        /** 
		 * @DEPRICATED
		 */
		
		public function loadPluginFactory():void
		{
			
			_pluginFactoryClass = flash.utils.getDefinitionByName(this.factoryClass) as Class;
			
			this.complete();
		}
		
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getProxy():IProxy
		{
			return this._proxy.getProxy();
		}
		
		/**
		 */
		
		public function getAvailableCalls():Vector.<String>
		{
			return this._proxy.getAvailableCalls();
		}
		
		/**
		 * V2 of the SDK architecture 
		 */
		
		public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallCloveInstalledPluginType.GET_LOADED_PLUGIN_FACTORY:
					
					if(!_pluginFactoryClass)
						loadPluginFactory();
					
					
					if(!_pluginFactory)
					{
						_pluginFactory = new _pluginFactoryClass();
					}
					
					this._proxy.respond(call,this._pluginFactory);
				break;
			}
		}
		
		
     

	}
}