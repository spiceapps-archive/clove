package com.architectd.digg2.data
{
	
	[Bindable] 
	public class CommentData
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var submitted:Date;
        public var id:Number;
        public var storyId:Number;
        public var diggs:Number;
        public var replies:Number;
        public var root:Number;
        public var blocked:Number;
        public var user:UserData;
        public var comment:String;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CommentData(submitted:Number = NaN, 
									id:Number = NaN,
									storyId:Number = NaN,
									diggs:Number = NaN,
									replies:Number = NaN,
									root:Number = NaN,
									blocked:Number = NaN,
									user:UserData = null,
									comment:String = null)
		{
			
			this.submitted = new Date(submitted * 1000);
			
			this.id = id;
			this.storyId = storyId;
			this.diggs = diggs;
			this.replies = replies;
			this.root = root;
			this.blocked = blocked;
			this.user = user;
			this.comment = comment;
		}

	}
}