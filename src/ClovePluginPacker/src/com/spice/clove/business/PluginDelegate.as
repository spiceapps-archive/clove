package com.spice.clove.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.spice.clove.plugin.compiled.CompiledPlugin;
	import com.spice.clove.plugin.compiled.CompiledPluginInfo;
	
	import flash.utils.ByteArray;
	
	import mx.rpc.AbstractService;
	import mx.rpc.IResponder;
	
	public class PluginDelegate 
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _service:AbstractService;
		private var _responder:IResponder;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function PluginDelegate(responder:IResponder)
		{
			_service = ServiceLocator.getInstance().getService('pluginService');
			_responder = responder;
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function getRegisteredPlugins():void
		{
			var dat:Object = _service.getPluginList();
			dat.addResponder(_responder);
		}
		
		/**
		 */
		
		public function newPlugin(plugin:CompiledPluginInfo):void
		{
			var dat:Object = _service.addPlugin(plugin.name);
			dat.addResponder(_responder);
		}
		
		/**
		 */
		
		public function savePlugin(plugin:CompiledPlugin):void
		{
			var inf:CompiledPluginInfo = plugin.pluginInfo;
			plugin.version = new Date().getTime().toString();
			
			var bt:ByteArray = new ByteArray();
			bt.writeObject(plugin);
			bt.compress(); 

			
			
			
			//give the timstamp so that when the plugin recompiles, all other services
			//using this plugin will be updates
			
			var dat:Object = _service.savePlugin(inf.pluginID,plugin.version,inf.name,inf.updateInfo,inf.description,bt,plugin.factoryClass);
			dat.addResponder(_responder);
			
		}

	}
}