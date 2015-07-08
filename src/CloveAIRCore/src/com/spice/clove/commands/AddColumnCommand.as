package com.spice.clove.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.spice.clove.commandEvents.CloveEvent;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.ColumnMetaData;
	import com.spice.clove.plugin.column.GroupColumn;
	import com.spice.clove.plugin.column.HolderColumn;
	import com.spice.clove.plugin.core.root.desktop.content.control.RootContentController;
	import com.spice.clove.plugin.core.root.desktop.views.column.group.single.SingleColumnViewController;
	import com.spice.clove.plugin.core.root.impl.models.CloveRootModelLocator;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.BooleanSetting;
	import com.spice.vanilla.impl.settings.basic.IntSetting;
	
	import mx.binding.utils.ChangeWatcher;
	
	public class AddColumnCommand implements ICommand
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 * TEMPORARY 
		 */		
		
		private var _model:CloveRootModelLocator = CloveRootModelLocator.getInstance();
		
		private var _watcher:ChangeWatcher;
		
		private var _event:CloveEvent;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function AddColumnCommand()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function execute(event:CairngormEvent):void
		{
			
			_event = CloveEvent(event);
			
			
			if(!_model.rootContentController)
			{
				_watcher = ChangeWatcher.watch(_model,["rootColumnController"],addColumn);
			}
			else
			{
				addColumn();
			}
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function addColumn(event:* = null):void
		{
			if(_watcher)
			{
				_watcher.unwatch();
				_watcher = null;
			}
			
			
			
			
			var col:ClovePluginColumn = _event.voData;
			
			
			var con:RootContentController = RootContentController(_model.rootContentController);
			
			if(_event.type == CloveEvent.ADD_GROUP || col is GroupColumn)
			{
				if(!col)
					col = new GroupColumn();
				
				//tell the ColumnTitles to edit the title
				if(col.metadata.getSetting(ColumnMetaData.TITLE) == "Untitled Group")
				{
					BooleanSetting(col.metadata.getNewSetting(BasicSettingType.BOOLEAN,ColumnMetaData.EDIT_TITLE)).setData(true);
				}
				
				ClovePluginColumn(con.getColumn()).children.addItem(col);
				
				con.viewController.getController(col).setSelected(true);
			}
			else
			{
				if(!col)
				{
					col = new HolderColumn();
					IntSetting(col.metadata.getNewSetting(BasicSettingType.INT,ColumnMetaData.CURRENT_COLUMN_VIEW)).setData(SingleColumnViewController.PREFERENCE_VIEW);
					
					col.children.addItem(new ClovePluginColumn());
				}
				
				//don't send any new column so the view can create options for the user
				con.addChildToCurrentGroup(col);
			}	
		}
	}
}