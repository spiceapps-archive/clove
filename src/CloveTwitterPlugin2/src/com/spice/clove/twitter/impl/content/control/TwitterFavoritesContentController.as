package com.spice.clove.twitter.impl.content.control
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.content.control.render.TwitterDataSetting;
	import com.spice.clove.twitter.impl.content.control.render.TwitterFavoritesDataRenderer;
	import com.spice.vanilla.impl.settings.basic.IntSetting;

	public class TwitterFavoritesContentController extends AbstractTwitterContentController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _renderer:TwitterFavoritesDataRenderer;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterFavoritesContentController(name:String,plugin:TwitterPlugin)
		{
			super(name,plugin,(_renderer = new TwitterFavoritesDataRenderer(this,plugin.getPluginMediator())));
			
			this.setName("Favorites");
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function loadNewer2(data:ICloveData=null):void
		{
			_renderer.currentPage = 1;
			
			this.fillonCueComplete(this.getTwitterAccount().connection.getFavorites());
		}
		
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
			
			var page:Number = IntSetting(data.getSettingTable().getSetting(TwitterDataSetting.PAGE)).getData();
			
			_renderer.currentPage = page+1;
			
			
			this.fillonCueComplete(this.getTwitterAccount().connection.getFavorites(null,_renderer.currentPage));
		}
	}
}