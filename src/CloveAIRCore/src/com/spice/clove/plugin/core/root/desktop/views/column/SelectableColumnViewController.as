package com.spice.clove.plugin.core.root.desktop.views.column
{
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.view.column.ColumnViewController;
	import com.spice.display.BindableUIView;
	
	public class SelectableColumnViewController extends ColumnViewController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Bindable] private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		private var _selected:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function SelectableColumnViewController(target:ClovePluginColumn)
		{
			super(target);
		}
		

	}
}