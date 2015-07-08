package com.spice.launcher.cue
{
	import com.spice.launcher.models.CloveLauncherModelLocator;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class DownloadAIRLauncherCue extends Cue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _loader:Loader = new Loader();
		
		
		[Bindable] 
		private var _model:CloveLauncherModelLocator = CloveLauncherModelLocator.getInstance();
		
		private var _url:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function DownloadAIRLauncherCue(url:String)
		{
			_url = url;
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
			Logger.log("DownloadAirLauncherCue::init()");
			var context:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			_loader.contentLoaderInfo.addEventListener(Event.INIT,onInit,false,0,true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError,false,0,true);
			_loader.load( new URLRequest(_url),context);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onInit(event:Event):void
		{
			
			Logger.log("DownloadAIRLauncherCue::success!");
			
			
			event.currentTarget.removeEventListener(event.type,onInit);
			
			_model.airSWF = _loader.content;
			
			
			
			switch(_model.airSWF.getStatus())
			{
				case "available":
					Logger.log("AIR is available");
				break;
				case "unuavailable":
					Logger.log("AIR is not available",LogType.WARNING);
				break;
				case "installed":
					Logger.log("AIR is already installed.");
				break;
			}
			
			this.complete();
		}
		
		/**
		 */
		
		public function onError(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onError);
			
			Logger.log("Could not launch AIR application."+event.type,LogType.ERROR);
			
		}

	}
}