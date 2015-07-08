package com.spice.clove.post.core.outgoing
{
	import com.spice.utils.storage.ISettings;
	import com.spice.utils.storage.TempSettings;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.core.settings.ISettingTable;
	
	import flash.net.FileReference;

	public interface ICloveAttachment extends IProxyOwner
	{
//		function getMetadata():ISettingTable;
		function getFileReference():FileReference;
//		function getName():String;
		
	}
}