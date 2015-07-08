package com.spice.clove.commands.pluginService
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.PackerEvent;
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.clove.plugin.compiled.CompiledPlugin;
	import com.spice.clove.plugin.compiled.CompiledPluginInfo;
	import com.spice.clove.view.pluginPacker.editPlugin.EditPluginWindow;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	
	public class LoadPluginCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Bindable] 
		private var _model:PackerModelLocator = PackerModelLocator.getInstance();
		
		private var _plugin:CompiledPluginInfo;
		private var _loader:URLStream;
		private var _alert:LoadingWindow;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function LoadPluginCommand()
		{
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
			
			
			_plugin = PackerEvent(event).value;
			
			
			
			_loader = new URLStream();
			_loader.addEventListener(Event.COMPLETE,onPluginLoad)
			_loader.load(new URLRequest(_plugin.remotePath));
			
			_alert = LoadingWindow.open();
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onPluginLoad(event:Event):void
		{
			_alert.close();
			
			event.currentTarget.removeEventListener(event.type,onPluginLoad);
			
			var plug:CompiledPlugin;
			
			//if no bytes are available then we know that the plugin is new
			if(_loader.bytesAvailable == 0)
			{
				plug = new CompiledPlugin(_plugin);
			}
			else
			{
				plug = _loader.readObject();
				
			}
			
			EditPluginWindow.open(plug);
		}
	}
}