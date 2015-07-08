package com.spice.clove.twitter.impl.account.settings
{
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import org.iotashan.oauth.OAuthToken;

	public class OAuthTokenSetting extends Setting
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _token:OAuthToken;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function OAuthTokenSetting(name:String,type:int)
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
		
		override public function handleProxyResponse(n:INotification):void
		{
			this.setData(n.getData());
		}
		/**
		 */
		
		public function getData():OAuthToken
		{
			return _token;
		}
		/**
		 */
		
		public function setData(value:OAuthToken):void
		{
			this._token = value;
			
			this.notifyChange();
		}
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			if(input.readBoolean())
				this._token = new OAuthToken(input.readUTFBytes(input.readInt()),input.readUTFBytes(input.readInt()));
			
			this.notifyChange();
		}
		
		/**
		 */
		
		override public function writeExternal(output:IDataOutput):void
		{
			output.writeBoolean(this._token != null);
			
			if(!_token)
				return;
			
			output.writeInt(this._token.key.length);
			output.writeUTFBytes(this._token.key);
			
			output.writeInt(this._token.secret.length);
			output.writeUTFBytes(this._token.secret);
		}
	}
}