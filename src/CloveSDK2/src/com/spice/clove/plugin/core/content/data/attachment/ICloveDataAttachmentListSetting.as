package com.spice.clove.plugin.core.content.data.attachment
{
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachment;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	import com.spice.vanilla.core.settings.ISetting;

	public interface ICloveDataAttachmentListSetting extends ISetting, IProxyOwner
	{  
		function addVisibleAttachment(value:IVisibleCloveDataAttachment):void;
	}
}