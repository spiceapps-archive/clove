package com.spice.clove.web.plugin.root.content.control
{
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.core.column.ICloveColumn;
	import com.spice.clove.plugin.core.root.control.IViewableContentController;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.view.column.ColumnViewController;
	import com.spice.clove.web.plugin.root.views.RootColumnViewController;
	
	
	
	public class WebRootContentController extends CloveContentController implements IViewableContentController
	{
		
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _columnViewController:*;//RootColumnViewController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function WebRootContentController(name:String,plugin:ClovePlugin)
		{
			super(name,plugin,null);
			
			
			this._columnViewController = new RootColumnViewController();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		
		/*
		*/
		
		override public function setColumn(value:ICloveColumn):void
		{
			super.setColumn(value);
			
			this._columnViewController.target = ClovePluginColumn(value);
		}
		
		
		/*
		*/
		
		public function get viewController():ColumnViewController
		{
			return this._columnViewController;
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/*
		@param column if the column is null, the view wll add a blank column view with options
		*/
		
		public function addChildToCurrentGroup(column:ClovePluginColumn = null):void
		{
			this._columnViewController.addToCurrentGroup(column);
			
		}
		
	}
}