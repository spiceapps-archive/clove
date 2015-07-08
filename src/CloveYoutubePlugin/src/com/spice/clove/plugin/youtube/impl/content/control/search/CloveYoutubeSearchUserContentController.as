package com.spice.clove.plugin.youtube.impl.content.control.search
{
	import com.architectd.service.events.ServiceEvent;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.youtube.impl.CloveYoutubePlugin;

	public class CloveYoutubeSearchUserContentController extends CloveYoutubeSearchBasedContentController
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
		public function CloveYoutubeSearchUserContentController(name:String,
																plugin:CloveYoutubePlugin)
		{
			super(name,plugin);
			
			_plugin = plugin;
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
			_plugin.getConnection().getUserVideos(this.getSearchTerm().getData()).addEventListener(ServiceEvent.RESULT,onSearchResult);
		}
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
			_plugin.getConnection().getUserVideos(this.getSearchTerm().getData()).addEventListener(ServiceEvent.RESULT,onSearchResult);
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		private function onSearchResult(event:ServiceEvent):void
		{
			event.currentTarget.removeEventListener(event.type,onSearchResult);
			
			
			if(event.success)
			{
				this.fillColumn(event.data);
			}
			
		}
		
	}
}