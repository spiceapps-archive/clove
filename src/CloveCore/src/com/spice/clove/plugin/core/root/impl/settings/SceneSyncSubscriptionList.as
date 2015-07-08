package com.spice.clove.plugin.core.root.impl.settings
{
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	/**
	 * cached scene sync subscription data  
	 * @author craigcondon
	 * 
	 */	
	
	public class SceneSyncSubscriptionList extends Setting
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _subscriptions:Object;
		private var _i:int;
		public static const VERSION:int = 1;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncSubscriptionList(name:String,type:int)
		{
			super(name,type);
			
			this._subscriptions = {};
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function setSubscriptionSyncData(sceneId:int,data:ByteArray):void
		{
			if(!this._subscriptions[sceneId])
			{
				_i++;
			}
			this._subscriptions[sceneId] = data;
			this.notifyChange();
		}
		
		/**
		 */
		
		public function getSubscriptionSyncData(sceneId:int):ByteArray
		{
			return this._subscriptions[sceneId];
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			input.readInt();
			
			var n:int = input.readInt();
			
			for(var i:int = 0; i < n; i++)
			{
				var id:int= input.readInt();
				var ba:ByteArray= new ByteArray();
				input.readBytes(ba,0,input.readInt());
				this._subscriptions[id] = ba;
			}
			
			this.notifyChange();
		}
		
		/**
		 */
		
		override public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(VERSION);
			output.writeInt(_i);
			
			for(var i:* in this._subscriptions)
			{
				output.writeInt(i);
				output.writeInt(this._subscriptions[i].length);
				output.writeBytes(this._subscriptions[i]);
			}
		}
	}
}