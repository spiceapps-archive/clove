package com.spice.clove.post.impl.outgoing
{
	import com.spice.clove.plugin.core.calls.CallClovePostableType;
	import com.spice.clove.post.core.outgoing.ICloveAttachment;
	import com.spice.clove.post.core.outgoing.ICloveMessage;
	import com.spice.clove.post.core.outgoing.IClovePostable;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;

	public class AbstractClovePostable extends AbstractCue implements IClovePostable
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		private var _message:ICloveMessage;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AbstractClovePostable(name:String = null)
		{
			_name = name;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallClovePostableType.GET_NAME: return this.respond(call,this.getName());
				case CallClovePostableType.PREPARE_ATTACHMENT: return this.prepareAttachment(call.getData());
			}
			super.answerProxyCall(call);
		}
		
		/**
		 */
		
		public function getName():String
		{
			return _name;
		}
		
		/**
		 */
		
		public function setName(value:String):void
		{
			this._name = value;
			
			this.notifyChange(CallClovePostableType.GET_NAME,value);
		}
		
		
		
		/**
		 */
		
		public function setMessage(value:ICloveMessage):void
		{
			this._message = value;
		}
		
		/**
		 */
		
		public function getMessage():ICloveMessage
		{
			return this._message;
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
			
			this.addAvailableCalls([ CallClovePostableType.GET_NAME,
									 CallClovePostableType.PREPARE_ATTACHMENT,
									 CallClovePostableType.GET_PROCESSING_ATTACHMENT]);
		}
		
		/**
		 */
		
		protected function prepareAttachment(n:ICloveAttachment):void
		{
			//abstract
		}
		
		/**
		 */
		
		protected function post(m:ICloveMessage):void
		{
			//abstract
		}
	}
}