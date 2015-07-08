package com.spice.clove.plugin.core.notifications
{
	import com.spice.vanilla.core.notifications.Notification;
	
	
	public class FillColumnNotification extends Notification
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		public static const FILL_COLUMN:String = "fillColumn";
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _saveType:int;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FillColumnNotification(data:Array,saveType:int)
		{
			super(FILL_COLUMN,data);
			_saveType = saveType;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function saveType():int
		{
			return _saveType;
		}
	}
}