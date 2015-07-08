package com.spice.clove.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.models.CloveAIRModelLocator;
	import com.spice.monkeyPatch.menu.MenuItem;

	public class AddPosterActionCommand implements ICommand
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
		
		public function AddPosterActionCommand()
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
			
			
			var me:* = ev.voData;
			
			/*for each(var me2:* in _model.messageModel.posterActions.source)
			{
				
				//don't add any dupes
				if(me2.label == me.label)
					return;
			}
			
			_model.messageModel.posterActions.addItem(me);*/
			
		}
	}
}