package com.spice.clove.plugin.core.root.desktop.column.control
{
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.core.column.ICloveColumn;
	import com.spice.clove.plugin.core.root.impl.content.control.IViewableContentController;
	import com.spice.clove.plugin.core.root.desktop.views.column.RootColumnView;
	import com.spice.clove.plugin.core.root.desktop.views.column.RootColumnViewController;
	import com.spice.clove.plugin.impl.ClovePlugin;
	import com.spice.clove.plugin.impl.content.control.CloveContentController;
	import com.spice.clove.view.column.ColumnViewController;
	import com.spice.vanilla.core.plugin.IPlugin;
	
	/*
	  the root column is in charge of delegating views among the columns.
	  There are a max of 3 levels. the Root being the delegate that sends columns
	  to their rightful place according to their type. The groups which hold the columns,
	  and the columns that hold the data.
	 */
	
	public class RootColumnController extends CloveContentController implements IViewableContentController
	{
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _rootView:RootColumnView;
		private var _columnViewController:RootColumnViewController;
		private var _columnView:RootColumnView;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function RootColumnController(name:String,plugin:ClovePlugin = null)
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