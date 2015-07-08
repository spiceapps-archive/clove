package com.spice.clove.plugin.core.post.impl.outgoing
{
	import com.spice.clove.post.core.calls.CallCloveAttachmentType;
	import com.spice.clove.post.core.outgoing.ICloveAttachment;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	import flash.net.FileReference;

	public class CloveAttachment extends ProxyOwner implements ICloveAttachment
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _reference:FileReference;
		private var _loadState:int;
//		private var _metadata
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveAttachment(target:FileReference)
		{
			_reference = target;
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
				case CallCloveAttachmentType.GET_ATTACHMENT_LOADING_STATE: return this.respond(c,this.getAttachmentLoadState());
				case CallCloveAttachmentType.SET_ATTACHMENT_LOADING_STATE: return this.setAttachmentLoadState(c.getData());
			}
			
			super.answerProxyCall(c);
		}
		/**
		 */
		
		public function getFileReference():FileReference
		{
			return this._reference;
		}
		
		
		/**
		 */
		
		public function getAttachmentLoadState():int
		{
			return _loadState;
		}
		
		/**
		 */
		
		public function setAttachmentLoadState(value:int):void
		{
			this._loadState = value;
			
			this.notifyChange(CallCloveAttachmentType.GET_ATTACHMENT_LOADING_STATE,value);
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
			
			this.addAvailableCalls([CallCloveAttachmentType.GET_ATTACHMENT_LOADING_STATE,CallCloveAttachmentType.SET_ATTACHMENT_LOADING_STATE]);
		}
		
//		/**
//		 */
//		
//		public function getMetadata():ISettingTable
//		{
//			if(!_metadata)
//			{
//				_metadata = new SettingTable(BasicSettingFactory.getInstance());
//			}
//			
//			return _medata;
//		}
	}
}