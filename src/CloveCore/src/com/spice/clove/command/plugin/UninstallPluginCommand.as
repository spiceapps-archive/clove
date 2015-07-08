package com.spice.clove.command.plugin
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.control.ClovePluginController;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	public class UninstallPluginCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _modelLocator:CloveModelLocator = CloveModelLocator.getInstance();
		
		private var _event:CloveEvent;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function UninstallPluginCommand()
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
			_event = CloveEvent(event);
			
			
			Alert.show("Are you sure you want to remove this item? Feeds using this plugin will be removed.","Remove Plugin",Alert.YES | Alert.NO,null,onConfirm);
		
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onConfirm(event:CloseEvent):void
		{
			
			if(event.detail != Alert.YES)
			{
				return;
			}
			
			
			
			var plug:ClovePluginController = _event.voData;
			
			
			
			_modelLocator.applicationSettings.uninstallPlugin(_event.voData.uid);
			
			
			
		}
		
		

	}
}