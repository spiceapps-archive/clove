package com.spice.clove.plugin.facebook.postable
{
	import com.facebook.commands.photos.UploadPhoto;
	import com.spice.clove.plugin.facebook.CloveFacebookPlugin;
	import com.spice.clove.plugin.facebook.cue.FacebookCallCue;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.system.LoaderContext;
	
	public class FacebookPhotoPoster
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _file:File;
		private var _caption:String;
		private var _plugin:CloveFacebookPlugin;
		private var _callback:Function;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FacebookPhotoPoster(caption:String,file:File,plugin:CloveFacebookPlugin,callback:Function)
		{
			_plugin  = plugin;
			_file = file;
			_caption = caption;
			_callback = callback;
			
			
			_file.addEventListener(Event.COMPLETE,onFileLoad);
			_file.load();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onFileLoad(event:Event):void
		{
			event.target.removeEventListener(event.type,onFileLoad);
			
			var ld:Loader = new Loader();
			
			var context:LoaderContext = new LoaderContext();
			context.allowLoadBytesCodeExecution = true;
			
			
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoad);
			
			ld.loadBytes(_file.data,context);
			
			
		}
		
		
		/**
		 */
		
		private function onImageLoad(event:Event):void
		{
			event.target.removeEventListener(event.type,onImageLoad);
			
			var info:LoaderInfo = LoaderInfo(event.target);
			
			
			this._plugin.call(new FacebookCallCue(new UploadPhoto(Bitmap(info.content).bitmapData,null,_caption),_callback));
		}

	}
}