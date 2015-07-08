package com.spice.clove.controllers
{
	import com.spice.clove.controls.CloveCoreController;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.core.WebRootPlugin;
	import com.spice.clove.plugin.twitter.CloveTwitterPluginFactory;
	import com.spice.clove.settings.CloveWebSettings;
	import com.spice.clove.switchClass.*;
	import com.spice.utils.classSwitch.ClassSwitcher;
	
	import mx.collections.ArrayCollection;
	
	public class CloveWebController extends CloveCoreController
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CloveWebController()
		{
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function initClassSwaps():void
		{
			super.initClassSwaps();
			
			ClassSwitcher.registerSwapClass(CloveWebSettings,SCloveSettings);
			ClassSwitcher.registerSwapClass(WebRootPlugin,SRootPlugin);
			
		}
		
		/**
		 */
		
		override protected function initApplication():void
		{
			
			var model:CloveModelLocator = CloveModelLocator.getInstance();
			model.corePluginModel.corePlugins.addAll(new ArrayCollection([CloveTwitterPluginFactory]));
			
			
			
			super.initApplication();
		}

	}
}