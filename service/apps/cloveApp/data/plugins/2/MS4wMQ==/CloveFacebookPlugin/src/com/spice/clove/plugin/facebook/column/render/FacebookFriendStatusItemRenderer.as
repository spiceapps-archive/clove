package com.spice.clove.plugin.facebook.column.render
{
	import com.facebook.data.status.Status;
	import com.spice.clove.plugin.column.render.IReusableCloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.facebook.data.FriendInfo;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;

	public class FacebookFriendStatusItemRenderer implements IReusableCloveColumnItemRenderer
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		public var friend:FriendInfo;
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		[Bindable] 
		private var _model:FacebookModelLocator = FacebookModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookFriendStatusItemRenderer()
		{
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
			return vo.status_id;
		}
		
		public function getRenderedData(vo:Object):RenderedColumnData
		{
			var sd:Status = Status(vo);	
			
			return new RenderedColumnData().construct(sd.status_id,sd.time,"",sd.message,null,{friendID:friend.friendID});
		}
		
		
		
		/**
		 */
		
		public function reuse(vo:RenderedColumnData):void
		{
			//reset the friend info incase it hasn't loaded
			var info:FriendInfo = _model.friendModel.getFriendInfo(vo.vo.friendID);
			
			if(!info)
				return;
			
			info.bindRenderedData(vo);
			
		}
	}
}