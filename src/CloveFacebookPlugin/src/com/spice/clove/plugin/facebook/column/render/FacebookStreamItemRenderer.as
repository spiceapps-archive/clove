package com.spice.clove.plugin.facebook.column.render
{
	import com.facebook.data.stream.StreamStoryData;
	import com.spice.clove.plugin.column.render.IReusableCloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.facebook.column.render.attach.RenderedColumnDataCommentAttachment;
	import com.spice.clove.plugin.facebook.column.render.attach.RenderedColumnDataPhotoAttachment;
	import com.spice.clove.plugin.facebook.data.FriendInfo;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;

	public class FacebookStreamItemRenderer implements /*IViewRenderer,*/ IReusableCloveColumnItemRenderer
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		[Bindable] 
		private var _model:FacebookModelLocator = FacebookModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		
		public static const TYPE_STREAM_STORY:String = "streamStory";
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function FacebookStreamItemRenderer()
		{
		}
		
		
		
		/**
		 */
		
		/*public function getViewClass(vo:RenderedColumnData):Class
		{
			
			
			switch(vo.vo.type)
			{
				case TYPE_STREAM_STORY:
					return FacebookStatusView;
				break;
			}
				
			return null;
		}
		*/
		
		
		/**
		 */
		
		public function getUID(vo:Object):String
		{
			return vo.post_id;
		}
		
		/**
		 */
		
		public function getRenderedData(vo:Object):RenderedColumnData
		{
			
			var uid:String;
			var datePosted:Date;
			var title:String = "";
			var message:String;
			var icon:String;
			var vod:Object = {};
			
			var rcd:RenderedColumnData = new RenderedColumnData();
			
			if(vo is StreamStoryData)
			{
				var ssd:StreamStoryData = StreamStoryData(vo);
				vod.type = TYPE_STREAM_STORY;
				vod.actor_id = ssd.actor_id;
				
				uid 	   = ssd.post_id;
				datePosted = ssd.created_time;
				message    = ssd.message;
				
				
				rcd.construct(uid,datePosted,title,message,icon,vod);
				var commentCount:int = ssd.comments.count;
				
				//if there is more than one comment, then add an attachment
			
				for each(var att:* in ssd.attachment.media)
				{
					
					if(att.photo)
					{
						rcd	.addAttachment(new RenderedColumnDataPhotoAttachment(att.photo,att.src));
						
					}
				}
				
				if(commentCount > 0)
				{
					rcd.addAttachment(new RenderedColumnDataCommentAttachment("View "+commentCount+" comments"));
				}
				
			}
			
			return rcd;
		}
		
		
		/**
		 */
		
		public function reuse(data:RenderedColumnData):void
		{
			//reset the friend info incase it hasn't loaded
			var info:FriendInfo = _model.friendModel.getFriendInfo(data.vo.actor_id);
			
			if(!info)
				return;
			
			info.bindRenderedData(data);
			
		}
	}
}