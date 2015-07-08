package com.spice.clove.plugin.core.post.impl.outgoing
{
	import com.spice.clove.plugin.core.post.impl.PostPlugin;
	import com.spice.clove.post.core.calls.CallCloveMessageType;
	import com.spice.clove.post.core.outgoing.ICloveAttachment;
	import com.spice.clove.post.core.outgoing.ICloveMessage;
	import com.spice.clove.textCommands.core.calls.CallTextCommandsPluginType;
	import com.spice.core.calls.CallTextCommandTargetType;
	import com.spice.core.text.command.ITextCommandTarget;
	import com.spice.core.text.command.handle.ITextCommandHandler;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	import mx.collections.ArrayCollection;

	public class CloveMessage extends ProxyOwner implements ICloveMessage, ITextCommandTarget
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		public var text:String = "";
		
		
		[Bindable] 
		public var cursor:Number;
		
		[Bindable] 
		public var attachments:ArrayCollection = new ArrayCollection(); //hackish fix to data binding in Flex
		
		
		private var _attachments:Vector.<ICloveAttachment>;
		
		private var _postPlugin:PostPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveMessage(plugin:PostPlugin)
		{
			_attachments = new Vector.<ICloveAttachment>();
			
			_postPlugin = plugin;
			
			
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
				case CallTextCommandTargetType.TEXT_COMMAND_SET_CURSOR: this.cursor = c.getData(); return;
			}
			
			super.answerProxyCall(c);
		}
		
		/**
		 */
		
		public function getText():String
		{
			return this.text.replace(/<[^>]+>/igs,"");//strip all html
		}
		
		
		
		/**
		 */
		
		public function setText(value:String):void
		{
			this.text = value;
			
			
			new ProxyCall(CallTextCommandsPluginType.TEXT_COMMANDS_EVALUATE_WITH_SPACE,_postPlugin.getPluginMediator(),this).dispatch().dispose();
		}
		
		/**
		 */
		
		public function clone():CloveMessage
		{
			var m:CloveMessage = new CloveMessage(_postPlugin);
			m.text = text;
			m._attachments = _attachments;
			return m;
		}
		
		
		
		/**
		 */
		
		public function addAttachment(value:ICloveAttachment):void
		{
			this._attachments.push(value);
			
			this.attachments.addItem(value);
			
			this.notifyChange(CallCloveMessageType.NEW_MESSAGE_ATTACHMENT_ADDED,value);
		}
		
		public function getAttachments():Vector.<ICloveAttachment>
		{
			return this._attachments;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallTextCommandTargetType.TEXT_COMMAND_SET_CURSOR]);
		}
		
	}
}