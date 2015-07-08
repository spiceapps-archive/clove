package com.spice.clove.settings
{
	import com.spice.clove.core.storage.CloveSettings;
	import com.spice.utils.storage.SharedObjectSettings;
	
	public class CloveWebSettings extends CloveSettings
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CloveWebSettings(name:String = "Clove")
		{
			super(name,new SharedObjectSettings(name));
		}

	}
}