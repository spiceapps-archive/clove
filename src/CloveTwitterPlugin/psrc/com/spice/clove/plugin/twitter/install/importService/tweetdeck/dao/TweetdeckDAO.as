package com.spice.clove.plugin.twitter.install.importService.tweetdeck.dao
{
	
	import com.spice.clove.plugin.twitter.install.importService.tweetdeck.TweetdeckColumnType;
	import com.spice.utils.classSwitch.data.SSQLStatement;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.filesystem.File;
	
	public class TweetdeckDAO
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _columnStmt:SQLStatement;
		private var _groupStmt:SQLStatement;
		private var _sql:SQLConnection;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TweetdeckDAO(db:File)
		{
			_sql = new SQLConnection();
			
			//not running AIR
			if(!_sql)
				return;
			
			_sql.open(db);
			
			_columnStmt = new SQLStatement();
			_columnStmt.text = "SELECT * FROM `columns`";
			
			
			_groupStmt = new SQLStatement();
			_groupStmt.text = "SELECT * FROM `groups` WHERE `gCID` = :colid";
			
			_columnStmt.sqlConnection = 
			_groupStmt.sqlConnection  = 
			_sql;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get columns():Array
		{
			if(!_sql)
				return [];
				
			var importedColumns:Array = new Array();
			
			
			_columnStmt.execute();
			
			var cols:Array = _columnStmt.getResult().data;
			
			
			var convCol:TweetdeckColumn;
			
			for each(var col:Object in cols)
			{
				convCol = new TweetdeckColumn(col.cType,col.cTerm,col.cName);
				
				if(convCol.type == TweetdeckColumnType.TWITTER_GROUP)
				{
					
					_groupStmt.parameters[":colid"] = col.cID;
					_groupStmt.execute();
					var groupDat:Array = _groupStmt.getResult().data;
					
					
					for each(var friend:Object in groupDat)
					{
						convCol.subColumns.push(new TweetdeckColumn(TweetdeckColumnType.TWITTER_FRIEND,friend.gUserID));
					}
				}
				
				importedColumns.push(convCol);
			}
			
			
			return importedColumns;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function close():void
		{
			if(_sql)
				_sql.close();
		}
	}
}