package com.spice.clove.control
{
	import com.spice.clove.command.*;
	import com.spice.clove.commandEvents.*;
	import com.spice.clove.controls.CloveAIRController;
	
	public class CloveAppController extends CloveAIRController
	{
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function initApplication():void
		{
			new CloveInit();
			
			super.initApplication();
		}
		
	}
}