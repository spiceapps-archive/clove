package com.spice.clove.twitter.impl.content.control.search
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.twitter.impl.TwitterPlugin;

	public class TwitterUserSearchContentController extends TwitterSearchBasedContentController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:TwitterPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterUserSearchContentController(factoryName:String,
														   plugin:ClovePlugin,
														   keywordSearch:String = null)
		{
			super(factoryName,
				  plugin,
				  "Twitter User:",
				  keywordSearch);
			
			
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
			this.fillonCueComplete(getTwitterPlugin().getPublicConnection().getUserTimeline(this.getSearchTerm().getData()));
		}
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
			this.fillonCueComplete(getTwitterPlugin().getPublicConnection().getUserTimeline(this.getSearchTerm().getData(),15,0,Number(data.getUID())));
		}
		
		
	}
}