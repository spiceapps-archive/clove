package com.spice.air.utils.sql.manage
{
	import com.spice.air.utils.FileUtil;
	import com.spice.utils.metadata.MetadataManager;
	
	import flash.data.SQLConnection;
	import flash.filesystem.File;

	public class SQLiteTableMetadataManager extends MetadataManager
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _sqlConnection:SQLConnection;
		private var _dbFile:File;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function SQLiteTableMetadataManager(dbFile:File,target:Object = null)
		{
			
			
			
			_dbFile = dbFile;
			
			super(target,"Table",SQLiteTableMetadataHandler,false);
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/*
		 */
		
		public function get sqlConnection():SQLConnection
		{
			return _sqlConnection;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		override protected function getMetadata() : void
		{
			if(this.hasMetadata())
			{
				_sqlConnection = new SQLConnection();
				_sqlConnection.open(_dbFile);
				
				
			}
			
			super.getMetadata();
		}
	}
}