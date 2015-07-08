package com.spice.air.utils.sql
{
	
	/*
	  used by the SQLList to paginate content stored in a SQLLite database 
	  @author craigcondon
	  
	 */	
	public interface IPaginatedDao
	{
		
		/*
		  returns saved data 
		  @param index the start index
		  @param limit the item limit
		  
		 */		
		 
		function getListRange(index:int,limit:int):Array;
		
		/*
		  removes an item stored in the database
		  @param item the item to remove
		  
		 */		
		 
		function removeItem(item:Object):void;
		
		/*
		  the database 
		  @return 
		  
		 */		
		 
		function get dataSize():int;
	}
}