package com.architectd.twitter.calls
{
	import com.architectd.twitter.Twitter;
	import com.spice.utils.queue.cue.ICue;

	public interface ITwitterCall extends ICue
	{
		function get connection():Twitter;
		function set connection(value:Twitter):void;
		
		function setCredentials(username:String,password:String):void;
	}
}