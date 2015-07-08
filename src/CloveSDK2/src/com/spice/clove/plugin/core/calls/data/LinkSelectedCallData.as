package com.spice.clove.plugin.core.calls.data
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.vanilla.core.recycle.IDisposable;
	
	
	/**
	 * data passed through the ProxyCall data parameter 
	 * @author craigcondon
	 * 
	 */	
	
	public class LinkSelectedCallData implements IDisposable
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _data:ICloveData;
		private var _link:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function LinkSelectedCallData(data:ICloveData,link:String)
		{
			_data = data;
			_link = link;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getCloveData():ICloveData
		{
			return _data;
		}
		
		/**
		 */
		
		public function getLink():String
		{
			return _link;
		}
		
		
		/**
		 */
		
		public function dispose():void
		{
			_data = null;
			_link = null;
		}
		
	}
}