package
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	
	[Event("installApp")]
	
	public class InstallerButton extends Sprite
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _states:Array;
		private var _cs:int;
		private var _cc:DisplayObject;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function InstallerButton()
		{
			_states = [];
			
			_states.push(new (Buttons.LOADING));
			
			var but:SimpleButton = new SimpleButton(new (Buttons.SCOUT_DOWNLOAD_N),new (Buttons.SCOUT_DOWNLOAD_N),new (Buttons.SCOUT_DOWNLOAD_P),new (Buttons.SCOUT_DOWNLOAD_N));
			but.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			_states.push(but);
			_states.push(new (Buttons.INSTALLING_SCOUT));
			_states.push(new (Buttons.INSTALLING_AIR));
			_states.push(new (Buttons.ERROR_INSTALLING));
			_states.push(new (Buttons.ERROR));
			_states.push(new (Buttons.ERROR_LOADING));
			
			this.currentState = InstallerState.LOADING;
		}
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get currentState():int
		{
			return _cs;
		}
		
		/**
		 */
		
		public function set currentState(value:int):void
		{
			if(_cc)
			{
				removeChild(_cc);
			}
			
			_cc = addChild(this._states[value]);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onMouseUp(event:MouseEvent):void
		{
			this.dispatchEvent(new Event("installApp"));
		}
	}
}