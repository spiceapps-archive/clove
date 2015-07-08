package com.spice.clove.plugin.youtube.impl
{
	import com.architectd.youtube.YoutubeService;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.plugin.youtube.impl.content.control.CloveYoutubeContentContollerType;
	import com.spice.clove.plugin.youtube.impl.content.control.YoutubeContentControllerFactory;
	import com.spice.clove.plugin.youtube.impl.content.control.search.CloveYoutubeSearchVideoContentController;
	import com.spice.clove.plugin.youtube.impl.settings.CloveYoutubePluginSettings;
	import com.spice.vanilla.core.plugin.factory.IPluginFactory;
	import com.spice.vanilla.core.proxy.IProxyCall;

	public class CloveYoutubePlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _connection:YoutubeService;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveYoutubePlugin(factory:ClovePluginFactory)
		{
			super("Youtube","com.spice.clove.plugin.youtube",new CloveYoutubePluginSettings(),factory);
			
			this.setContentControllerFactory(new YoutubeContentControllerFactory(this));
			
			_connection = new YoutubeService();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getConnection():YoutubeService
		{
			return this._connection;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function initialize():void
		{
			super.initialize();
			
			
			this.finishInitialization();
		}
		
		
		/**
		 */
		
		override protected function respondWithNewSearchContentControllers(call:IProxyCall, searchTerm:String):void
		{
			var search:CloveYoutubeSearchVideoContentController = new CloveYoutubeSearchVideoContentController( CloveYoutubeContentContollerType.SEARCH_VIDEO,this);
			search.getSearchTerm().setData(searchTerm);
			
			this.respond(call,search);
		}
	}
}