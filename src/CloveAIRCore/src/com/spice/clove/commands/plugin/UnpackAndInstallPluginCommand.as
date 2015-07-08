package com.spice.clove.commands.plugin
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.compiled.CompiledPlugin;
	import com.spice.clove.plugin.data.InstallPluginData;
	import com.spice.clove.plugin.load.IInstalledPluginFactoryInfo;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	
	public class UnpackAndInstallPluginCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function UnpackAndInstallPluginCommand()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function execute(event:CairngormEvent):void
		{
			
			
			var data:* = CloveEvent(event).voData;
			
			var plug:*;
			
			
			if(data is CompiledPlugin)
			{
				
				this.loadCompiledPlugin(data);
			}
			else
			if(data is ByteArray)
			{
				this.loadCompiledPlugin(CompiledPlugin(data.readObject()));
			}
			else
			if(data is InstallPluginData)
			{
				_model.applicationSettings.pluginManager.installPluginFactory(InstallPluginData(data).info,InstallPluginData(data).plugin);
			}
			else
			if(data is File)
			{
				var f:File = data;
			
				
				var stream:FileStream = new FileStream();
				stream.open(f,FileMode.READ);
				
				this.loadCompiledPlugin(stream.readObject());
				
				stream.close();
			}
			
			
			
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
        private var _plugin:CompiledPlugin;
        
        /*
		 */
		
		private function loadCompiledPlugin(plugin:CompiledPlugin):void
		{
			
			
			_plugin = plugin;
			
			plugin.load(installPlugin);
		}
		
		/*
		 */
		
		private function installPlugin(event:*):void
		{
			event.currentTarget.removeEventListener(event.type,installPlugin);
			
			_model.applicationSettings.pluginManager.installPluginFactory(_plugin.install());
		}
		

	}
}