package com.spice.clove.web.plugin.root.views
{
	import com.spice.clove.web.plugin.root.views.single.SingleColumnViewController;
	
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