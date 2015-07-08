package com.spice.clove.commands.pluginService
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.business.PluginDelegate;
	import com.spice.clove.commandEvents.PackerEvent;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	
	public class SavePluginCommand implements ICommand, IResponder
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _delegate:PluginDelegate;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function SavePluginCommand()
		{
			_delegate = new PluginDelegate(this);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function execute(event:CairngormEvent):void
		{
			_delegate.savePlugin(PackerEvent(event).value);
		}
		
		public function result(data:Object):void
		{
		}
		
		
		public function fault(data:Object):void
		{
			Alert.show(FaultEvent(data).fault.toString());
		}

	}
}