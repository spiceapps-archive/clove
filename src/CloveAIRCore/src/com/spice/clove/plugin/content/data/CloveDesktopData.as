package com.spice.clove.plugin.content.data
{
	
	import com.spice.clove.plugin.core.root.desktop.history.ColumnSQLHistory;
	import com.spice.clove.plugin.impl.content.control.ContentSaveType;
	import com.spice.vanilla.core.settings.ISettingTable;
	
	import flash.utils.ByteArray;

	public class CloveDesktopData extends CloveAppData
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 * for SQLIte 
		 */		
		public var dbid:int;
		
		
		/**
		 * for getting the column ID back 
		 */		
		
		public var columnid:String;
		
		/**
		 * the UID data specific to the column, since multiple columns can retain the same data 
		 */			
		
		public var columnDataUID:String;
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _storedMetadata:ByteArray;
		private var _columnSQLHistory:ColumnSQLHistory;
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		
		public function set metadata(value:ByteArray):void
		{
			this._storedMetadata = value;
		}
		
		/**
		 */
		
		public function get metadata():ByteArray
		{
			var ba:ByteArray = new ByteArray();
			this.getSettingTable().writeExternal(ba);
			ba.position = 0;
			return ba;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		
		override public function dispose():void
		{
			super.dispose();
			
			if(!this._storedMetadata)
				return;
			
			this._storedMetadata.clear();
			this._storedMetadata = null;
			
			this._columnSQLHistory = null;
			
		}
		/**
		 */
		
		override public function updateData():void
		{
			super.updateData();
			  
			_columnSQLHistory.update([this]);
		}
		
		
		/**
		 */
		
		public function setColumnHistory(value:ColumnSQLHistory):void
		{
			_columnSQLHistory = value;
		}
		
		/**
		 */
		
		override public function getSettingTable():ISettingTable
		{
			var table:ISettingTable = super.getSettingTable();
			
			if(this._storedMetadata)
			{
				this._storedMetadata.position = 0;
				table.readExternal(_storedMetadata);
				_storedMetadata = null;
			}
			
			return table;
		}
		
		
		
	}
}