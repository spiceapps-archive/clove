package com.spice.clove.util
{
	import com.flexoop.utilities.dateutils.DateUtils;
	
	public class TimeUtil
	{
			
		public static function getShortTime(date:Date):String
		{
			var cdate:Date = new Date();
			
			
			//Alert.show(cdate+" "+date);
			
			while(true)
			{
				
				var ctime:Number = DateUtils.dateDiff(DateUtils.DAY_OF_MONTH,date,cdate);
			
				if(ctime > 0)
				{
					return ctime +leaveKeepS(" day",ctime)+" ago";
				}
				
				ctime = DateUtils.dateDiff(DateUtils.HOURS,date,cdate);
				
				if(ctime > 0)
				{
					return ctime +leaveKeepS(" hour",ctime)+" ago";
				}
				
				ctime = DateUtils.dateDiff(DateUtils.MINUTES,date,cdate);
				
				if(ctime > 0)
				{
					return ctime +leaveKeepS(" minute",ctime)+" ago";
				}
				
				ctime = DateUtils.dateDiff(DateUtils.SECONDS,date,cdate);
				
				if(ctime > 0)
				{
					return ctime +leaveKeepS(" second",ctime)+" ago";
				}
				
				return "Just now";
				
			}
			
			return null;
			
		}
		
		private static function leaveKeepS(text:String,num:Number):String
		{
			return num > 1 ? text+"s" : text;
		}

	}
}