package com.spice.clove.plugin.install
{
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.calls.CallClovePluginFactoryType;
	import com.spice.clove.plugin.core.install.IClovePluginInstaller;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.load.IInstalledPluginFactoryInfo;
	import com.spice.clove.plugin.load.InternalInstalledPluginFactoryInfo;
	import com.spice.clove.plugin.load.PluginInstallationManager;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.utils.queue.cue.Cue;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.impl.plugin.factory.AbstractPluginFactory;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	[Bindable] 
	[RemoteClass(alias="com.spice.clove.ext.installer.install.services.avail.AvailableInternalPlugin")]
	public class AvailableInternalService extends AbstractCue implements IAvailableService, IProxyOwner
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		
		//ICloveServiceInstaller or IServiceInstaller
		
        public var optional:Boolean;
        public var selected:Boolean;
        public var name:String;
        public var uid:String;
        public var visible:Boolean;
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _proxy:IProxy;
		private var _pluginFactory:IPluginFactory;
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function AvailableInternalService(name:String,
												 pluginFactory:IPluginFactory,
												 optional:Boolean = true,
												 selected:Boolean = false,
												 visible:Boolean  = true,
												 uid:String = null)
		{
			
			
			this._pluginFactory = pluginFactory;
			
			new ProxyCall( CallClovePluginFactoryType.SET_PLUGIN_MEDIATOR,  pluginFactory.getProxy(),ClovePluginMediator.getInstance()).dispatch().dispose();
			
			
			this.name      	  = name;
			this.optional     = optional;
			this.selected     = selected;
			this.uid          = uid;
			this.visible      = visible;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		/**
		 */
		public function get factory():IPluginFactory
		{
			return this._pluginFactory;
		}
		
        /*
		 */
		
		override public function initialize():void
		{
			this.complete();
		}
        /*
		 */
		
		public function install():IInstalledPluginFactoryInfo
		{
			
			
			return new InternalInstalledPluginFactoryInfo(this.name,this._pluginFactory);
		}
		
		

	}
}