package com.architectd.twitter.dataHandle
{
	

	public class AtomDataHandler extends DataHandler
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _dataClass:Class;
		private var _response:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function AtomDataHandler(dataClass:Class)
		{
			_dataClass = dataClass;
			
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function getResponseData2(raw:String) : *
		{
			var r:Array = [];
			
			raw = raw.replace(/xmlns=".*?"/igs,"");
			
			var x:XML = new XML(raw);
			
			for each(var entry:XML in x.entry)
			{
				r.push(new _dataClass(entry));
			}
			
			return r;
		}
	}
}