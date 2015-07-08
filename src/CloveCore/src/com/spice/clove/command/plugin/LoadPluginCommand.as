package com.spice.clove.command.plugin
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.load.InternalInstalledPluginFactoryInfo;
	import com.spice.commands.init.InitCommand;
	import com.spice.utils.queue.QueueManager;
	import com.spice.utils.queue.global.GlobalQueueManager;
	
	import flash.events.EventDispatcher;
	
	
	/*
	  called when the application is initialized. It throws the plugins in a queue so that any other plugins
	  loaded after have to wait. This usually pertains to Core plugins __only__. (InstallerPlugin) 
	  @author craigcondon
	  
	 */	
	public class LoadPluginCommand extends EventDispatcher implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		private var _event:CloveEvent;
		
		
		/*
		  sometimes the plugin may need to initialize some data before continueing to the next plugins. This 
		  may include the synchronization service, or even the clove installer.
		 */
		 
		private var _queue:QueueManager;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function LoadPluginCommand()
		{
			
			//get the initializing QueueManager incase the plugin being added is on init
			_queue = GlobalQueueManager.getInstance().getQueueManager(InitCommand.INIT_QUEUE);
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
			
			this.addCorePlugin(CloveEvent(_event).voData);
		}
	
		/*
		 */
		
		private function addCorePlugin(info:InternalInstalledPluginFactoryInfo):void
		{
			_queue.addCue(_model.applicationSettings.pluginManager.loadCorePlugin(info));
			
			
		}
	}
}