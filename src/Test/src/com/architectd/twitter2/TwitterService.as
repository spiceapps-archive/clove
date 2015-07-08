package com.architectd.twitter2
{
	import com.architectd.twitter2.calls.TwitterCall;
	import com.architectd.twitter2.responseHandler.TwitterJSONSearchHandler;
	import com.flexoop.utilities.dateutils.DateUtils;
	import com.spice.impl.queue.Queue;
	import com.spice.impl.service.AbstractRemoteService;
	import com.spice.utils.queue.cue.ICue;

	public class TwitterService extends AbstractRemoteService
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function TwitterService(queue:Queue = null)
		{
			super(queue);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function search(keyword:String,
							   num:Number = 15,
							   page:Number = 0,
							   sinceDate:Date = null,
							   untilDate:Date = null,
							   sinceId:Number = NaN,
							   maxID:Number = NaN):TwitterCall
		{
			return this.addCue(new TwitterCall(TwitterUrls.TWITTER_SEARCH_URL,
				new TwitterJSONSearchHandler(),
				{
					q:keyword,
					rpp:num,
					page:page,
					since:sinceDate ? DateUtils.dateFormat(sinceDate,"YYYY-MM-DD") : null,
					until:untilDate ? DateUtils.dateFormat(untilDate,"YYYY-MM-DD") : null,
					since_id:sinceId,
					max_id:maxID
				}));
			
		}
		
		
		/**
		 */
		
		public function getUserTimeline(screenName:String = null,
										count:int = 15,
										page:int = 0,
										sinceID:Number = NaN,
										maxID:Number = NaN):TwitterCall
		{
			return null;
			/*return this.addCue(new TwitterCall(TwitterUrls.TWITTER_USER_TIMELINE_URL,
				new TimelineDataHandler(),
				{
					count:count,
					page:page,
					screen_name:screenName,
					since_id:sinceID,
					max_id:maxID
				}));*/
		}
	}
}