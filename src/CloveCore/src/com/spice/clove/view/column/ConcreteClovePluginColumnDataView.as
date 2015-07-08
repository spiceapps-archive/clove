package com.spice.clove.view.column
{
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.model.CloveModelLocator;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.display.controls.list.SmoothList;
	
	import flash.events.Event;
	
	import mx.collections.IList;
	import mx.core.ClassFactory;
	import mx.events.CollectionEvent;
	
	
	/*
	The default used by columns. 
	@author craigcondon
	
	*/
	
	public class ConcreteClovePluginColumnDataView extends SmoothList
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _model:CloveModelLocator = CloveModelLocator.getInstance();
		
		
		private var _column:ClovePluginColumn;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		*/
		
		
		public function ConcreteClovePluginColumnDataView(rowViewClass:Class)
		{
			super();
			
			this.minRowHeight = 75;
			//this.allowMultipleSelection = true;
			//this.variableRowHeight 	    = true;
			//this.wordWrap 				= true;
			this.itemRenderer	 = new ClassFactory(rowViewClass);
			this.percentHeight = 100;
			this.percentWidth = 100;
			this.setStyle("backgroundAlpha",0);
			this.setStyle("borderStyle","none");
			this.setStyle("paddingRight",7);
			//this.verticalScrollPolicy = "on";
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded,false,0,true);
			//this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved,false,0,true);
			//this.addEventListener(KeyboardEvent.KEY_DOWN,onDelete,false,0,true);
			//this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved,false,0,true);
			//this.addEventListener(ListEvent.ITEM_CLICK,onItemClick,false,0,true);
			
			this.addEventListener("currentIndexChange",onIndexChange);
			this.addEventListener("scrolledToBottom",onScrolledToBottom);
			this.addEventListener("scrolledToTop",onScrolledToTop);
			
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
			
			
			this._column = ClovePluginColumn(value);
			
			
			if(!value)
			{
				
				if(this.dataProvider)
				{
					var list:* = this.dataProvider.list;
					
					this.dataProvider = null;
					
					list.removeAll();
					
				}
				this.flush();
				return;
			}
			//set the start scroll position so that any unseen content does NOT get rendered!!
			
//			if(_model.applicationSettings.mainUISettings.autoScroll)
				this.startIndex = this._column.getNumUnread().getData();
			
			
			;
		}
		/*
		*/
		
		public function get verticalGap():int
		{
			return this.getStyle("verticalGap");
		}
		
		/*
		*/
		
		public function set verticalGap(value:int):void
		{
			
			this.setStyle("verticalGap",value);
			
			//this.updateDisplayList(this.unscaledWidth,this.unscaledHeight);
		}
		
		
		/*
		*/
		
		override public function dispose() : void
		{
			
			
			
			var dp:Object;
			
			if(this.dataProvider)
				dp = this.dataProvider.list;
			
			super.dispose();
			
			
			this.data = undefined;
			
			if(dp)
			dp.removeAll();
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		
		/*
		listen for the target index change so we can cache the scroll position 
		@param event
		
		*/       	
		
		private function onIndexChange(event:Event):void
		{
			if(this._column && _model.applicationSettings.mainUISettings.autoScroll)
				this._column.targetIndex.setData(this.currentIndex);
			
		}
		
		
		/*
		*/
		
		private function onAdded(event:Event):void
		{
			
			if(!event.currentTarget == this)
				return;
			
			this.verticalGap = 10;
			
		}
		
		/*
		*/
		
		private function onScrolledToBottom(event:Event):void
		{
			var dp:IList = this.dataProvider as IList;
			
			
			//get the last item
			var lastRD:ICloveData = ICloveData(dp.getItemAt(dp.length-1));
			
			this._column.loadOlderContent(true,lastRD);
			
			/*for each(var child:ClovePluginColumn in this._column.flattenedColumns)
			{
			lastRD = CloveData(child.dataProvider.getItemAt(child.dataProvider.length-1));
			
			if(!lastRD)
			continue;
			
			
			child.load
			child.dispatchEvent(new CloveColumnEvent(CloveColumnEvent.LOAD_OLDER_CONTENT,child,false,lastRD));
			}*/
			
			
			
		}
		
		/**
		 */
		
		private function onScrolledToTop(event:Event):void
		{
			if(!this._column)
				return;
			
			this._column.markAllRead();
		}
		
		
		
		
		/*
		*/
		
		private function onItemClick(event:Event):void
		{
			
			/*for each(var item:RenderedColumnData in this.selectedItems)
			{
			//item.column.markRead(item);
			}*/
			
			
			
		}
		
		private var _renderInt:int;
		
	}
}