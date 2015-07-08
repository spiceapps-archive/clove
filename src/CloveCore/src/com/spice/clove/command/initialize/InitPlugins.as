package com.spice.clove.command.initialize
{
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.utils.queue.QueueManager;
	import com.spice.utils.queue.cue.Cue;
	
	
	/*
	  loads in the plugins stored application storage
	 */
	 
	public final class InitPlugins extends Cue implements IInitializer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		private var _queue:QueueManager;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function InitPlugins()
		{
			
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
			return "loaded initial Plugins";
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

			_model.applicationSettings.pluginManager.loadPlugins();
			
			this.complete();
		}
	}
}