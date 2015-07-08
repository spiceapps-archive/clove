package com.spice.clove.plugin.core.column.views
{
	import com.spice.clove.plugin.core.column.views.single.SingleColumnViewController;
	
	public class RootColumnViewController extends SingleColumnViewController
	{
	
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function RootColumnViewController()
		{
			super();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function get viewClass():Class
		{
			return RootColumnView;
		}

	}
}