package com.spice.clove.plugin.core.root.desktop.history
{
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ClovePluginColumn;
	import com.spice.clove.plugin.column.ColumnHistoryController;
	import com.spice.clove.plugin.column.IColumnHistory;
	import com.spice.clove.plugin.column.column_internal;
	import com.spice.clove.plugin.core.column.*;
	import com.spice.clove.plugin.core.root.desktop.CloveDesktopRootPlugin;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	use namespace column_internal;
	
	public class DesktopHistoryController extends ColumnHistoryController
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:CloveDesktopRootPlugin;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function DesktopHistoryController(plugin:CloveDesktopRootPlugin)
		{
			_plugin = plugin;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getHistManager(target:CloveColumn):IColumnHistory
		{
			return new ColumnSQLHistory(target,_plugin);
		}
		
		/**
		 */
		
		override public function build(target:CloveColumn, data:ByteArray):IColumnHistory
		{
			return new ColumnSQLHistory(target,_plugin,data);
		}
		
		
		
		/**
		 */
		
		override public function  writeExternal(value:IDataOutput):void
		{
			//target.historyManager.writeExternal(value);
		}
		
		
		/**
		 */
		
		override public function  readExternal(value:IDataInput):void
		{
			//target.historyManager.readExternal(value);
		}
		
		
		
	}
}