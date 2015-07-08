package com.spice.clove.post.core.outgoing
{
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.core.queue.ICue;
	import com.spice.vanilla.core.proxy.IProxyOwner;

	public interface IClovePostable extends  ICue
	{  
		function getName():String;  
		function setMessage(value:ICloveMessage):void
		//function getPlugin():ClovePlugin;
//		function getMessage():ICloveMessage;
	}
}