package com.spice.clove.plugin.core.root.desktop.views.column.group
{
	import com.spice.binding.DataBoundController;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.ColumnMetaData;
	import com.spice.clove.plugin.column.HolderColumn;
	import com.spice.clove.plugin.core.column.ICloveColumn;
	import com.spice.clove.plugin.core.root.desktop.views.column.RootColumnViewController;
	import com.spice.clove.plugin.core.root.desktop.views.column.group.single.SingleColumnViewController;
	import com.spice.clove.util.ColumnUtil;
	import com.spice.clove.utils.CloveColumnUtil;
	import com.spice.clove.view.column.ColumnViewController;
	import com.spice.recycle.factory.RecyclingFactory;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	
	[Bindable]
	public class GroupColumnViewController extends ColumnViewController
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

        public var columns:ArrayCollection;
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _expanded:Boolean;
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		//private var _targetController:SingleColumnViewController;
        
        private var _model:CloveModelLocator = CloveModelLocator.getInstance();
       	private var _groupSingleViewController:SingleColumnViewController;
		private var _groupExpandedCW:ChangeWatcher;
       	private var _dbc:DataBoundController;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function GroupColumnViewController()
		{
			
			super(null);
			
			this.columns = new ArrayCollection();
			
			
			
			_dbc = new DataBoundController(this.columns,new RecyclingFactory(SingleColumnViewController));
			
			//keep the data bound controller reflective, so any re-organization done to the SingleColumnViewController gets
			//reflected in the columns as well
			_dbc.reflective = true;
			
			
			
			this.columns.addEventListener(CollectionEvent.COLLECTION_CHANGE,onNewViewController,false,0,true);
			
			
			
			_groupExpandedCW = BindingUtils.bindProperty(this,"expanded",_model.applicationSettings.core,"groupExpanded",false,true);
			this.expanded = _model.applicationSettings.core.groupExpanded;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
	
		
		/*
		 */
		
		[Bindable(event="expandcontract")]
		public function get expanded():Boolean
		{
			return _expanded;
		}
		
		/*
		 */
		
		public function set expanded(value:Boolean):void
		{
			_expanded = value;
			
			this.showhideGroup();
			
			
			this.dispatchEvent(new Event("expandcontract"));
			
		}
		
		/*
		 */
		
		
		
		override public function setSelected(value:Boolean):void
		{
			
			
			
			if(value == this.selected)
			{
				
				this.showhideGroup();
				return;
			}	
			
			super.setSelected(value);
			
			if(value)
			{
				//if this isn't the current target, then it's not being seen, so the data providers should be dumped
				//so ALL RenderedColumnData is removed from mem
				
				//NOTE: the delay is OKAY. This is only a precaution against the SmoothList that may try and retrieve the
				//data again, which will fill the SQLList... we don't want that.
				
				if(target)
				flash.utils.setTimeout(CloveColumnUtil.dumpHistoryExcept,1000,this.target);
				
				this.showhideGroup();
			}
				
			
			
			
		}
		
		
		

		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override protected function setTarget(target:ClovePluginColumn):void
		{
			super.setTarget(target);
			
			
			//if(!this.selected)
			
			
			if(target)
			_dbc.dataProvider = target.children;
			else
			if(_dbc)
			_dbc.dataProvider = null;
		}
		
        /*
		 */
		  
		public function createNewColumn(column:ClovePluginColumn = null):void
		{
			var install:Boolean = false;
			
			
			if(column && !(column is HolderColumn))
			{
				
				
//				//the COLUMN_CONTROLLER metadata is set by the AddColumnButton in ClovePluginColumn for the installer
//				//passed into the create() parameter for CloveColumnInfo
//				var controller:SingleColumnViewController = column.metadata.getSetting(ColumnMetaData.COLUMN_CONTROLLER);
//				
//				//this.columns.ignoreTarget();
//				
//				column.metadata.saveSetting(ColumnMetaData.EDIT_TITLE,true);
//				
//				//we copy the metadata set by the previous column so it looks EXACTLY the same.... except for the content ;)
//				//we also do it in a safe way so that only the global metadata is set such as colors, widths, margins, etc.
//				
//				if(controller)
//				ColumnUtil.copyMetaData(controller.target,column,ColumnMetaData);
//
//				//add the child column to the holder
//				controller.target.children.addItem(column);
//				
//				
//				;
//				
//				
//				column.metadata.removeSetting(ColumnMetaData.COLUMN_CONTROLLER);
				
			
				
				//this.columns.listenToTarget();
				
				//FIXME: this is dirty >.>
				
				
			} 
			else
			{	
				var holder:HolderColumn;
				
				if(column is HolderColumn)
				{
					holder = column as HolderColumn;
				}
				else
				{
					holder = new HolderColumn();
//					holder.metadata.saveSetting(ColumnMetaData.EDIT_TITLE,true);
				}
				
				  
				this.createBlankColumn(holder,install);
			}
			
			
		}
		
		
		
		
		/*
		 */
		
		override public function dispose():void
		{
			if(!_dbc)
				return;
			
			this._dbc.dispose();
			
			if(this._groupSingleViewController)
			this._groupSingleViewController.dispose();
			_groupExpandedCW.unwatch();
			
			for each(var c:SingleColumnViewController in this.columns.source)
			{
				c.dispose();
			}
			this.columns.removeAll();
			this.columns.source = undefined;
			
			
			this.columns = undefined;
			this._dbc = undefined;
			this._model = undefined;
			this._groupExpandedCW = undefined;
			  
			super.dispose();
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
		
		
		/*
		 */
		
		private function createBlankColumn(column:ClovePluginColumn,installView:Boolean = false):void
		{
			if(column)
				this.target.children.addItem(column);
		}
		
		
		/*
		 */
		
		override protected function set __currentTargetController(value:ColumnViewController):void
		{
			super.__currentTargetController = value;
			
			if(!this.selected && value)
			{
				super.setSelected(true);
			}
		}
		
		/*
		 */
		
		private function onNewViewController(event:CollectionEvent):void
		{
			return;
			
			if(event.kind != CollectionEventKind.ADD)
				return;
			
			
			
			
			try
			{
				var col:SingleColumnViewController = event.items[0];
				
				
				//if in single column mode, set the target viewcontroller
				if(this.currentTargetController)
				{
					col.setSelected(true)
				}
			}catch(e:Error)
			{
				 Logger.logError(e);
			}
			
		}
		
		/*
		 */
		
		private function showhideGroup():void
		{
			
			
			//the group MUST be selected, it must NOT be expanded, the current target must NOT be present, and the current target controller
			//must be THIS current controller
			
			//NOTE: the item must NOT be selected because on application open, the showhideGroup method is toggled in set target. If the group is not currently
			//selected, then things will get a bit funky.... All groups become selected, and then become un-selectable :/
			if(this.selected && !this.expanded && !(this.currentTargetController && this.currentTargetController.target == this.target))
			{
				//for single column mode
				if(!this._groupSingleViewController)
				{
					this._groupSingleViewController = new SingleColumnViewController();
				}
				
				this._groupSingleViewController.target = this.target;
				this.__currentTargetController = this._groupSingleViewController;
			}
			else
			if(this.currentTargetController && this.expanded)
			{
				
				
				if(this._groupSingleViewController)
				this._groupSingleViewController.target = null;
				this.__currentTargetController = null;
			}
		
		
		}

	}
}