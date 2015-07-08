package com.spice.clove.commands.init
{
	import com.spice.clove.model.PackerModelLocator;
	import com.spice.clove.model.ConfigModel;
	import com.spice.utils.queue.cue.Cue;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class InitConfig extends Cue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Bindable] 
		private var _model:PackerModelLocator = PackerModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function InitConfig()
		{
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
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onConfig);
			loader.load(new URLRequest(ConfigModel.CONFIG_FILE));
			
			_model.configModel.currentMessage = "loading config";
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onConfig(event:Event):void
		{
			event.currentTarget.removeEventListener(event.type,onConfig);
			
			var script:XML = new XML(event.target.data);
			
			_model.configModel.gateway = script.gateway;
			_model.configModel.bundle_upload = script.bundle_upload;
			
			
			this.complete();
			
			
		}
		
		
		

	}
}