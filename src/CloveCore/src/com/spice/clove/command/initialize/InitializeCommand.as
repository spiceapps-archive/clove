package com.spice.clove.command.initialize
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.ei.patterns.observer.Notification;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.commands.init.InitCommand;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.events.QueueManagerEvent;
	
	import flash.display.DisplayObject;
	import flash.utils.setTimeout;
	
	import mx.core.Application;
	
	public class InitializeCommand extends InitCommand
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
		 
		
		public function InitializeCommand()
		{
			
			super(_model.initModel);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function execute(event:CairngormEvent):void
		{
			
			
			_model.applicationSettings.registerUIManager(DisplayObject(Application.application),"root");
			
			
			//set the loading message in the model
			_model.initModel.currentMessage = "initializing";
			
			
//			this.addCue(new InitListenForFileTypes());
			
			//initialize the log monitor
//			this.addCue(new InitMonitorLogs());
			
			
//			this.addCue(new InitPreferences());
			
			
			this.addCue(new InitCorePlugins());
			
			
			//load in the plugins
			this.addCue(new InitPlugins());
			
			
			
			//this.addCue(new InitTextReplacements());
			
			
			super.execute(null);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
     
        /*
		 */
		
		override protected function onCue(event:QueueManagerEvent):void
		{
			
			;
			
			
		}
		
		/*
		 */
		
		override protected function onInitialized(event:QueueManagerEvent):void
		{
			
			//men.setItemIndex(nm.menu.getItemAt(0),0);
			
			
			_model.initModel.currentMessage = "complete";
			
			//refresh the columns finally, but give some buffer time so that the CPU doesn't choke under the load
			
			
			//setTimeout(this._model.columnModel.refreshAll,3000);
			
			
			super.onInitialized(event);
		}
		

	}
}