package com.spice.clove.plugin.core.textCommands.impl
{
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.textCommands.core.calls.CallTextCommandsPluginType;
	import com.spice.core.text.command.ITextCommandTarget;
	import com.spice.core.text.command.handle.ITextCommandHandler;
	import com.spice.impl.text.command.TextCommandManager;
	import com.spice.impl.text.command.TextCommandTarget;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	
	import mx.core.Application;

	public class TextCommandsPlugin extends ClovePlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _manager:TextCommandManager;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TextCommandsPlugin(factory:TextCommandsPluginFactory)
		{
			super("Text Commands","com.spice.clove.plugin.core.textCommands",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{
				case CallTextCommandsPluginType.TEXT_COMMANDS_REGISTER_INPUT_EVALUATOR: return this.addInputHandler(c.getData());
				case CallTextCommandsPluginType.TEXT_COMMANDS_EVALUATE: return this.evaluateTarget(c.getData());
				case CallTextCommandsPluginType.TEXT_COMMANDS_EVALUATE_WITH_SPACE: return this.evaluateTargetWithSpace(c.getData());
			}
			
			super.answerProxyCall(c);
		}
		
		/**
		 */
		
		public function addInputHandler(value:ITextCommandHandler):void
		{
			_manager.addTextHandler(value);
		}
		
		/**
		 */
		
		public function evaluateTarget(value:ITextCommandTarget):void
		{
			_manager.replaceText(value);
		}
		
		/**
		 */
		
		public function evaluateTargetWithSpace(value:ITextCommandTarget):void
		{
			if(value.getText().charAt(value.getText().length-1) != " ")
				return;
			

			_manager.replaceText(value);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();
			
			//add the default input handlers
			_manager = new TextCommandManager();
			
			this.finishInitialization();
		}
		
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
		}
		
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallTextCommandsPluginType.TEXT_COMMANDS_REGISTER_INPUT_EVALUATOR,CallTextCommandsPluginType.TEXT_COMMANDS_EVALUATE,CallTextCommandsPluginType.TEXT_COMMANDS_EVALUATE_WITH_SPACE]);
		}
	}
}