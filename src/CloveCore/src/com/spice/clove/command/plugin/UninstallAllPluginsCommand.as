package com.spice.clove.command.plugin
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.load.IInstalledPluginFactoryInfo;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	public class UninstallAllPluginsCommand implements ICommand
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
		
		
		public function UninstallAllPluginsCommand()
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
			
			
			Alert.show("Are you sure you want to completely remove this plugin? Any preferences associated with this item will be permanently discarded.","Remove Plugin",Alert.YES | Alert.NO,null,onConfirm);
			
			
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
			
			
			var factory:IInstalledPluginFactoryInfo = _event.voData;
			
			
			
			_modelLocator.applicationSettings.uninstallFactory(factory);
			
			
			
		}
		
		
		
	}
}