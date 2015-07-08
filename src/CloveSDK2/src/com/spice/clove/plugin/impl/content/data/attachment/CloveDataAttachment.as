package com.spice.clove.plugin.impl.content.data.attachment
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.recycle.pool.ObjectPool;
	import com.spice.recycle.pool.ObjectPoolManager;
	
	import flash.display.DisplayObject;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	/**
	 * the concrete attachment that  
	 * @author craigcondon
	 * 
	 */	
	public class CloveDataAttachment 
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _type:String;
		private var _data:ICloveData;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveDataAttachment(type:String)
		{
			_type = type;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getType():String
		{
			return this._type;
			
		}
		
	}
}