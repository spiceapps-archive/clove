package com.spice.clove.nectars.impl.data.attachment
{
	import com.adobe.serialization.json.JSON;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.calls.CallCloveDataType;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.content.data.meta.ICloveMetadata;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.content.data.attachment.VisibleCloveDataAttachment;
	import com.spice.clove.plugin.impl.icons.attachment.AttachmentIcons;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class NectarsDataAttachment extends VisibleCloveDataAttachment
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _link:String;
		private var _expanded:Boolean;
		private var _mediator:IProxyMediator;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function NectarsDataAttachment(type:String,viewController:ICloveDataViewController,mediator:IProxyMediator)
		{
			super(type,viewController);
			
//			this.setIcon(AttachmentIcons.LINK);
			
			_mediator = mediator;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getLink():String
		{
			return _link;
		}
		
		/**
		 */
		
		public function setLink(value:String):void
		{
			this._link = value ? value : "";
			
			if(!value)
				this._expanded = true;
			
			
//			this.setLabel(value);
		}
		/**
		 */
		
		override public function setMetadata(value:ICloveMetadata):void
		{
			super.setMetadata(value);
			
			if(_expanded)
				return;
			
			//expand the url
			
			var request:URLRequest = new URLRequest("http://api.longurl.org/v2/expand");
			var data:URLVariables = new URLVariables();
			data.url = this._link;
			data.format = "json";
			request.method = URLRequestMethod.GET;
			request.data = data;
			
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE,onUrlExpanded,false,0,true);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onIOError,false,0,true);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function visibleAttachmentClick():void
		{
			super.visibleAttachmentClick();
			
			new ProxyCall(CallAppCommandType.NAVIGATE_TO_URL,this._mediator,this._link).dispatch().dispose();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onIOError(event:Event):void
		{
			
		}  
		/**
		 */
		
		private function onUrlExpanded(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onUrlExpanded);
			
			this._expanded = true;
			
			var longUrl:String = JSON.decode(event.target.data)["long-url"];
			
			
			this.setLink(longUrl);
			
			
			
//			new ProxyCall(CallNectarsPluginType.TRANFORM_URL_TO_NECTAR,this._mediator,new TransformUrlToNectarCallData(this.getData(),longUrl)).dispatch().dispose();
//			new ProxyCall(CallCloveDataType.UPDATE_CLOVE_DATA,super.getData().getProxy()).dispatch().dispose();
		}
	}
}