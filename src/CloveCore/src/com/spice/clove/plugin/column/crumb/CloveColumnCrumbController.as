package com.spice.clove.plugin.column.crumb
{
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.vanilla.core.recycle.IDisposable;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	
	/*
	  handles clove colummns that dispatch the focus event 
	  @author craigcondon
	  
	 */	
	 
	[Event(name="targetColumnChange")]
	 
	public class CloveColumnCrumbController extends EventDispatcher implements IDisposable
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _root:CloveColumn;
		
		
		/*
		  the columns that have been focused on in a list. the last is the most recent
		 */		
		 
		private var _trail:ArrayCollection;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function CloveColumnCrumbController(rootColumn:CloveColumn = null)
		{
			
			_trail = new ArrayCollection();
			this.column = rootColumn;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		
		/*
		 */
		
		public function get column():CloveColumn
		{
			return this._root;
		}
		
		/*
		 */
		
		public function set column(value:CloveColumn):void
		{
			if(this._root)
			{
				_root.removeEventListener(CloveColumnEvent.FOCUS,onCloveColumnFocus); 
			}
			
			_root = value;
			
			//listen for on column change
			if(_root)
			_root.addEventListener(CloveColumnEvent.FOCUS,onCloveColumnFocus,false,0,true); 
		}
		
		/*
		 */
		
		public function get selectedIndex():int
		{
			return _trail.length - 1;
		}
		
		
		/*
		 */
		
		public function set selectedIndex(value:int):void
		{
			
			
			try
			{
				var col:ClovePluginColumn = this._trail.getItemAt(value) as ClovePluginColumn;
			}catch(e:*)
			{
				Logger.logError(e);
			}
			
			
			this._trail.source = this._trail.source.splice(0,value);

				
			
			if(col)
			{
				ClovePluginColumn(col).removeFromParent();
			}
			
			this.dispatchTargetColumnChange();
		}
		
		/*
		 */
		
		public function get trail():ArrayCollection
		{
			return _trail;
		}
		
		/*
		 */
		
		[Bindable(event="targetColumnChange")]
		public function get targetColumn():ClovePluginColumn
		{
			if(!this._trail || this._trail.length == 0)
				return null;
				
			return ClovePluginColumn(this._trail.getItemAt(_trail.length-1));
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
		/*
		  if a column has been focused upon, then add it the trail of breadcrumbs. 
		  @param event
		  
		 */       	
		 
		private function onCloveColumnFocus(event:CloveColumnEvent):void
		{
			
			var col:ClovePluginColumn = ClovePluginColumn(event.targetColumn);
			col.parent.addEventListener(CollectionEvent.COLLECTION_CHANGE,onChildrenChange);
			try
			{
				this._trail.addItem(col);
			}catch(e:Error)
			{
				Logger.logError(e);
			}
			
			this.dispatchTargetColumnChange();
			
		}
		
		/**
		 */
		
		public function dispose():void
		{
			if(!this._root)
			{
				return
			}
			
			_root = undefined;
			
			this._trail.removeAll();
			this._trail = undefined;
			
			this.dispatchEvent(new Event("targetColumnChange"));
		}
		
		
		/*
		 */
		
		private function dispatchTargetColumnChange():void
		{
			this.dispatchEvent(new Event("targetColumnChange"));
		}
		
		
		/*
		 */
		
		private function onChildrenChange(event:CollectionEvent):void
		{
			
			if(event.kind != CollectionEventKind.REMOVE)
				return;
				
				
			var col:ClovePluginColumn = event.items[0];
			
			var index:int = this._trail.getItemIndex(col);
			
			
			if(index < 0)
				return;
				
			
			this.selectedIndex = index;
		}
		
		
		
	}
}