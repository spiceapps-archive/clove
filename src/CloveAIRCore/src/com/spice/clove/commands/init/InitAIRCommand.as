package com.spice.clove.commands.init
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.command.initialize.InitializeCommand;
	import com.spice.clove.models.CloveAIRModelLocator;
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.calls.CallClovePluginType;
	import com.spice.events.QueueManagerEvent;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.desktop.NativeApplication;

	public class InitAIRCommand extends InitializeCommand
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
		
		public function InitAIRCommand()
		{
			super();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		override public function execute(event:CairngormEvent) : void
		{
			
			this.queue.addCue(new InitPreferences());
			
			super.execute(event);
		}
		
		/*
		 */
		
		override protected function onInitialized(event:QueueManagerEvent) : void
		{
			
			
			NativeApplication.nativeApplication.autoExit = false;
			
			//check for plugin updates
//			new ProxyCall(CallClovePluginType.CHECK_FOR_UPDATES, ClovePluginMediator.getInstance()).dispatch();
			
			super.onInitialized(event);
			
			
		}
		
		
	}
}