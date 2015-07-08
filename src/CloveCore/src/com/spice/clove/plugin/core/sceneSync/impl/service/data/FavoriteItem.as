package com.spice.clove.plugin.core.sceneSync.impl.service.data
{
	import com.adobe.serialization.json.JSON;

	public class FavoriteItem
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public var id:Number;
		public var name:String;
		public var description:String;
		public var datePosted:Date;
		public var createdAt:Date;
		public var metadata:Object = {};
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FavoriteItem()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public static function fromXML(value:*):FavoriteItem
		{
			var fav:FavoriteItem = new FavoriteItem();
			fav.id = value.id;
			fav.name = value.name;
			fav.description = value.description;
			fav.datePosted = new Date(value.datePosted);
			fav.createdAt = new Date(value.createdAt);
			
			for each(var meta:* in value.metadata)
			{
				fav.metadata[meta.@type] = meta.toString();
			}
			
			return fav;
		}
	}
}