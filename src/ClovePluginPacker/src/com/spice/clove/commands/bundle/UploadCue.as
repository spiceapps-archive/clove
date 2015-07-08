package com.spice.clove.commands.bundle
{
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.clove.vo.PluginVO;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.events.DataEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.controls.Alert;
	
	public class UploadCue extends Cue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		[Bindable] 
		private var _vo:PluginVO;
		
		private var _idCue:NewBundleCue;
		
		
		[Bindable] 
		private var _model:PackerModelLocator = PackerModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function UploadCue(vo:PluginVO,idCue:NewBundleCue)
		{
			_vo = vo;
			_idCue = idCue;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function init():void
		{
			var request:URLRequest = new URLRequest(_model.configModel.bundle_upload);
			request.method = URLRequestMethod.POST;
			
			var vars:URLVariables = new URLVariables();
			vars.username = _model.userModel.currentUser.username;
			vars.password = _model.userModel.currentUser.password;
			vars.bundleID = _idCue.id;
			
			request.data = vars;
			
			_vo.reference.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,onFileComplete);
			_vo.reference.addEventListener(ProgressEvent.PROGRESS,onProgress);
			
			_vo.reference.upload(request);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onFileComplete(event:DataEvent):void
		{
			
		
			
			
			event.currentTarget.removeEventListener(event.type,onFileComplete);
			event.currentTarget.removeEventListener(ProgressEvent.PROGRESS,onProgress);
			
			_vo.uploadProgess = 100;
			this.complete();
		}
		
		/**
		 */
		
		private function onProgress(event:ProgressEvent):void
		{
			_vo.uploadProgess = event.bytesLoaded/event.bytesTotal * 100;
		}

	}
}