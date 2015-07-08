package com.spice.clove.commands
{
	import adobe.utils.ProductManager;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.models.CloveAIRModelLocator;
	
	import flash.filesystem.File;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.WindowedApplication;
	import mx.events.CloseEvent;

	
	public class WipeSettingsCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _model:CloveAIRModelLocator = CloveAIRModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function WipeSettingsCommand()
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
			Alert.show("Are you sure you want to wipe all of your settings? This action is irreversible.","Wipe Settings",Alert.YES | Alert.NO,null,onSelect);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		private function onSelect(event:CloseEvent):void
		{
			if(event.detail == Alert.NO)
				return;
			
			
			try
			{
				//saved by facebook, and digg to retain session info
				
				var file:File = new File(File.applicationStorageDirectory.nativePath+"/#SharedObjects/");
				file.deleteDirectory(true);	
			}catch(e:*){}
			
			_model.applicationSettings.setNewSettingsDir();
			
			var app:WindowedApplication =
				WindowedApplication(Application.application);
			
			var mgr:ProductManager =
				new ProductManager("airappinstaller");
			
			mgr.launch("-launch " +
				app.nativeApplication.applicationID + " " +
				app.nativeApplication.publisherID);
			
			app.close();

			
		}
	}
}