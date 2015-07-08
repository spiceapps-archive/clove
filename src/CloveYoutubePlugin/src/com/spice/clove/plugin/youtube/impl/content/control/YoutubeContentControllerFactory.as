package com.spice.clove.plugin.youtube.impl.content.control
{
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.plugin.youtube.impl.CloveYoutubePlugin;
	import com.spice.clove.plugin.youtube.impl.content.control.search.CloveYoutubeSearchUserContentController;
	import com.spice.clove.plugin.youtube.impl.content.control.search.CloveYoutubeSearchVideoContentController;
	import com.spice.clove.plugin.impl.content.control.CloveContentControllerFactory;

	public class YoutubeContentControllerFactory extends CloveContentControllerFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:CloveYoutubePlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function YoutubeContentControllerFactory(plugin:CloveYoutubePlugin)
		{
			var vect:Vector.<String> = new Vector.<String>(2,true);
			vect[0] = CloveYoutubeContentContollerType.SEARCH_VIDEO;
			vect[1] = CloveYoutubeContentContollerType.USER_SEARCH;
			
			super(vect);
			
			
			
			
			_plugin = plugin;
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
				case CloveYoutubeContentContollerType.SEARCH:
				case CloveYoutubeContentContollerType.USER_SEARCH:
				case CloveYoutubeContentContollerType.SEARCH_VIDEO:return this.getKeywordSearchController(name);
				case CloveYoutubeContentContollerType.USER_SEARCH: return this.getUserVideoSearchController(name);
			}
			
			return null;
		}
		
		
		/**
		 */
		
		protected function getKeywordSearchController(name:String):CloveYoutubeSearchVideoContentController
		{
			return new CloveYoutubeSearchVideoContentController(name,_plugin);
		}
		
		
		/**
		 */
		
		protected function getUserVideoSearchController(name:String):CloveYoutubeSearchUserContentController
		{
			return new CloveYoutubeSearchUserContentController(name,_plugin);
		}
		
	}
}