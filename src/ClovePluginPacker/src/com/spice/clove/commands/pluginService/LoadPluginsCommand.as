package com.spice.clove.commands.pluginService
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.business.PluginDelegate;
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.clove.plugin.compiled.CompiledPluginInfo;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoadPluginsCommand implements ICommand, IResponder
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Bindable] 
		private var _model:PackerModelLocator = PackerModelLocator.getInstance();
		
		
		private var _delegate:PluginDelegate;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function LoadPluginsCommand()
		{
			_delegate = new PluginDelegate(this);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		
		public function execute(event:CairngormEvent):void
		{
			_delegate.getRegisteredPlugins();	
		}
		
        /**
		 */
		
		public function result(data:Object):void
		{
			
			var plugins:Array = Array(ResultEvent(data).message.body)[0];
			
			var vos:ArrayList = new ArrayList();
			
			for each(var plug:* in plugins)
			{
				vos.addItem(new CompiledPluginInfo(plug.name,plug.description,plug.updateInfo,plug.filePath,plug.id));
			}
			
			
			
			_model.plugin.userPlugins = vos;
		}
		
		/**
		 */
		
		public function fault(data:Object):void
		{
			Alert.show(FaultEvent(data).fault.faultString);
			
		}

	}
}