package com.spice.air.utils.sql.manage.stmt
{
	import flash.data.SQLStatement;
	import flash.events.IEventDispatcher;

	public interface ISQLiteStmt extends IEventDispatcher
	{
		function get target():SQLStatement;
		function toString():String;
		function clone():ISQLiteStmt;
	}
}