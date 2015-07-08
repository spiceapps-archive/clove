package com.spice.clove.view.column
{
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.crumb.CloveColumnCrumbController;
	import com.spice.utils.weak.WeakObjectLink;
	import com.spice.vanilla.core.recycle.IDisposable;
	import com.spice.vanilla.flash.gc.Janitor;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.core.IDataRenderer;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	
	/*
	  
	  @author craigcondon
	  
	 */	
	public class ColumnViewController extends EventDispatcher implements IDataRenderer, 
																		  IDisposable
	{
		  
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 * the target column this view controller belongs to 
		 */		
		
		private var _target:ClovePluginColumn;
		
		/**
		 * the target child view controller 
		 */		
		private var _currentTargetController:ColumnViewController;
		
		/**
		 * link to THIS column view controller 
		 */		
		
		private var _link:WeakObjectLink;
		
		/**
		 * the breadcrumb controller for the column  
		 */		
		
		private var _breadcrumb:CloveColumnCrumbController;
		
		/**
		 * manages the events for this column so we can easily clean them up 
		 */		
		protected var _janitor:Janitor;
		
		
		private var _selected:Boolean;
		
		
		[Bindable] 
		public var currentViewState:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ColumnViewController(target:ClovePluginColumn = null)
		{
			super();
			
			_link = new WeakObjectLink(null,this,ColumnViewEventEnum.GET_CONTROLLER,true);
			
			_janitor = new Janitor();
			
			this.setTarget(target);
			
			if(_target)
				this.addColumnListeners();
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/*
		  Column view controllers are databound to by the parent column, which uses IDataRenderer
		 */
		
		public function get data():Object
		{
			return this.target;
		}
		
		/*
		 */
		
		public function set data(value:Object):void
		{
			this.target = ClovePluginColumn(value);
		}
		
		/*
		 */
		
		public function get viewClass():Class
		{
			return null;
		}
		
		/*
		 */
		[Disposable]
		[Bindable(event="newTarget")]
		public function get target():ClovePluginColumn
		{
			
			return this._target;
		}
		
		/*
		 */
		
		[Bindable(event="newTargetController")]
		public function get currentTargetController():ColumnViewController
		{
			return this._currentTargetController;
		}
		
		
        /*
		 */
		
		public function set target(value:ClovePluginColumn):void
		{
			this.cleanupColumnListeners();
			
			if(this._target != value)
			this.setTarget(value);
			
			this.addColumnListeners();
		}
		
		
		/*
		  controls the multiple sub-views of the current column being viewed. This
		  is particularely useful when using comments. Check out Tweetie for a good
		  example of this 
		  @return 
		  
		 */		
		[Bindable(event="newTarget")]
		public function get breadCrumb():CloveColumnCrumbController
		{
			return this._breadcrumb;
		}

		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/*
		 */
		
		[Bindable(event="selectController")]
		public function get selected():Boolean
		{
			return _selected;
		}
		
		
		/*
		  bypasses binding when the bool value is the same
		 */
		
		public function setSelected(value:Boolean):void
		{
			
			;
			
			
			if(value == _selected)
				return;
			
			
			
			_selected = value;
			
			
			
			
			if(value && this.target)
			{	
				
				
				
				this.getController(this.target.parent).__currentTargetController = this;
				
			}
			
			
			
			this.dispatchEvent(new Event("selectController"));
		}
		
		
		/*
		 */
		
		protected function set __currentTargetController(value:ColumnViewController):void
		{
			if(this._currentTargetController)
			{
				this._currentTargetController.setSelected(false);
			}
			
			
			this._currentTargetController = value;
			
			this.dispatchEvent(new Event("newTargetController"));
			
			
			
			
		}
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		
		/*
		 */
		
		public function getSetting(name:String):Object
		{
			return this._target.metadata.getSetting(name);
		}
		
		
		
		/*
		 */
		
		public function getController(target:CloveColumn):ColumnViewController
		{
			
			return WeakObjectLink.getLinks(ColumnViewEventEnum.GET_CONTROLLER,target)[0];
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        
        public function dispose():void
        {
			if(!_link)
				return;
			
			_janitor.dispose();
        	
			_link.dispose();
			
			this.target = undefined;
			this._janitor = undefined;
			this.__currentTargetController = undefined;
			this._link = undefined;
			this._breadcrumb = undefined;
			
        }
       
		
        /*
		 */
		
		protected function addColumnListeners():void
		{
			
			this.cleanupColumnListeners();
			
			if(!_target)
				return;
				
			
			
			this._janitor.addEventListener(_target.children,CollectionEvent.COLLECTION_CHANGE,onColumnChange,false,0,true);
			
		}
		
		/*
		 */
		
		protected function cleanupColumnListeners():void
		{
			if(!_target)
				return;
			
			_janitor.cleanUpListeners(this._target);
			_janitor.cleanUpListeners(_target.children);
		}
		
		
		/*
		 */
		
		protected function setTarget(target:ClovePluginColumn):void
		{
			
			
			
			
			_target = target;
			
			
			if(_link)
				_link.target = target;
			
			
			if(target)
				this._breadcrumb = ClovePluginColumn(target).breadcrumbController;
			else
				this._breadcrumb = undefined;
			
			
			//if the parent does not exist, do not dispatch a binded event
			//(column hist returns null and fucks it up)
			if(!_target || _target.parent)
			{	
				//dispatchEvent(new Event("newTarget"));
			}	
			
			//we NEED TO DISPATCH A NEW TARGET command, otherwise we cannot unbind
			dispatchEvent(new Event("newTarget"));
		}
		
		
		/*
		 */
		
		protected function onColumnChange(event:CollectionEvent):void
		{
			if(event.kind == CollectionEventKind.REMOVE)
			{
				var target:ClovePluginColumn = event.items[0];
				
				
				//if the current target controller is the removed item, then set the target to null
				if(this._target.children.length == 0 || (this.currentTargetController && target == this.currentTargetController.target))
				{
					this.__currentTargetController = null;
				}
			}
		}
		
		

	}
}