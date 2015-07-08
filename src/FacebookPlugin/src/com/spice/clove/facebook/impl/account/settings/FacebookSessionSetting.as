package com.spice.clove.facebook.impl.account.settings
{
	import com.facebook.air.SessionData;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class FacebookSessionSetting extends Setting
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _data:SessionData;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookSessionSetting(type:int,name:String)
		{
			super(name,type);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getData():SessionData
		{
			return _data;
		}
		
		/**
		 */
		
		public function setData(value:SessionData):void
		{
			this._data = value;
			this.notifyChange();
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
			var sess:SessionData = new SessionData();
			
			this._data = sess;
			if(!input.readBoolean())
				return;
			
			sess.expires 	 = input.readUTF();
			sess.secret		 = input.readUTF();
			sess.session_key = input.readUTF();
			sess.uid 		 = input.readUTF();
			
			this.notifyChange();
		}
		
		/**
		 */
		
		override public function writeExternal(output:IDataOutput):void
		{
			output.writeBoolean(_data != null);
			
			if(!_data)
				return;
			
			output.writeUTF(_data.expires);
			output.writeUTF(_data.secret);
			output.writeUTF(_data.session_key);
			output.writeUTF(_data.uid);
		}
	}
}