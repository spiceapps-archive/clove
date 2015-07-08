package com.spice.clove.web.plugin.root.history
{
	import com.spice.clove.events.ColumnHistoryEvent;
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.IColumnHistory;
	import com.spice.clove.plugin.column.column_internal;
	import com.spice.clove.plugin.content.data.CloveAppData;
	import com.spice.clove.plugin.core.root.history.ConcreteColumnHistory;
	import com.spice.clove.web.plugin.root.WebRootPlugin;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	use namespace column_internal;
	
	public class WebColumnHistory extends ConcreteColumnHistory implements IColumnHistory
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _allHistory:ArrayCollection;
		private var _history:ArrayCollection;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function WebColumnHistory(target:CloveColumn,plugin:WebRootPlugin)
		{
			super(target,plugin);
			
			_allHistory = new ArrayCollection();
			_history    = new ArrayCollection();
			_target     = target;
			
			this.setList(_allHistory);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		
		/**
		 */
		
		override public function get id():String
		{
			return null;
		}
		
		/**
		 */
		
		override public function get numUnread():int
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
		
		override public function addHistory(batch:Array,saveFlags:int = 0):void
		{
			var hist:Array = [];
			
			var rcd:CloveAppData;
			
			for each(var histItem:Object in batch)
			{
				if(this.hasHistItem(histItem))
					continue;
				
				rcd = new CloveAppData();
				
				this._itemRenderer.setCloveData(histItem,rcd);
				
				rcd.setItemRenderer(this._itemRenderer);
				
				hist.push(rcd);
			}
			
			
			if(hist.length == 0)
				return;
			
			this._history.source = this._history.source.concat(hist);
			
			this._target.dispatchEvent(new ColumnHistoryEvent(ColumnHistoryEvent.HISTORY_CHANGE,true,false,CollectionEventKind.ADD));
			
			
		}
		
		
		/**
		 */
		
		override public function toObject():Object
		{
			return {};
		}
		
		/**
		 */
		
		override public function removeAllItems():void
		{
			_history.removeAll();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function onChildrenChange(event:CollectionEvent=null):void
		{
			super.onChildrenChange(event);
			
			
			//if(event && event.kind != CollectionEventKind.REMOVE)
			//	return;
			
			
			this.onChildrenHistoryChange(null);
		}
		
		/**
		 */
		
		override protected function onChildrenHistoryChange(event:CollectionEvent):void
		{
			super.onChildrenHistoryChange(event);
			
			this._allHistory.source = this.getAllHistory();
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
			for each(var rcd:CloveAppData in this._history.source)
			{
				if(rcd.rowuid == _target.itemRenderer.getUID(histItem))
					return true;
			}
			
			return false;
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
		
		
	}
}