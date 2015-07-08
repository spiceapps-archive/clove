package com.spice.clove.command.plugin
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.service.CloveConnection;
	import com.spice.clove.service.vo.PluginVO;
	import com.spice.remoting.amfphp.cue.ServiceCue;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;
	
	public class DownloadAndInstallPluginCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		
		private var _stream:URLStream;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function DownloadAndInstallPluginCommand()
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
			Logger.log("InstallPluginCommand::Installing");
			
			
			var ev:CloveEvent = CloveEvent(event);
			
			
			var pluginID:String    = ev.voData;
			
			var cue:ServiceCue = CloveConnection.getInstance().pluginDelegate.getPluginById(pluginID);
			cue.addEventListener(ResultEvent.RESULT,onResult);
			
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function onResult(ev:ResultEvent):void
		{
						
			var plug:PluginVO = new PluginVO();
			plug.fromObject(ev.message.body);
			
			
			Alert.show("Downloading "+plug.name+" extension.");
			
			_stream = new URLStream();
			_stream.addEventListener(Event.COMPLETE,onPluginDownloaded);
			_stream.load(new URLRequest(plug.filePath));
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onPluginDownloaded(event:Event):void
		{
			Logger.log("InstallPluginCommand::onPluginDownloaded()");
			
			event.target.removeEventListener(event.type,onPluginDownloaded);
			
			
			
			var ba:ByteArray = new ByteArray();
			
			_stream.readBytes(ba);
			
			
			new CloveEvent(CloveEvent.INSTALL_PLUGIN_WITH_CONFIRM,ba).dispatch();
		}
		
		

	}
}