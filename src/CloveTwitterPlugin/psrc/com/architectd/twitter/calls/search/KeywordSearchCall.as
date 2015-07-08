package com.architectd.twitter.calls.search
{
	import com.architectd.twitter.data.search.KeywordSearchItemData;
	import com.architectd.twitter.dataHandle.AtomDataHandler;

	public class KeywordSearchCall extends SearchBasedCall
	{
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function KeywordSearchCall(keyword:String,num:int = 15,page:int = 0,sinceId:Number = NaN,maxID:Number = NaN)
		{
			
			super(new AtomDataHandler(KeywordSearchItemData),"search",{q:keyword,rpp:num,page:page,since_id:sinceId,max_id:maxID});
		}
		
		
	}
}