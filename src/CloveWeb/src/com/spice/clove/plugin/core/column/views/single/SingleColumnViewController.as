package com.spice.clove.plugin.core.column.views.single
{
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.crumb.CloveColumnCrumbController;
	import com.spice.clove.view.column.ColumnViewController;
	
	public class SingleColumnViewController extends ColumnViewController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		public static const COL_VIEW:int  = 0;
        public static const PREF_VIEW:int = 1;
        
        [Bindable] 
        public var currentView:int;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function SingleColumnViewController()
		{
			super();
		}
		
		
		
	}
}