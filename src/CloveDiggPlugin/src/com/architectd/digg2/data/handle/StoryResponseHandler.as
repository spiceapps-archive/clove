package com.architectd.digg2.data.handle
{
	import com.architectd.digg2.data.StoryData;

	public class StoryResponseHandler implements IResponseHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getResult(raw:String):Array
		{
			var ex:XML = new XML(raw);
			
			
			var count:Number = ex.@count;
			var offset:Number = ex.@offset;
			
			var r:Array = [];
			var sd:StoryData;
			
			for each(var story:XML in ex.story)
			{
//				
				
				sd = new StoryData(story.title,
								   story.topic.@name,
								   story.container.@name,
								   story.description,
								   story.@submit_date,
								   story.@diggs,
								   story.@id,
								   story.@comments,
								   story.@status,
								   story.@href,
								   story.@link,
								   story.thumbnail.@src,
								   story.shorturl.@short_url);
				
				sd.count = count;
				sd.offset = offset;
				
				
				
				r.push(sd);
			}
			
			return r;
		}
	}
}