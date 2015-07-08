package com.spice.clove.plugin.core.root.impl.content.control 
{
	import com.spice.clove.plugin.core.content.control.ICloveContentController;
	import com.spice.clove.view.column.ColumnViewController;
	
	public interface IViewableContentController extends ICloveContentController
	{
		function get viewController():ColumnViewController;
	}
}