package com.spice.clove.plugin.column
{
	import com.spice.recycle.IDisposable;
	
	import flash.events.IEventDispatcher;
	import flash.utils.IExternalizable;
	
	import mx.collections.IList;
	
	
	/*
	  The history manager handles cached content saved to each column.
	  @author craigcondon
	  
	 */	
	
	public interface IColumnHistory extends IEventDispatcher, IDisposable, IExternalizable
	{
		
		/*
		  adds a batch of data to the column 
		  @param batch the data returned by a service
		  @param flags the save flags
		  
		 */
		 		
		function addHistory(batch:Array,flags:int = 0,isOlder:Boolean = false):void;
		
		/* 
		  @Depricated
		 */				
		 
		//function flush():void;
		
		/*
		  the current paginated data
		 */		
		 
		function get currentData():IList;
		
		
		function get id():String;
		
		
		/*
		 */
		
		function init():void;
		
		
		
		/*
		   
		  @return number of items not read
		  
		 */		
		function get numUnread():int;/*
		function markRead(data:RenderedColumnData):void;
		function markAllRead():void; */
		
		
		/* 
		  removes all the items in the database
		 */		
		function removeAllItems(removeDeleted:Boolean = false):void;
	}
}