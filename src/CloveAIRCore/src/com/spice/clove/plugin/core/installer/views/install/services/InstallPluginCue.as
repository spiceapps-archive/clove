package com.spice.clove.plugin.core.installer.views.install.services
{
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.control.AIRClovePluginController;
	import com.spice.clove.plugin.control.cue.LoadPluginCue;
	import com.spice.clove.plugin.core.calls.CallClovePluginFactoryType;
	import com.spice.clove.plugin.core.calls.CallClovePluginInstallerType;
	import com.spice.clove.plugin.core.install.IClovePluginInstaller;
	import com.spice.clove.plugin.data.InstallPluginData;
	import com.spice.clove.plugin.impl.install.ClovePluginInstaller;
	import com.spice.clove.plugin.install.AvailableExternalService;
	import com.spice.clove.plugin.install.IAvailableService;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	public class InstallPluginCue extends AbstractCue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _info:IAvailableService;
		
		private var _plugin:IPlugin;
		
		[Bindable] 
		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function InstallPluginCue(info:IAvailableService)
		{
			_info = info;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function initialize():void
		{
			
			var c:IClovePluginInstaller;
			
			_plugin =  IClovePluginInstaller(ProxyCallUtils.getResponse(CallClovePluginFactoryType.GET_INSTALLER,_info.factory.getProxy())[0]).getPlugin();
			
			new CloveEvent(CloveEvent.INSTALL_PLUGIN,new InstallPluginData(_info.install(),_plugin)).dispatch();
			
			this.complete();
		}
		

	}
}