package com.spice.clove.post.impl.outgoing
{
	import com.spice.clove.post.core.calls.CallCloveAttachmentUploaderType;
	import com.spice.clove.post.core.outgoing.ICloveAttachment;
	import com.spice.clove.post.core.outgoing.ICloveAttachmentUploader;
	import com.spice.core.queue.ICue;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	/**
	 * abstract implementation of the attachment uploader. this can be re-written 
	 * @author craigcondon
	 * 
	 */	
	public class AbstractAttachmentUploader extends ProxyOwner implements ICloveAttachmentUploader
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		private var _plugin:IProxyOwner;
		private var _supportedFileTypes:Vector.<String>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AbstractAttachmentUploader(name:String,supportedFileTypes:Array)
		{
			this._name = name;
			
			var n:int = supportedFileTypes.length;
			
			this._supportedFileTypes = new Vector.<String>(n);
			
			for(var i:int = 0; i < n; i++)
			{
				this._supportedFileTypes[i] = supportedFileTypes[i];
			}
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
				case CallCloveAttachmentUploaderType.GET_OWNER: return this.respond(c,this.getOwner());
				case CallCloveAttachmentUploaderType.SET_OWNER: return this.setOwner(c.getData());
					
			}
			
			super.answerProxyCall(c);
		}
		/**
		 */
		
		public function getName():String
		{
			return this._name;
		}
		
		
		/**
		 */
		
		public function getSupportedFileTypes():Vector.<String>
		{
			return this._supportedFileTypes;
		}
		
		/**
		 */
		
		public function upload(value:ICloveAttachment):ICue
		{
			//abstract
			return null;
		}
		
		
		/**
		 */
		public function getOwner():IProxyOwner
		{
			return this._plugin;
		}
		
		/**
		 */
		
		public function setOwner(value:IProxyOwner):void
		{
			this._plugin = value;
			this.notifyChange(CallCloveAttachmentUploaderType.GET_OWNER,value);
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
			
			this.addAvailableCalls([CallCloveAttachmentUploaderType.GET_OWNER,
									CallCloveAttachmentUploaderType.SET_OWNER]);
		}
	}
}