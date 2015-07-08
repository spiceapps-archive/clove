package com.spice.clove.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.HolderColumn;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	public class RemoveCloveColumnCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		private var _ev:CloveEvent;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function RemoveCloveColumnCommand()
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
			_ev = CloveEvent(event);
			
			
			var col:ClovePluginColumn = _ev.voData;
			
			
			if(!col)
				return;
			
			
			//if the column doesn't have any feeds, or children, then remove
			//it without prompt
			if(col.children.length == 0)
			{
				col.dispose();
				_ev = undefined;
				return;
			}
			else
			
			//if default column. This is UGLY!!!!
			if(col is HolderColumn && col.children.length == 1)
			{
				if(ClovePluginColumn(HolderColumn(col).children.getItemAt(0)).controller == null)
				{
					col.dispose();
					_ev = undefined;
					return;
				}
			}
			
			var al:Alert = Alert.show("Are you sure you want to remove this item?",
											  "Remove Item",
											  Alert.YES | Alert.CANCEL,
											  null,
											  onClose);

		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onClose(event:CloseEvent):void
		{
			
			if(event.detail == Alert.YES)
			{
				
				ClovePluginColumn(_ev.voData).dispose();
				
			}
			
			_ev = undefined;
			
		}

	}
}