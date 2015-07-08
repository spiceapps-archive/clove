package com.spice.clove.plugin.core.column.history
{
	import com.spice.clove.events.ColumnHistoryEvent;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.IColumnHistory;
	import com.spice.clove.plugin.column.column_internal;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.recycle.events.DisposableEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	use namespace column_internal;
	
	public class WebColumnHistory extends DisposableEventDispatcher implements IColumnHistory
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _allHistory:ArrayCollection;
		private var _history:ArrayCollection;
		private var _target:ClovePluginColumn;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function WebColumnHistory(target:ClovePluginColumn)
		{
			_allHistory = new ArrayCollection();
			_history    = new ArrayCollection();
			_target     = target;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get currentData():IList
		{
			return this._allHistory;
		}
		
		/**
		 */
		
		public function get id():String
		{
			return null;
		}
		
		/**
		 */
		
		public function get numUnread():int
		{
			return 0;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function addHistory(batch:Object,saveFlags:int = 0):void
		{
			var hist:Array = [];
			
			var rcd:RenderedColumnData;
			
			for each(var histItem:Object in batch)
			{
				if(this.hasHistItem(histItem))
					continue;
				
				rcd = this._target.itemRenderer.getRenderedData(histItem);
				rcd.setColumn(this._target);
				
				hist.push(rcd);
			}
			
			
			if(hist.length == 0)
				return;
			
			this._history.source = this._history.source.concat(hist);
			
			this._target.dispatchEvent(new ColumnHistoryEvent(ColumnHistoryEvent.HISTORY_CHANGE,true,false,CollectionEventKind.ADD));
			
			
			
		}
		
		/**
		 */
		
		public function flush():void
		{
			_history.removeAll();
		}
		
		/**
		 */
		
		public function init():void
		{
			this._target.addEventListener( ColumnHistoryEvent.HISTORY_CHANGE,onColumnHistoryChange);
			this._target.children.addEventListener(CollectionEvent.COLLECTION_CHANGE,onTargetChildrenChange);
		}
		
		/**
		 */
		
		public function toObject():Object
		{
			return {};
		}
		
		/**
		 */
		
		public function removeAllItems():void
		{
			this.flush();
		}
			
			
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function hasHistItem(histItem:Object):Boolean
		{
			for each(var rcd:RenderedColumnData in this._history.source)
			{
				if(rcd.rowuid == _target.itemRenderer.getUID(histItem))
					return true;
			}
			
			return false;
		}
		
		
		/**
		 */
		
		private function onColumnHistoryChange(event:ColumnHistoryEvent = null):void
		{
			this._allHistory.source = this.getAllHistory();
		}
		
		
		/**
		 */
		
		public function getAllHistory():Array
		{
			var hist:Array = this._history.source;
			
			for each(var child:ClovePluginColumn in Object(_target.children).source)
			{
				hist = hist.concat(WebColumnHistory(child.history).getAllHistory());
			}	
			
			return hist;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onTargetChildrenChange(event:CollectionEvent):void
		{
			if(event.kind != CollectionEventKind.REMOVE)
				return;
				
			this.onColumnHistoryChange();
		}

	}
}