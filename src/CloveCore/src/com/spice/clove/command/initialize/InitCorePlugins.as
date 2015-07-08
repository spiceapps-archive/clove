package com.spice.clove.command.initialize
{
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.load.IInstalledPluginFactoryInfo;
	import com.spice.utils.queue.cue.Cue;
	
	public class InitCorePlugins extends Cue implements IInitializer
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function InitCorePlugins()
		{
			
			for each(var i:IInstalledPluginFactoryInfo in this._model.corePluginModel.corePlugins.source)
			{
				new CloveEvent(CloveEvent.ADD_CORE_PLUGIN,i).dispatch();
			}
			
//			new CloveEvent(CloveEvent.ADD_CORE_PLUGIN,CloveShoutPlugin).dispatch();
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		public function get completeMessage():String
		{
			return "loaded core plugins";
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function init():void
		{
			
			
			;
			
			
			this.complete();
		}
		
		
		
		
		

	}
}