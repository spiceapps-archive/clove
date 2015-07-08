package com.spice.clove.plugin.core.post.impl.models
{
	import com.spice.clove.plugin.core.post.impl.PostPlugin;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.vanilla.flash.singleton.Singleton;
	
	import mx.collections.ArrayCollection;

	public class PostPluginModelLocator extends Singleton
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function PostPluginModelLocator()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public static function getInstance():PostPluginModelLocator
		{
			return Singleton.getInstance(PostPluginModelLocator);
		}
		
		
		
		/**
		 */
		
		public var plugin:PostPlugin;
		
		
		/**
		 * the available initial postables for the post window
		 */	
		
		public var defaultPostables:ArrayCollection = new ArrayCollection();
		
		
		/**
		 */
		
		public var activePostables:ArrayCollection = new ArrayCollection();
		
		/**
		 */
		
		public var menuOptionViewControllers:Vector.<ICloveDataViewController> = new Vector.<ICloveDataViewController>();
	}
}