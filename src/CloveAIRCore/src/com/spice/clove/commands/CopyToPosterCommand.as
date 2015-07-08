package com.spice.clove.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.models.CloveAIRModelLocator;
	
	public class CopyToPosterCommand implements ICommand
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
		 
		public function CopyToPosterCommand()
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
			
//			_model.messageModel.clipboardText = ev.voData;
		}

	}
}