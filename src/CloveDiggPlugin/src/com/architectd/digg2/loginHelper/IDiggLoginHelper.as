package com.architectd.digg2.loginHelper
{
	import com.architectd.digg2.DiggService;
	import com.spice.utils.queue.cue.ICue;

	public interface IDiggLoginHelper extends ICue
	{
		function get service():DiggService;
		function set service(value:DiggService):void;
	}
}