package com.spice.clove.command.plugin
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.InstallSamePluginEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.control.ClovePluginController;
	import com.spice.clove.plugin.load.InstalledPluginInfo;
	
	import mx.events.CollectionEvent;
	
	public class InstallSamePluginCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		private var _event:InstallSamePluginEvent;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function InstallSamePluginCommand()
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
			
			_event= InstallSamePluginEvent(event);
			
			
			_model.applicationSettings.pluginManager.loadedPlugins.addEventListener(CollectionEvent.COLLECTION_CHANGE,onPluginAdded);
		
		
			_model.applicationSettings.pluginManager.addUsedPlugin(new InstalledPluginInfo(this._event.factoryClass));
				
				
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
        /*
		 */
		
		private function onPluginAdded(event:CollectionEvent):void
		{
			
			event.currentTarget.removeEventListener(event.type,onPluginAdded);
			
			var plugin:ClovePluginController = event.items[0];
			
			if(_event.installCallback != null)
			{
				_event.installCallback(plugin);
			}
		}

	}
}