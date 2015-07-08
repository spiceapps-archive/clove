package com.spice.clove.rss.flex
{
	import com.spice.clove.plugin.flash.views.content.control.render.CloveDataViewController;
	import com.spice.clove.rss.flex.views.column.row.FXRSSRowView;
	import com.spice.clove.rss.impl.RSSPlugin;
	import com.spice.clove.rss.impl.calls.CallRSSPluginType;
	import com.spice.vanilla.core.proxy.IProxyCall;

	public class FXRSSPlugin extends RSSPlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FXRSSPlugin(factory:FXRSSPluginFactory)
		{
			super(factory);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallRSSPluginType.GET_NEW_REGISTERED_RSS_ROW_VIEW_CONTROLLER: 
					return this.respond(call,new CloveDataViewController(FXRSSRowView));
			}
			
			super.answerProxyCall(call);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallRSSPluginType.GET_NEW_REGISTERED_RSS_ROW_VIEW_CONTROLLER]);
		}
	}
}