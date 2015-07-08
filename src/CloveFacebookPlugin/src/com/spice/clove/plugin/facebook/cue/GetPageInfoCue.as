package com.spice.clove.plugin.facebook.cue
{
	import com.facebook.commands.pages.GetPageInfo;
	import com.facebook.data.pages.GetPageInfoData;
	import com.facebook.data.pages.PageInfoData;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;

	public class GetPageInfoCue extends FacebookCallCue
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _model:FacebookModelLocator = FacebookModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function GetPageInfoCue()
		{
			
			
			super(new GetPageInfo(["name","page_url","pic_small","website"]),onResult);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function onResult(data:GetPageInfoData):void
		{
			Logger.log("onResult()",this);
			
			_model.settings.fanPages.source = data.pageInfoCollection.source;
			
		}
	}
}