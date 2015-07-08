package com.spice.clove.plugin.column
{
	import com.spice.clove.plugin.column.IColumnHistory;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	
	/*
	  controls how columns can handle their data, and delegates information
	  the column can use. This is for specific environments incase the project goes remote
	 */
	
	public class ColumnHistoryController implements IExternalizable
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ColumnHistoryController()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function getHistManager(target:CloveColumn):IColumnHistory
		{
			//abstract
			return null;
		}
		
		/*
		 */
		
		public function build(target:CloveColumn,data:ByteArray):IColumnHistory
		{
			return null;
		}
		
		/*
		 */
		
		public function writeExternal(value:IDataOutput):void
		{
			
		}
		
		/**
		 */
		
		public function readExternal(value:IDataInput):void
		{
			
		}
		
	}
}