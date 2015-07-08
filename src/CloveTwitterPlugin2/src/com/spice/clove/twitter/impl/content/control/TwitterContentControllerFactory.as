package com.spice.clove.twitter.impl.content.control
{
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerFactory;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.content.control.search.TwitterKeywordSearchContentController;
	import com.spice.clove.twitter.impl.content.control.search.TwitterUserSearchContentController;

	public class TwitterContentControllerFactory extends CloveContentControllerFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:TwitterPlugin;
		private var _publicFeeds:Vector.<String>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterContentControllerFactory(plugin:TwitterPlugin)
		{
			var avail:Vector.<String> = new Vector.<String>(6,true);
			_publicFeeds = new Vector.<String>(2,true);
			avail[0] = TwitterContentControllerType.DIRECT_MESSAGES;
			avail[1] = TwitterContentControllerType.FAVORITES;
			avail[2] = TwitterContentControllerType.MENTIONS;
			avail[3] = _publicFeeds[0] = TwitterContentControllerType.KEYWORD_SEARCH;
			avail[4] = TwitterContentControllerType.TIMELINE;
			avail[5] = _publicFeeds[1] = TwitterContentControllerType.USER_SEARCH;
			
			super(avail);
			
			_plugin = plugin;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getAvailablePublicFeeds():Vector.<String>
		{
			return this._publicFeeds;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getNewContentController(name:String):ICloveContentController
		{
			switch(name)
			{
				case TwitterContentControllerType.USER_SEARCH: return new TwitterUserSearchContentController(name,this._plugin);
				case TwitterContentControllerType.KEYWORD_SEARCH: return new TwitterKeywordSearchContentController(name,this._plugin);
				case TwitterContentControllerType.DIRECT_MESSAGES: return new TwitterDMContentController(name,this._plugin);
				case TwitterContentControllerType.FAVORITES: return new TwitterFavoritesContentController(name,this._plugin);
				case TwitterContentControllerType.MENTIONS: return new TwitterMentionsContentController(name,this._plugin);
				case TwitterContentControllerType.TIMELINE: return new TwitterTimelineContentController(name,this._plugin);
			}
			
			return null;
		}
		
	}
}