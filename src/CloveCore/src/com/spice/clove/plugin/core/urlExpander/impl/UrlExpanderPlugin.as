package com.spice.clove.plugin.core.urlExpander.impl
{
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.settings.ClovePluginSettings;
	import com.spice.clove.urlExpander.core.CallUrlExpanderType;
	import com.spice.clove.urlExpander.core.data.AddExpandedUrlData;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class UrlExpanderPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _expandedUrls:Object;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function UrlExpanderPlugin(factory:URLExpanderFactory)
		{
			super("Url Expander","com.spice.clove.plugin.core.urlExpander",new ClovePluginSettings(BasicSettingFactory.getInstance()),factory);
			
			this._expandedUrls = {};
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
				case CallUrlExpanderType.EXPAND_URL: return this.expandUrl(call);
				case CallUrlExpanderType.SET_EXPANDED_URL: return this.setExpandedUrl(call.getData());
			}
			
			super.answerProxyCall(call);
		}
		
		
		/**
		 */
		
		public function expandUrl(c:IProxyCall):void
		{
			var urlToExpand:String = c.getData();
			//nothing for now. we just return the expanded piece
			
			var expanded:String = this._expandedUrls[urlToExpand];
			
			
			
			if(!expanded)
			{
				expanded = urlToExpand;
			}
			
			this.respond(c,new AddExpandedUrlData(expanded,urlToExpand));
			
		}
		
		/**
		 */
		
		public function setExpandedUrl(value:AddExpandedUrlData):void
		{
			this._expandedUrls[value.getExpandedUrl()] = value.getOriginalUrl();
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
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls()
				
			this.addAvailableCalls([CallUrlExpanderType.EXPAND_URL,
									CallUrlExpanderType.SET_EXPANDED_URL]);
		}
	}
}