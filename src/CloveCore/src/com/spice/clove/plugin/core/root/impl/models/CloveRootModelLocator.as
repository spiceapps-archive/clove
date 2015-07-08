package com.spice.clove.plugin.core.root.impl.models
{
	import com.spice.clove.plugin.core.root.impl.CloveRootPlugin;
	import com.spice.clove.plugin.core.root.impl.content.control.IViewableContentController;
	import com.spice.vanilla.flash.singleton.Singleton;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class CloveRootModelLocator extends Singleton
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveRootModelLocator()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public static function getInstance():CloveRootModelLocator
		{
			return Singleton.getInstance(CloveRootModelLocator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public var rootPlugin:CloveRootPlugin;
		
		
		
		
		/**
		 */
		
		public var posterActions:ArrayCollection = new ArrayCollection();
		
		
		
		/**
		 */
		
		public var rootContentController:IViewableContentController;
		
		/**
		 * the service delegates registered by other plugins 
		 */		
		
		public var availableServiceDelegates:ArrayCollection = new ArrayCollection();
		
		/**
		 */
		
		public var headerViews:ArrayCollection = new ArrayCollection();
		public var footerViews:ArrayCollection = new ArrayCollection();
		
	}
}