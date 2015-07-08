package com.spice.clove.sceneSync.core.service.data
{
	import com.spice.clove.sceneSync.core.service.settings.CloveServiceSettingType;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	[Bindable]	
	public class SceneSubscriptionData extends Setting implements IExternalizable
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var id:Number;
        public var scene:Number;
        public var subscribedTo:Number;
        public var createdAt:Date;
		public var displayName:String;
		
		public static const VERSION:int = 0;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function SceneSubscriptionData(name:String = "",type:int = 0,displayName:String = "",id:Number = 0, scene:Number = 0, subscribedTo:Number = 0, createdAt:Number = 0)
		{
			super(name,type);
			
			this.id = id;
			this.displayName = displayName;
			this.scene = scene;
			this.subscribedTo = subscribedTo;
			this.createdAt = new Date(createdAt*1000);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public static function fromXML(data:*):SceneSubscriptionData
		{
			return new SceneSubscriptionData("",CloveServiceSettingType.SUBSCRIPTION_DATA,data.id,data.scene,data.subscribed_to,data.created_at);
		}
		
		/**
		 */
		
		override public function writeExternal(output:IDataOutput):void
		{
			output.writeDouble(VERSION);
			output.writeDouble(this.id);
			output.writeUTF(this.displayName);
			output.writeDouble(this.scene);
			output.writeDouble(this.subscribedTo);
			output.writeDouble(createdAt.time);
		}
		
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			this.id = input.readDouble();
			
			if(id == VERSION)
			{
				this.id = input.readDouble();
				this.displayName = input.readUTF();
			}
			
			
			this.scene = input.readDouble();
			this.subscribedTo = input.readDouble();
			this.createdAt.time = input.readDouble();
			this.notifyChange();
		}

	}
}