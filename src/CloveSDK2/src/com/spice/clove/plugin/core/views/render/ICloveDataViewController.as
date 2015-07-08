package com.spice.clove.plugin.core.views.render
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.views.ICloveViewTarget;
	import com.spice.vanilla.core.proxy.IProxyOwner;
    
	public interface ICloveDataViewController extends IProxyOwner
	{  
		function setContentView(content:Object,viewTarget:ICloveViewTarget):void;
	}
}