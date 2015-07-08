package com.spice.clove.plugin.core.views
{
	import flash.display.DisplayObject;

	public interface ICloveViewTarget
	{
		/**
		 *
		 * @return the current target view
		 * 
		 */		
		
		function getView():DisplayObject;
		
		/**
		 * removes the current view from the target
		 * @return the removed view
		 * 
		 */		
		
		function removeView():DisplayObject;
		
		/**
		 * sets the new view to the controller
		 * @param value the new view
		 * @return the same view passd in the setView parameter
		 * 
		 */		
		
		function setView(value:DisplayObject):DisplayObject;
	}
}