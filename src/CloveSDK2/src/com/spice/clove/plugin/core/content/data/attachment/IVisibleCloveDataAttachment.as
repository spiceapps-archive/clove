package com.spice.clove.plugin.core.content.data.attachment
{
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.impl.content.data.attachment.ICloveDataAttachment;
	import com.spice.vanilla.core.proxy.IProxyOwner;
	
	import flash.display.DisplayObject;

	public interface IVisibleCloveDataAttachment extends ICloveDataViewController, IProxyOwner, ICloveDataAttachment
	{
	}
}