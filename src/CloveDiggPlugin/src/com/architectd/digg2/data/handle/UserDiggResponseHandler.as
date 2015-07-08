package com.architectd.digg2.data.handle
{
	import com.architectd.digg2.data.StoryData;
	
	public class UserDiggResponseHandler extends ResponseHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function UserDiggResponseHandler()
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
			
			var sd:StoryData;
			
			
			for each(var story:XML in data.digg)
			{
				sd = new StoryData(null,null,null,null,story.@date);
				sd.id = story.@story;
				sd.status = story.@status;
				d.push(sd);
				
				
				
			}
			
			
			return d;
		}

	}
}