package com.spice.clove.plugin.impl.content.control.option.menu
{
	import com.spice.clove.plugin.core.calls.CallCloveDataMenuOptionType;
	import com.spice.clove.plugin.core.content.control.option.menu.ICloveDataMenuOption;
	import com.spice.vanilla.core.notifications.Notification;
	import com.spice.vanilla.core.observer.IObserver;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;

	public class CloveDataMenuOption extends ProxyOwner implements ICloveDataMenuOption
	{
		  
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _name:String;
		private var _target:IObserver;
		private var _isSep:Boolean;
		private var _checked:Boolean;
		private var _enabled:Boolean;
		private var _subMenuItems:Vector.<ICloveDataMenuOption>;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveDataMenuOption(target:IObserver,isSep:Boolean = false,checked:Boolean = false,subMenuItems:Vector.<ICloveDataMenuOption> = null)
		{
			if(target)
			_name = target.getNotificationsOfInterest()[0];
			_target = target;
			_isSep = isSep;
			this._enabled = true;
			_checked = checked;
			_subMenuItems = subMenuItems ? subMenuItems : new Vector.<ICloveDataMenuOption>();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function removeSubMenuItems():void
		{
			this._subMenuItems = new Vector.<ICloveDataMenuOption>();
		}
		/**
		 */
		
		public function getSubMenuItems():Vector.<ICloveDataMenuOption>
		{
			return this._subMenuItems;
		}
		/**
		 */
		
		public function getName():String
		{
			return _name;
		}
		
		/**
		 */
		
		public function isSeparator():Boolean
		{
			return this._isSep;
		}
		
		/**
		 */
		
		
		public function checked():Boolean
		{
			return this._checked;
		}
		
		/**
		 */
		
		public function setChecked(value:Boolean):void
		{
			this._checked = value;
		}
		
		/**
		 */
		
		public function enabled():Boolean
		{
			return this._enabled;
		}
		
		
		/**
		 */
		public function setEnabled(value:Boolean):void
		{
			this._enabled = value;
		}
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallCloveDataMenuOptionType.GET_NAME: return this.respond(call,_name);
				case CallCloveDataMenuOptionType.IS_SEPARATOR: return this.respond(call,_isSep);
				case CallCloveDataMenuOptionType.GET_SUB_MENU_ITEMS: return this.respond(call,_subMenuItems);
			}
			
			if(call.getType() == _name)
			{
				this._target.notifyObserver(call);
			}
		}
		
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallCloveDataMenuOptionType.GET_NAME,
									CallCloveDataMenuOptionType.GET_SUB_MENU_ITEMS,
									CallCloveDataMenuOptionType.IS_SEPARATOR,
									_name]);
		}
		
	}
}