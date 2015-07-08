package com.spice.clove.command.initialize
{
	import com.spice.aloe.AloeBugTracker;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.core.events.log.LogEvent;
	import com.spice.utils.logging.ISpiceLogger;
	import com.spice.utils.queue.cue.Cue;
	
	import mx.controls.Alert;
	
	
	/*
	  Monitors logs for Notice, Warning, Error, and Fatal. if Error, or Fatal, they are sent to the server 
	  @author craigcondon
	  
	 */	
	 
	public class InitMonitorLogs extends Cue
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
		 
		
		public function InitMonitorLogs()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function init():void
		{
			
			var logger:Logger = Logger.getInstance();
			
			var n:ISpiceLogger = logger.getLogger(LogType.NOTICE) as ISpiceLogger;
			n.addEventListener(LogEvent.NEW_LOG,onNewLog);
			
			
			
			this.complete();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onNewLog(event:LogEvent):void
		{
			var logger:ISpiceLogger = event.target as ISpiceLogger;
			
		
			//figure out what to do with the log
			switch(logger.type)
			{
				case LogType.NOTICE:
					Alert.show(event.log.message);
				break;
			}
			
		}
	}
}