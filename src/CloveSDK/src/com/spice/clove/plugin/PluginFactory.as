package com.spice.clove.plugin
{
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.utils.storage.TempSettings;

	
	/*
	  Use this as the parent class for any plugin factories.
	  @author craigcondon
	  
	 */	
	public class PluginFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _metadata:TempSettings;
		private var _sdkVersion:Number = SDKInfo.getVersionNumber();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		
		public function PluginFactory(metadata:Object)
		{
			_metadata = new TempSettings(metadata);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/*
		 */
		
		public function get metadata():INotifiableSettings
		{
			return _metadata;
		}
	}
}