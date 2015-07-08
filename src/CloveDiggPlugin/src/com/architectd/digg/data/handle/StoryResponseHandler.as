package com.architectd.digg.data.handle
{
	import com.architectd.digg.data.StoryData;

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
			
			var r:Array = [];
			var sd:StoryData;
			
			for each(var story:XML in ex.story)
			{
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
								   story.shorturl.short_url);
				
				r.push(sd);
			}
			
			return r;
		}
	}
}