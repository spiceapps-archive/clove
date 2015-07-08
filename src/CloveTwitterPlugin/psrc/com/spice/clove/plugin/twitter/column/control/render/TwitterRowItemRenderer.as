package com.spice.clove.plugin.twitter.column.control.render
{
	import com.spice.clove.plugin.column.render.IReusableCloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	
	
	/**
	 * handles twitter row items
	 * @author craigcondon
	 * 
	 */	
	 
	public class TwitterRowItemRenderer implements IReusableCloveColumnItemRenderer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _useConversation:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TwitterRowItemRenderer(useConversation:Boolean = true)
		{
			_useConversation = useConversation;
		}


		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		/**
		 */
		
		public function getUID(vo:Object):String
		{
			return vo.id;
		}
		
		/**
		 */
		
	 	public function getRenderedData(vo:Object):RenderedColumnData
		{
			
			var rcd:RenderedColumnData = new RenderedColumnData();
			rcd.construct(vo.id,vo.createdAt,vo.user.name,vo.text,vo.user.icon,vo);
//			var ksid:KeywordSearchItemData;

			
			if(vo.hasOwnProperty("inReplyToStatusId") && vo.inReplyToStatusId > 0 && this._useConversation)
			{
				rcd.addAttachment(new TwitterConversationAttachment());
			}
			
			return rcd;
		}
	
		
        /**
		 */
		
		public function reuse(data:RenderedColumnData):void
		{
			
			//FOR TESTING
			//new CloveCueEvent(new ConversationTrackNumCue(data),"twitterConversation").dispatch()
		}

		
		
	}
}