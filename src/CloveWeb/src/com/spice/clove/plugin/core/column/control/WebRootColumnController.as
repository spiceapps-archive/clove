package com.spice.clove.plugin.core.column.control
{
	import com.spice.clove.plugin.column.ICloveColumn;
	import com.spice.clove.plugin.column.control.ColumnController;
	import com.spice.clove.plugin.core.column.views.RootColumnViewController;
	import com.spice.clove.plugin.core.root.column.control.IViewableColumnController;
	import com.spice.clove.view.column.ColumnViewController;
	
	public class WebRootColumnController extends ColumnController implements IViewableColumnController
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _viewController:ColumnViewController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function WebRootColumnController()
		{
			_viewController = new RootColumnViewController();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function set column(value:ICloveColumn):void
		{
			super.column = value;
			
			_viewController.target = value;
		}
		
		/**
		 */
		
		public function get viewController():ColumnViewController
		{
			return this._viewController;
		}

	}
}