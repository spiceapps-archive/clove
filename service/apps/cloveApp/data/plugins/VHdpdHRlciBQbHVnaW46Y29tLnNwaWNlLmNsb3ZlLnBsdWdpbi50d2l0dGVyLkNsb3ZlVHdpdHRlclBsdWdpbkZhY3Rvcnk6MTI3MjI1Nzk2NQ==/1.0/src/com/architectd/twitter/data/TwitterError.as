package com.architectd.twitter.data
{
	public class TwitterError
	{
		
		public static function getMessage(status:int):String
		{
			switch(status)
			{
				
				case TwitterStatusType.SUCCESS:
					return "Success!";
				break;
				case TwitterStatusType.NOT_MODIFIED:
					return "There was no new data to return.";
				break;
				case TwitterStatusType.BAD_REQUEST:
					return "The request was invalid.";
				break;
				case TwitterStatusType.UNAUTHORIZED:
					return "Authentication credentials are incorrect.";
				break;
				case TwitterStatusType.FORBIDDEN:
					return "Forbidden.";
				break;
				case TwitterStatusType.NOT_FOUND:
					return "Not found.";
				break;
				case TwitterStatusType.BAD_GATEWAY:
					return "Twitter is down or being updated.";
				break;
				
				
			}
			
			return "An unknown error has occurred.";
		}
	}
}