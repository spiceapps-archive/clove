package com.spice.clove.post.core.outgoing
{
	import com.spice.utils.storage.TempSettings;
	import com.spice.vanilla.core.proxy.IProxyOwner;

	public interface ICloveMessage extends IProxyOwner
	{
		function getText():String;
		function addAttachment(value:ICloveAttachment):void;
		function getAttachments():Vector.<ICloveAttachment>;
	}
}