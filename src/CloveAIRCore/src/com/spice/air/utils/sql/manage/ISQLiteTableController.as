package com.spice.air.utils.sql.manage
{
	
	import com.spice.utils.queue.cue.Cue;
	
	import flash.data.SQLConnection;
	import flash.events.IEventDispatcher;

	public interface ISQLiteTableController extends IEventDispatcher
	{
		function get target():ConcreteSQLiteTableController;
		function get dao():DAOController;
		function get readConnection():SQLConnection;
		function get writeConnection():SQLConnection;
		
//		function get firstRow():*;
//		function get lastRow():*;
		
		[Bindable(event="collectionChange")]
		function get numRows():Number;
		
		function insert(items:Array):Cue;
		function update(items:Array):Cue;
		function remove(items:Array,limit:Number = 0):Cue;
		function removeAll(truncate:Boolean = false):void;
		
		function selectAll():Array;
		function paginate(limit:Number = 0,offset:Number = 0):Array;
	}
}