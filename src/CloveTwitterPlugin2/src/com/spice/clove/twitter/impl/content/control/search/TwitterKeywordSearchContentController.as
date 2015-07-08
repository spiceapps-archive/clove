package com.spice.clove.twitter.impl.content.control.search
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.impl.ClovePlugin;

	public class TwitterKeywordSearchContentController extends TwitterSearchBasedContentController
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterKeywordSearchContentController(factoryName:String,
															  plugin:ClovePlugin,
															  keywordSearch:String = null)
		{
			super(factoryName,plugin,null,keywordSearch);
			
			
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
			this.fillonCueComplete(this.getTwitterPlugin().getPublicConnection().search(this.getSearchTerm().getData(),15));
		}
		
		/**
		 */
		
		override protected function loadOlder2(data:ICloveData=null):void
		{
			if(!data)
			{
				this.fillColumn([]);
				return;
			}
			this.fillonCueComplete(this.getTwitterPlugin().getPublicConnection().search(this.getSearchTerm().getData(),15,0,null,null,NaN,Number(data.getUID())));
		}
		
		
		
		
	}
}