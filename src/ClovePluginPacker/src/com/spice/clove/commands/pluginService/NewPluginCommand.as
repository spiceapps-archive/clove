package com.spice.clove.commands.pluginService
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.business.PluginDelegate;
	import com.spice.clove.commandEvents.PackerEvent;
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.clove.plugin.compiled.CompiledPluginInfo;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	
	public class NewPluginCommand implements ICommand, IResponder
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Bindable] 
		private var _model:PackerModelLocator = PackerModelLocator.getInstance();
		
		private var _delegate:PluginDelegate;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function NewPluginCommand()
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
			var dat:CompiledPluginInfo = CompiledPluginInfo(PackerEvent(event).value);
			
			_delegate.newPlugin(dat);
		}
		
		
        /**
		 */
		
		public function result(data:Object):void
		{
			new PackerEvent(PackerEvent.LOAD_PLUGINS).dispatch();
		}
		
		/**
		 */
		
		public function fault(data:Object):void
		{
			Alert.show(FaultEvent(data).fault.faultString);
		}

	}
}