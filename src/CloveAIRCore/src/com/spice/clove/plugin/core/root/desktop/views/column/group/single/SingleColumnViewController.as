package com.spice.clove.plugin.core.root.desktop.views.column.group.single
{
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.ColumnMetaData;
	import com.spice.clove.plugin.core.column.ICloveColumn;
	import com.spice.clove.util.ColumnUtil;
	import com.spice.clove.view.column.ClovePluginColumnDataView;
	import com.spice.clove.view.column.ColumnViewController;
	
	import mx.collections.ArrayCollection;
	
	
	public class SingleColumnViewController extends ColumnViewController
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
        
		/*[Bindable] public var currentBreadCrumbController:ColumnViewController;*/
		
		public static const DATA_COLUMN_VIEW:int    = 0;
		public static const BREADCRUMB_VIEW:int     = 0;
		public static const PREFERENCE_VIEW:int     = 1;
		
		
		[Bindable] public var editMode:Boolean;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function SingleColumnViewController(target:ClovePluginColumn = null)
		{
			
			super(target);
			
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/*
		 */
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			if(!value)
				return;
			
			//allow for the column (on installation) to set the current data view. This is usually set by plugins
			//the twitter plugin for instance uses this on installation to set the preference view for a search
			if(value.metadata.hasSetting(ColumnMetaData.CURRENT_COLUMN_VIEW))
			{
				this.currentViewState = value.metadata.getSetting(ColumnMetaData.CURRENT_COLUMN_VIEW) == "data" ? DATA_COLUMN_VIEW : PREFERENCE_VIEW;
			}
			else
			{
				this.currentViewState = DATA_COLUMN_VIEW;
			}
			
			
			
			//make sure all of the feeds have content controllers, otherwise turn the preference
			//view on
			if(this.target.children.length == 0)
			{
				this.currentViewState = PREFERENCE_VIEW;
			}
			else
			for each(var child:ClovePluginColumn in Object(this.target.children).source)
			{
				if(!child.controller)
				{
					this.currentViewState = PREFERENCE_VIEW;
				}
					
			}
			this.editMode = false;
			
			
			
			
			//remove the metadata used by this column view controlleronly
			value.metadata.removeSetting(ColumnMetaData.EDIT_TITLE);
			value.metadata.removeSetting(ColumnMetaData.CURRENT_COLUMN_VIEW)
			
			
		}
		/*
		 */
		
		override public function get viewClass():Class
		{
			return SingleColumn;
		}
		/*
		 */
		
		public function get title():String
		{
			return this.target.title;
		}
		
		/*
		 */
		
		
		override protected function setTarget(target:ClovePluginColumn):void
		{
			
			
			super.setTarget(target);
			
			if(target)
			{
				if(target.children.length == 0)
					this.currentViewState == PREFERENCE_VIEW;
				else
					this.currentViewState = DATA_COLUMN_VIEW;
			}
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function removeColumn():void
		{
			if(!this.target)
				return;
			
			this.target.dispose();
		}
		
		
		/*
		 */
		
		public function refresh():void
		{
			ColumnUtil.refreshColumn(target);
		}
		
		/*
		 */
		
		public function clear():void
		{
			ClovePluginColumn(target).clearData();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
     
        /*
		 */
		 
		override protected function addColumnListeners():void
		{
			super.addColumnListeners();
			
			if(!this.target)
				return;
				
			
			this._janitor.addEventListener(target,CloveColumnEvent.FOCUS,onColumnFocus,false,0,true);
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
       
		
		/*
		 */
		
		private function onColumnFocus(event:CloveColumnEvent):void
		{
			/*if(this.currentBreadCrumbController)
			{
				this.currentBreadCrumbController.destroy();
			}*/
			
			if(event.targetColumn == this.target)
			{
				this.currentViewState  = DATA_COLUMN_VIEW;
				return;
			}
			
//			this.currentBreadCrumbController = new ColumnViewController(ClovePluginColumn(event.targetColumn));
			
			this.currentViewState = BREADCRUMB_VIEW;
			
		}
		

	}
}