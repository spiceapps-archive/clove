package com.spice.clove.commands.plugin
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.plugin.compiled.CompiledPlugin;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	
	/*
	  cplugin confirmation prompt 
	  @author craigcondon
	  
	 */	
	 
	public class InstallPluginWithConfirmCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _data:*;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function InstallPluginWithConfirmCommand()
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
			var ev:CloveEvent = CloveEvent(event);
			
			
			var fdata:* = ev.voData;
			var data:*;
			var message:String = "You are about to install a Clove plugin, would you like to continue?";
			
			
			if(fdata is File)
			{
				var stream:FileStream= new FileStream();
				stream.open(fdata,FileMode.READ);
				
				data = new ByteArray();
				stream.readBytes(data);
			}
			else
			{
				data = fdata;
			}
			
			//if is a cplugin file
			if(data is ByteArray)
			{
				
				var cplug:CompiledPlugin;
				
				_data = cplug = data.readObject();
				
				
				message = "You are about to install "+cplug.pluginInfo.name+", would you like to continue?";
				
				
			}
			else
			{
				_data = data;
			}
			
			Alert.show(message,"Install Clove Plugin",Alert.YES | Alert.NO,null,onClose);
			
		}
		
		/*
		 */
		
		private function onClose(event:CloseEvent):void
		{
			if(event.detail == Alert.YES)
			{
				new CloveEvent(CloveEvent.INSTALL_PLUGIN,_data).dispatch();
			}
		}

	}
}