package com.spice.clove.plugin.core.sceneSync.impl.service.call.bugs
{
	import com.spice.clove.plugin.core.sceneSync.impl.service.CloveUrls;
	import com.spice.clove.plugin.core.sceneSync.impl.service.call.CloveServiceCall;
	import com.spice.clove.plugin.core.sceneSync.impl.service.dataHandler.CloveBugDataHandler;
	import com.architectd.service.loaders.UploadLoader;
	
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.net.FileReference;
	import flash.net.URLRequestMethod;
	
	[Event(name="progress",type="flash.events.ProgressEvent")]
	
	public class BugReportCall extends CloveServiceCall
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		[Bindable] 
		[Setting]
		public var title:String;
		
		[Bindable] 
		[Setting]
		public var description:String;
		
		[Bindable]
		[Setting]
		public var priority:String;
		
		[Bindable] 
		[Setting]
		public var replyTo:String;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function BugReportCall(title:String,description:String,priority:String,replyTo:String,settings:FileReference = null)
		{
			if(settings)
			{
				var uploader:UploadLoader = new UploadLoader(settings,"settings");
				uploader.addEventListener(ProgressEvent.PROGRESS,onProgress);
			}
			
			this.title 		 = title;
			this.priority    = priority;
			this.description = description;
			this.replyTo     = replyTo;
			CloveUrls.BUGS_NEW_URL;
			//var url:String = "http://architectd.com";
			super(CloveUrls.BUGS_NEW_URL,new CloveBugDataHandler(),URLRequestMethod.POST,uploader);
			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
	
		private function onProgress(event:ProgressEvent):void
		{
			this.dispatchEvent(event.clone());
		}
		
		
	}
}