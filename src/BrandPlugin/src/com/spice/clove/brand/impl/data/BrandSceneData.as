package com.spice.clove.brand.impl.data
{
	import com.spice.clove.sceneSync.core.service.data.SceneData;
	import com.spice.clove.sceneSync.core.service.data.SceneSubscriptionData;

	public class BrandSceneData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var scene:SceneData;
		public var subscribed:Boolean;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function BrandSceneData(scene:SceneData,subscribed:Boolean = false)
		{
			this.scene = scene;
			this.subscribed = subscribed;
		}
		
		
	}
}