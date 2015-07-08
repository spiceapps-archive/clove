package com.spice.clove.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.NotificationEvent;
	import com.spice.clove.model.CloveModelLocator;
	
	public class AddNotificationCommand implements ICommand
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
		 
		
		public function AddNotificationCommand()
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
			var ev:NotificationEvent = NotificationEvent(event);
			
			Logger.log("AddNotificationCommand::execute");
			
			//_model.notificationManager.addNotification(new Notification(ev.title,ev.message,ev.icon));
		}

	}
}