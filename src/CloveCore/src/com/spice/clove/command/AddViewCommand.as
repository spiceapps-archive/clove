package com.spice.clove.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.model.CloveModelLocator;
	
	public class AddViewCommand implements ICommand
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
		 
		
		public function AddViewCommand()
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
			switch(event.type)
			{
				case CloveEvent.SET_MAIN_HEADER_VIEW:
					_model.navModel.baseHeader = CloveEvent(event).voData;
				break;
				case CloveEvent.ADD_FOOTER_VIEW:
					_model.navModel.additionalFooters.addItem(CloveEvent(event).voData);
				break;
			}
		}

	}
}