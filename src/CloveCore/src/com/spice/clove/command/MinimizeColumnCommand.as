package com.spice.clove.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.model.CloveModelLocator;
	
	public class MinimizeColumnCommand implements ICommand
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
		 
		
		public function MinimizeColumnCommand()
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
			
		Logger.log("MinimizeColumnCommand::execute()");
			var ev:CloveEvent = CloveEvent(event);
			
			var stack:Array = _model.applicationSettings.getMinimzedColumns();
			
			if(!stack)
				stack = new Array();
				
			var item:Object = new Object();
			
			stack.push(item);
			
			item.label = ev.voData.title;
			item.data  = ev.voData.toByteArray();
			
			
			_model.applicationSettings.minimizeColumn(stack);
			
			new CloveEvent(CloveEvent.LOAD_MINIMIZED).dispatch();
		}

	}
}