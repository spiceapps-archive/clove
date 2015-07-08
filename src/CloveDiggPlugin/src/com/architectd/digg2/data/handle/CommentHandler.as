package com.architectd.digg2.data.handle
{
	import com.architectd.digg2.data.CommentData;
	import com.architectd.digg2.data.UserData;
	
	public class CommentHandler extends ResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CommentHandler()
		{
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function getResult2(data:XML):Array
		{
			var d:Array = [];
			
			for each(var comment:XML in data.comment)
			{
				var ud:UserData = new UserData(comment.@user);
				
				var cd:CommentData = new CommentData(comment.@date,
													 comment.@id,
													 comment.@storyid,
													 comment.@diggs,
													 comment.@replies,
													 comment.@root,
													 comment.@blocked,
													 ud,
													 comment.toString());
										
				d.push(cd);
			}
			
			return d;
		}
	}
}