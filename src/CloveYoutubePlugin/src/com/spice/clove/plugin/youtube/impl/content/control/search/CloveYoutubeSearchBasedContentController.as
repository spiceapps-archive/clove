package com.spice.clove.plugin.youtube.impl.content.control.search
{
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	import com.spice.clove.plugin.impl.content.control.search.CloveSearchBasedContentController;
	import com.spice.clove.plugin.impl.views.content.control.option.AbstractDataOptionViewController;
	import com.spice.clove.plugin.impl.views.menu.AbstractRegisteredMenuItemButtonViewController;
	import com.spice.clove.plugin.youtube.impl.CloveYoutubePlugin;
	import com.spice.clove.plugin.youtube.impl.assets.YoutubeAssets;
	import com.spice.clove.plugin.youtube.impl.content.control.render.YoutubeFeedItemRenderer;

	public class CloveYoutubeSearchBasedContentController extends CloveSearchBasedContentController
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveYoutubeSearchBasedContentController(factoryName:String,
																 plugin:CloveYoutubePlugin)
		{
			super(factoryName,plugin,new YoutubeFeedItemRenderer(this,plugin.getPluginMediator()));
			
			
			
//			var dataOption:AbstractDataOptionViewController = new AbstractDataOptionViewController(plugin.getPluginMediator());
			
//			this.addDataOptionController(new AbstractRegisteredMenuItemButtonViewController(CallRegisteredViewType.GET_NEW_REGISTERED_MENU_BUTTON_VIEW_CONTROLLER,plugin.getPluginMediator(),dataOption));
		}
	}
}