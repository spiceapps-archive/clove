package com.spice.clove.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveCueEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.utils.queue.global.GlobalQueueManager;
	
	import mx.controls.Alert;
	
	
	/*
	  adds a cue to Clove's  global Queue manager 
	  @author craigcondon
	  
	 */	
	public class AddCueCommand implements ICommand
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
		 
		
		public function AddCueCommand()
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
			
			var queue:CloveCueEvent = CloveCueEvent(event);
			
			
			GlobalQueueManager.getInstance().getQueueManager(queue.managerName).addCue(queue.cue);
		}

	}
}