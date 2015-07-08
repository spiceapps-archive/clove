package com.spice.clove.plugin.control.cue
{
	import com.spice.clove.events.plugin.InstalledPluginEvent;
	import com.spice.clove.plugin.load.IInstalledPluginFactoryInfo;
	import com.spice.clove.plugin.load.PluginInstallationManager;
	import com.spice.display.controls.list.ImpatientCue;
	
	
	/*
	  loads the plugin into the app. NOTE: sometimes the plugin may throw an exception, so we have the cue as an impatient cue. after 4 seconds the cue will complete regardless
	  if the plugin has loaded or not 
	  @author craigcondon
	  
	 */	
	public class LoadFactoryCue extends ImpatientCue
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _plugin:IInstalledPluginFactoryInfo;
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const MAX_WAIT_TIME:int = 4000;//four seconds
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function LoadFactoryCue(plugin:IInstalledPluginFactoryInfo)
		{
			super(MAX_WAIT_TIME);
			
			
			
			_plugin  = plugin;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override protected function init2():void
		{
			
			if(_plugin.loadedPluginFactory)
			{
				
				this.complete();
				return;
			}	
			
			
			try
			{
				_plugin.addEventListener(InstalledPluginEvent.PLUGIN_LOADED,onPluginLoaded,false,0,true);
			
				_plugin.loadPluginFactory();
			}catch(e:Error)
			{
				Logger.logError(e,LogType.FATAL);
				
				this.onWait();
			}
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		override protected function onWait():void
		{
			super.onWait();
			
			
			try
			{
				throw new Error("Whoops, it looks like "+this._plugin+" didn't load correctly");
			}
			catch(e:Error)
			{
				Logger.logError(e);
			}
			
		}
		
		
        /*
		 */
		
		private function onPluginLoaded(event:InstalledPluginEvent):void
		{
			
			event.currentTarget.removeEventListener(event.type,onPluginLoaded);
			
			;
			
			//once loaded, we can stop the timer since there is no problem reading the SWF
			stopTimer();
			
			
			this.complete();
			
			
			//this._plugin = undefined;
		}
		

	}
}