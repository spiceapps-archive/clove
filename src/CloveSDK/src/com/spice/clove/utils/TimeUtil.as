package com.spice.clove.utils
{
	import com.flexoop.utilities.dateutils.DateUtils;
	
	
	/*
	  Formats time: x days ago, x hours ago, etc. 
	  @author craigcondon
	  
	 */	
	public class TimeUtil
	{
			
		public static function getShortTime(date:Date):String
		{
			var cdate:Date = new Date();
			var ctime:Number;
			
			//Alert.show(cdate+" "+date);
			
			while(true)
			{
				
				ctime = DateUtils.dateDiff(DateUtils.YEAR,date,cdate);
				
				if(ctime > 0)
				{
					return ctime +leaveKeepS(" year",ctime)+" ago";
				}
				
				ctime = DateUtils.dateDiff(DateUtils.MONTH,date,cdate);
				
				if(ctime > 0)
				{
					return ctime +leaveKeepS(" month",ctime)+" ago";
				}
				
				ctime = DateUtils.dateDiff(DateUtils.DAY_OF_MONTH,date,cdate);
			
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