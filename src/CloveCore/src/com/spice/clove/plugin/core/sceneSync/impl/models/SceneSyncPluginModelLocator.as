package com.spice.clove.plugin.core.sceneSync.impl.models
{
	import com.spice.clove.plugin.core.sceneSync.impl.SceneSyncPlugin;
	import com.spice.vanilla.flash.singleton.Singleton;
	
	import mx.collections.ArrayCollection;

	[Bindable] 
	public class SceneSyncPluginModelLocator extends Singleton
	{
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public static function getInstance():SceneSyncPluginModelLocator
		{
			return Singleton.getInstance(SceneSyncPluginModelLocator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var plugin:SceneSyncPlugin;
		
		
		
		public var scenes:ArrayCollection = new ArrayCollection();
		
		
		
	}
}