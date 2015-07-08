package com.spice.clove.plugin.core.sceneSync.impl.service.data
{
	public class FavoritesCategory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var name:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FavoritesCategory(categoryName:String)
		{
			this.name = categoryName;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public static function fromXML(value:*):FavoritesCategory
		{
			return new FavoritesCategory(value);
		}
	}
}