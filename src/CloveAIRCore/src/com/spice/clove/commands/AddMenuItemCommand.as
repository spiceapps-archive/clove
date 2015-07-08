package com.spice.clove.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.AddMenuItemEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.models.CloveAIRModelLocator;
	
	public class AddMenuItemCommand implements ICommand
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
		 
		
		 
		
		public function AddMenuItemCommand()
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
			var ev:AddMenuItemEvent = AddMenuItemEvent(event);
			
			
			_model.menuModel.addMenuItem(ev.parentName,ev.menuItem);
		}
	}
}