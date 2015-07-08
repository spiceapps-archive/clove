package com.spice.clove.plugin.impl.text.command.handle
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.core.text.command.ITextCommandTarget;
	import com.spice.vanilla.impl.proxy.ProxyOwner;

	public class CloveDataTextCommandTarget extends ProxyOwner implements ITextCommandTarget
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _target:ICloveData;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveDataTextCommandTarget()
		{
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getText():String
		{
			return _target.getMessage();
		}
		
		/**
		 */
		
		public function setText(value:String):void
		{
			_target.setMessage(value);
		}
		
		/**
		 */
		
		public function getTarget():ICloveData
		{
			return _target;
		}
		
		/**
		 */
		
		public function setTarget(value:ICloveData):void
		{
			_target = value;
		}
		
		
		
	}
}