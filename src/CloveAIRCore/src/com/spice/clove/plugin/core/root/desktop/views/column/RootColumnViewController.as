package com.spice.clove.plugin.core.root.desktop.views.column
{
	import com.spice.binding.DataBoundController;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.GroupColumn;
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.plugin.core.root.desktop.views.column.group.GroupColumnViewController;
	import com.spice.clove.plugin.core.root.impl.models.CloveRootModelLocator;
	import com.spice.clove.view.column.ColumnViewController;
	import com.spice.recycle.factory.RecyclingFactory;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.IProxyResponder;
	import com.spice.vanilla.impl.proxy.ProxyCallObserver;
	
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	
	[Bindable]
	public class RootColumnViewController extends ColumnViewController implements IProxyResponder
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		public var groupControllers:ArrayCollection;
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _dbc:DataBoundController;
		private var _addToBeginningInt:int;
		
		private var _enterIdleBind:ProxyCallObserver;
		
		
		private var _model2:CloveRootModelLocator = CloveRootModelLocator.getInstance();
		
		private var _noi:Vector.<String>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		
		public function RootColumnViewController(column:ClovePluginColumn = null)
		{
			
			
			
			this.groupControllers = new ArrayCollection();

			//listen for on new group controllers so we can select the first if it does exist on initialization
			this.groupControllers.addEventListener(CollectionEvent.COLLECTION_CHANGE,onNewGroupControllers);
			
			_dbc = new DataBoundController(this.groupControllers,new RecyclingFactory(GroupColumnViewController));
			
			
			
			super(column);
			
			
			
			_noi = new Vector.<String>();
			_noi.push(CallAppCommandType.ENTER_ACTIVE_MODE);
			_noi.push(CallAppCommandType.ENTER_IDLE_MODE);
			
			
			this._enterIdleBind = new ProxyCallObserver(this);
			
			_model2.rootPlugin.getPluginMediator().addProxyCallObserver(this._enterIdleBind);
			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getAvailableCalls():Vector.<String>
		{
			return _noi;
		}
		
		/*
		 */
		
		override public function get viewClass():Class
		{
			return RootColumnView;
		}
		
		
		
		/**
		 */
		
		public function answerProxyCall(n:IProxyCall):void
		{
			switch(n.getType())
			{
				case CallAppCommandType.ENTER_ACTIVE_MODE: return this.enterActiveMode();
				case CallAppCommandType.ENTER_IDLE_MODE: return this.enterIdleMode();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		private var _idledTargetController:ColumnViewController;
		private var _idlingGroupControllers:ArrayCollection;
		
		/**
		 */
		
		protected function enterIdleMode():void
		{
			this._idledTargetController = this.currentTargetController;
			this._idlingGroupControllers = this.groupControllers;
			
			super.__currentTargetController = null;
			this.groupControllers = null;
		}
		
		/**
		 */
		
		protected function enterActiveMode():void
		{
			this.groupControllers = this._idlingGroupControllers;
			super.__currentTargetController = this._idledTargetController;
		}
		
		
		/*
		 */
		
		override protected function setTarget(target:ClovePluginColumn):void
		{
			super.setTarget(target);
			
			
			if(!target)
			{
				if(_dbc)
				_dbc.dataProvider = null;
				return;
			}
			
			_dbc.priority = 9999999;
			_dbc.dataProvider = target.children;
			
			this.setCurrentColumnToBeginning();
		}
		
		/*
		 */
		
		override protected function set __currentTargetController(value:ColumnViewController):void
		{
			if(!value && this.target && this.target.children.length > 0)
			{
				GroupColumnViewController(this.groupControllers.getItemAt(0)).setSelected(true);
				
			}
			else
			{
				super.__currentTargetController = value;
			}
			
			
			//load the group IF we're not doing it globally
			if(!this._model2.rootPlugin.isSelfLoading() && this.currentTargetController && this.currentTargetController.target)
			{
				this.currentTargetController.target.loadNewerContent();
			}
		}
		
		
		/*
		 */
		
		override public function dispose():void
		{
			if(!this._dbc)
				return
				
			this._model2.rootPlugin.getPluginMediator().removeProxyCallObserver(this._enterIdleBind);
			
			this._dbc.dispose();
			
			this._dbc = undefined;
			this.groupControllers = undefined;
			
			super.dispose();
			
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		/*
		 */
		
		private function onNewGroupControllers(event:CollectionEvent):void
		{
			//if we remove a group, and it happens to be the current target view controller, then we need
			//to set the the current target controller to the first item in the index, or NULL if there are no more groups.
			//if there ARE no more groups, then setting NULL will flag to create a new group
			if(event.kind == CollectionEventKind.REMOVE)
			{
				
				if(event.items[0] == this.currentTargetController)
				{
					//if the location is not zero, then go the previous sibling in the list, otherwise set to the first child. 
					//If we're NULL, then we need to set the current target controller to null so we flag to add a group on new 
					//column
					if(groupControllers.length > 0)
						this.selectGroup(GroupColumnViewController(groupControllers.getItemAt(event.location -1 > 0 ? event.location -1 : 0)));
					else
						this.__currentTargetController = null;
				}
			}
			
			//we only want to handle added content because all the other types of collection events aren't important. :`(
			if(event.kind != CollectionEventKind.ADD)
				return;
			
			
			//if it's the first, then select it. If we do this for EVERY column, we could 
			//run into CPU issues because a batch of groups may potentially be added in the future.
			
			//Perhaps add a timeout so we select the newest, but delay it??
			if(this.groupControllers.length == 1)
			{
//				this.__currentTargetController = event.items[0];
				
				
				flash.utils.clearTimeout(_addToBeginningInt);
				_addToBeginningInt = flash.utils.setTimeout(this.setCurrentColumnToBeginning,200);
			}
			
			
			
		}
		/*
		 */
		
		private function filterGroupControllers(func:Function):Array
		{
			var filt:Array = [];
			
			
			for each(var controller:GroupColumnViewController in this.groupControllers.source)
			{
				if(func(controller))
				{
					filt.push(controller);
				}
			}	
			
			
			return filt;
		}
		
		
		
		/*
		 */
		
		public function addToCurrentGroup(column:ClovePluginColumn):void
		{
			
			if(this.currentTargetController)
				GroupColumnViewController(this.currentTargetController).createNewColumn(column);
			else
			{
				//if NO column is present then create one.
				
				
				var gc:GroupColumn = new GroupColumn();
				gc.children.addItem(column);
				this.target.children.addItem(gc);
				
			}
		}
		
		
		/*
		 */
		
		private function setCurrentColumnToBeginning():void
		{
			
			//set the initial target group if there are children
			if(this.groupControllers && target && target.children.length > 0 && this.currentTargetController != this.groupControllers.getItemAt(0))
			{
				this.selectGroup(GroupColumnViewController(this.groupControllers.getItemAt(0)));
			}
		}
		
		/*
		 */
		
		private function selectGroup(controller:GroupColumnViewController):void
		{	
			controller.setSelected(true);
			  
			
		}
	}
}