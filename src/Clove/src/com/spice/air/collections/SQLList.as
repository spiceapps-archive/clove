package com.spice.air.collections
{
	import com.ei.utils.ArrayUtils;
	import com.spice.air.utils.sql.IPaginatedDao;
	import com.spice.recycle.IDisposable;
	import com.spice.recycle.events.DisposableEventDispatcher;
	
	import mx.collections.IList;
	import mx.core.IPropertyChangeNotifier;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	
	/*
	  SQL list parses a database for a specific table, and parts of that
	  table are displayed in this list without consuming too much memory.
	 */
	 
	public class SQLList extends DisposableEventDispatcher implements IList, 
															IPropertyChangeNotifier
	{
															
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		
		/*
		  the current stack 
		 */
		
		private var _currentStack:Array;
		
		/*
		  the previous list containing the old data
		 */
		 
		private var _previousStack:Array;
		
		
		/*
		  the manager that handles all requests to a SQL database
		 */
		
		private var _dao:IPaginatedDao;
		
		
		/*
		  the current index start in the SQL database
		 */
		
		private var _index:int;
		
		
		/*
		  used to check if the last page was the index
		 */
		 
		private var _previousIndex:int;
		
		/*
		  the total number or items in the SQL database
		 */
		
		private var _length:int;
		
		/*
		  calculates the size of any display list showing data. this is NEEDED to allocate the buffer size
		  incase it's too small. Too small = request every change
		 */
		 
		private var _calcSizeInt:int;
		
		/*
		  the start index of the size calculation
		 */
		 
		private var _startRange:int;
		
		/*
		  the end index of the size calculation
		 */
		
		private var _toRange:int;
		
		
		/*
		  the number of items to pull from the database on each query
		 */
		
		private var _bufferSize:int;
		
		
		/*
		  the minimum buffer size. take this num and multiply it by two. 
		 */
		
		private static const DEFAULT_BUFFER_SIZE:int = 30;
		
		
		private var _uid:String;
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var everyNewItem:Function;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
          Constructor.
          @pram connection the SQL connection to the current database
          @param select the items to select from the table
          @param where the table to select the items from
          @param orderBy the column to order the list by
          @param groupBy the search ID to use for counting row data FIXME: better solution?
          @param renderer the function that handles new SQLResults
		 */
		 
		
		public function SQLList(dao:IPaginatedDao)
		{
			
			_dao 			   = dao;
			
			_currentStack      = [];
			this._previousStack = [];
			
			//TEMP
			this.onCalc();
			
			this.update();
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/*
		 */
		
		public function get actualLength():int
		{
			return _currentStack.length;
		}
		
		/*
		 */
		
		public function get length():int
		{
			
			return _length;
		}
		
		/*
		 */
		
		public function get uid():String
		{
			return _uid;
		}
		
		/*
		 */
		
		public function set uid(value:String):void
		{
			_uid = value;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /*
		 */
		
		public function update(startIndex:int = 0):void
		{
			this.reset();
			
			
			this.dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,true,false,CollectionEventKind.REFRESH));
			
		}
		
        
        /*
		 */
		
		public function getItemAt(index:int,prefetch:int = 0):Object
		{
			if(index < 0)
				return null;
			
			if(_startRange == -1)
			{
				_startRange = index;
			}
			
			if(index > _toRange)
			{
				_toRange = index;
			}
			
			//get the current page
			var newPage:int      = Math.floor(index / _bufferSize);
			
			//get the current list index
			var currentIndex:int = index % _bufferSize
			
			var returnItem:Object;
			
			//keep the previous pages in the buffer so that 
			if(newPage != _index || _index == -1)
			{
				//if the user is passing through data smoothly, then the previous indexes
				//will come up again, so we'll save the database from jumping back and forth
				//and store the last buffer
//				
				
				if(_previousIndex == newPage)
				{
					//
					if(currentIndex < _previousStack.length)
					{
						returnItem = this._previousStack[currentIndex];
						
						if(this.everyNewItem != null)
						{
							this.everyNewItem(returnItem);
						}
						
						return returnItem;
					}
				}
				else
				{
					_previousIndex = _index;			
					_index 		   = newPage;
				
					this.paginate(newPage*_bufferSize);
					
					/* clearTimeout(_calcSizeInt);
					_calcSizeInt = setTimeout(onCalc,100); */
			
				}
			}
			
			
			
			//we calculate the size of the list so we can allocate more data if the view is larger than the default buffer size
			//if the view shows MORE than the default buffer size, the database will be queried everytime the list changes
			
			if(currentIndex <  _currentStack.length)
			{
				returnItem = this._currentStack[currentIndex];
				
				if(this.everyNewItem != null)
				{
					this.everyNewItem(returnItem);
				}
				
				return  returnItem;
			
			}
			
			
			
			return null;
		}
		
		
		
		/*
		 */
		
		public function getItemIndex(item:Object):int
		{
			
			return _currentStack.indexOf(item);
		}
		
		/*
		 */
		
		public function addItem(item:Object):void
		{
			_currentStack.push(item);
			
			_length++;
			
			this.dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,false,false,CollectionEventKind.ADD,_currentStack.length-1));
			
		}
		
		/*
		 */
		
		public function addItemAt(item:Object,index:int):void
		{
			ArrayUtils.insertAt(_currentStack,item,index);
			
			_length++;
			this.dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,false,false,CollectionEventKind.ADD,index));
			
			
		}
		
		
		/*
		 */
		
		public function itemUpdated(item:Object, property:Object = null, 
                         oldValue:Object = null, 
                         newValue:Object = null):void
        {
        	
        	//_list.itemUpdated(item,property,oldValue,newValue);
        }
        
        /*
          good to call when the list is not in view. It will always
          re-populate when viewed again :)
		 */
        
        
        public function removeAll():void
        {
        	
        	
        	this.disposeStack(this._currentStack);
        	
        	if(this._previousStack)
				this.disposeStack(this._previousStack);
        	
        	this.reset();
        	
        	this._currentStack = [];
        	this._previousStack = [];
        	
        	
			this.dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,true,false,CollectionEventKind.RESET));
        	
        	
        }
        
        /*
		 */
		
		public function removeItemAt(index:int):Object
		{	
			var item:Object = this._currentStack[index];
			
			_currentStack.splice(index,1);
			
			if(item is IDisposable)
			{
				IDisposable(item).dispose();
			}
			
			return item;
		}
		
		
		/*
		 */
		
		public function removeItem(item:Object):void
		{
			this._dao.removeItem(item);
			
			this.update();
		}
		
		/*
		 */
		
		public function setItemAt(value:Object,index:int):Object
		{
			ArrayUtils.insertAt(this._currentStack,value,index);
			
			return value;
		}
		
		/*
		 */
		
		public function toArray():Array
		{
			return _currentStack.concat();
		}


		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		protected function defaultItemRenderer(item:Object):Object
		{
			return item;
		}
		
		/*
		 */
		
		protected function paginate(page:int):void
		{
			
			
			var result:Array = 	_dao.getListRange(page,_bufferSize);
			
			if(result)
			{
				if(this._previousStack)
					this.disposeStack(this._previousStack);
				
				this._previousStack		   = this._currentStack;
				this._currentStack		   = result;
			}
			
		}
		
		
		/*
		 */
		
		override protected function dispose2() : void
		{
			super.dispose2();
			
			this.removeAll();
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private function onCalc():void
		{
			var newBufferSize:int = _toRange - _startRange;
			
			
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//sometimes data comes back as null, or the buffer size is super huge >.>
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			
			_bufferSize = 30;//newBufferSize > DEFAULT_BUFFER_SIZE ? newBufferSize : _bufferSize;
			//_bufferSize = _toRange - _startRange;
			
			_startRange = -1;
			_toRange    = -1;
		}
		
        /*
		 */
		
		private function onCollectionChange(event:CollectionEvent):void
		{
			dispatchEvent(event.clone());
		}
		
		
		
		
		/*
		 */
		
		public function reset():void
		{
			_index      	   = -1;
			_previousIndex     = -1;
			_bufferSize		   = DEFAULT_BUFFER_SIZE;
			this._length	   = this._dao.dataSize;
			
			
			this.onCalc();
		}
		
		/*
		 */
		
		private function disposeStack(stack:Array):void
		{
			for each(var item:* in stack)
			{
				
				
				if(item is IDisposable)
				{
					item.dispose();
				}
			}	
			
		}

	}
}