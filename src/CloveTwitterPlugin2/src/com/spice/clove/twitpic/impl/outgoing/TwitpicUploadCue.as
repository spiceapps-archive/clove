package com.spice.clove.twitpic.impl.outgoing
{
	import com.adobe.serialization.json.JSON;
	import com.architectd.twitter2.TwitterUrls;
	import com.spice.clove.post.core.calls.CallCloveAttachmentType;
	import com.spice.clove.post.core.outgoing.CLoveAttachmentLoadState;
	import com.spice.clove.post.core.outgoing.ICloveAttachment;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.events.DataEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class TwitpicUploadCue extends AbstractCue
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const KEY:String = "29ac7d7353de5c4208134e1dea080723";
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _message:String;
		private var _attachment:ICloveAttachment;
		private var _headers:Array;
		private var _ref:FileReference;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitpicUploadCue(message:String,attachment:ICloveAttachment,oauthHeader:URLRequestHeader)
		{
			_message = message;
			_attachment = attachment;
			
			var header:URLRequestHeader = new URLRequestHeader("X-Auth-Service-Provider",TwitterUrls.TWITTER_URL_ACCOUNT_AUTH);
			
			
//			oauthHeader.value += "realm=\"http://api.twitter.com/\",oauth_version=\"1.0\"";
			
			oauthHeader.name = "X-Verify-Credentials-Authorization";
			_headers = [oauthHeader,header];
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		override public function initialize():void
		{
			super.initialize();
			
			new ProxyCall(CallCloveAttachmentType.SET_ATTACHMENT_LOADING_STATE,_attachment.getProxy(),CLoveAttachmentLoadState.LOADING).dispatch().dispose();
			
			
			var request:URLRequest = new URLRequest("http://api.twitpic.com/2/upload.json");
			
			var vars:URLVariables = new URLVariables();
			vars.key = KEY;
//			vars.message = "message";
		
			request.data = vars;
			request.method = URLRequestMethod.POST;
			request.requestHeaders = this._headers;
  
			
			
			_ref = this._attachment.getFileReference();
			_ref.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,onUpload);
			_ref.addEventListener(ProgressEvent.PROGRESS,onUploadProgress);
			_ref.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			_ref.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,onResponseStatus);
			_ref.addEventListener(HTTPStatusEvent.HTTP_STATUS,onResponseStatus);
			_ref.upload(request,"media");
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override protected function complete(status:*=true):void
		{
			this.removeEventListeners();
			
			new ProxyCall(CallCloveAttachmentType.SET_ATTACHMENT_LOADING_STATE,_attachment.getProxy(),status ? CLoveAttachmentLoadState.COMPLETE : CLoveAttachmentLoadState.ERROR).dispatch().dispose();
			
			super.complete(status);
		}
		
		
		/**
		 */
		
		private function onUpload(event:DataEvent):void
		{
			this.removeEventListeners();
			
			var data:Object = JSON.decode(event.data);
			this.complete(data.url);
		}
		
		/**
		 */
		
		private function onIOError(event:IOErrorEvent):void
		{
			this.removeEventListeners();
			
			
			Logger.log("error:"+event.errorID+" "+event.type+" "+event.text,this);
		
			
			this.complete(false);
		}
		/**
		 */
		
		private function onUploadProgress(event:ProgressEvent):void
		{
			Logger.log("uploading:"+event.bytesLoaded/event.bytesTotal*100,this);
		}
		
		/**
		 */
		
		private function onResponseStatus(event:HTTPStatusEvent):void
		{
			Logger.log(event.toString(),this);
		}
		
		
		/**
		 */
		
		private function removeEventListeners():void
		{
			
			_ref.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,onUpload);
			_ref.removeEventListener(ProgressEvent.PROGRESS,onUploadProgress);
			_ref.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
			_ref.removeEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,onResponseStatus);
		}
	}
}