package com.spice.clove.plugin.core.content.control
{
	import com.spice.clove.plugin.core.content.control.render.ICloveDataRenderer;
	
	/**
	 * content controllers that provide content to Clove needing an item renderer 
	 * @author craigcondon
	 * 
	 */	
	public interface ICloveServiceContentController extends ICloveContentController
	{
		function getItemRenderer():ICloveDataRenderer;
	}
}