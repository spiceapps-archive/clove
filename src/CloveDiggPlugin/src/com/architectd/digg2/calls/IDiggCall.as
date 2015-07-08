package com.architectd.digg2.calls
{
	import com.architectd.digg2.DiggService;
	import com.spice.utils.queue.cue.ICue;

	public interface IDiggCall extends ICue
	{
		function get service():DiggService;
		function set service(value:DiggService):void;
	}
}