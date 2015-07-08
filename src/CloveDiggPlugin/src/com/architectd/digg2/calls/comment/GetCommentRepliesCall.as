package com.architectd.digg2.calls.comment
{
	import com.architectd.digg2.calls.PublicDiggCall;
	import com.architectd.digg2.data.handle.CommentHandler;
	
	public class GetCommentRepliesCall extends PublicDiggCall
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function GetCommentRepliesCall(commentId:String,count:Number = 100,offset:Number = 0,sort:String = null)
		{
			super("comment.getReplies",{comment_id:commentId,count:count,offset:offset},new CommentHandler());
		}

	}
}