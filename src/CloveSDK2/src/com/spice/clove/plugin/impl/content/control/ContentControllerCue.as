package com.spice.clove.plugin.impl.content.control
{
	import com.spice.clove.plugin.core.calls.CallCloveContentControllerType;
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.clove.plugin.core.notifications.FillColumnNotification;
	import com.spice.impl.queue.AbstractCue;
	import com.spice.impl.queue.ImpatientCue;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.observer.IObserver;

	internal class ContentControllerCue extends ImpatientCue implements IObserver
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _target:CloveContentController;
		private var _data:ICloveData;
		private var _noi:Vector.<String>;
		private var _loadOlder:Boolean;
		
		
		public static const MAX_WAIT_TIME:int = 8000;//8 seconds
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ContentControllerCue(target:CloveContentController,data:ICloveData = null,loadOlder:Boolean = false)
		{
			super(MAX_WAIT_TIME);
			
			this._target = target;
			this._data = data;
			this._loadOlder = loadOlder;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getNotificationsOfInterest():Vector.<String>
		{
			return this._noi;
		}
		/**
		 */
		
		public function notifyObserver(n:INotification):void
		{
			switch(n.getType())
			{
				case FillColumnNotification.FILL_COLUMN:
					this._target.getProxy().unbindObserver(this);
					this.complete();
				break;
			}
		}
		/**
		 */
		
		override public function initialize():void
		{
			super.initialize();
			
			this._noi = new Vector.<String>(1,true);
			this._noi[0] = FillColumnNotification.FILL_COLUMN;
			
			this._target.getProxy().bindObserver(this);
			
			if(this._loadOlder)
			{
				this._target.internalLoadOlder(this._data);
			}
			else
			{
				this._target.internalLoadNewer(this._data);
			}
		}
		
		
		/**
		 */
		
		override public function dispose():void
		{
			super.dispose();
			
			this._target._loading = false;
		}
		
		
		/**
		 */
		
		override protected function complete(status:*=true):void
		{
			
			if(this._target.getLoadingState() == CloveContentControllerState.LOADING)
				this._target.setLoadingState(CloveContentControllerState.COMPLETE);
			
			this._target._loading = false;
			super.complete(status);
			this._loadOlder = false;
		}
		
		
		
	}
}