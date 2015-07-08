package com.spice.clove.sceneSync.core.service.data
{
	import com.spice.clove.sceneSync.core.service.settings.CloveServiceSettingType;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.collections.ArrayCollection;
	
	public class SceneData extends Setting implements IExternalizable
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

        public var id:Number;
        public var name:String;
        public var createdAt:Date;
        public var description:String;
        public var subscriptions:ArrayCollection = new ArrayCollection();
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function SceneData(type:int = 0,id:Number = 0,name:String = "",description:String = "",createdAt:Number = 0)
		{
			super(name,type);
			this.id = id;
			this.name = name;
			this.description = description;
			this.createdAt = new Date(createdAt*1000);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		/**
		 */
		
		public function setName(value:String):void
		{
			this.name = value;
			this.notifyChange();
		}
		/**
		 */
		public function addSubscription(value:SceneSubscriptionData):Boolean
		{
			for each(var sub:SceneSubscriptionData in this.subscriptions.source)
			{
				if(sub.scene == value.scene)
					return false;
			}
			
			this.subscriptions.addItem(value);
			
			this.notifyChange();
			
			return true;
		}
		
		/**
		 */
		
		public function removeSubscription(scene:int):void
		{
			var i:int = 0;
			
			
			
			for each(var sub:SceneSubscriptionData in this.subscriptions.source)
			{
				
				if(sub.scene == scene)
				{
					this.subscriptions.removeItemAt(i);
				}
				
				i++;
			}
			
		
			this.notifyChange();
		}
        /*
		 */
		
		public static function fromXML(data:*):SceneData
		{
			var sd:SceneData = new SceneData(CloveServiceSettingType.SCENE_DATA,data.id,data.name,data.description,data.created_at);
			
			
			for each(var sub:XML in data.subscription)
			{
				sd.subscriptions.addItem( SceneSubscriptionData.fromXML(sub));
			}
			return sd;
		}
		
		/**
		 */
		
		override public function writeExternal(output:IDataOutput):void
		{
			output.writeDouble(id);
			output.writeUnsignedInt(name.length);
			output.writeUTFBytes(name);
			output.writeDouble(createdAt.time);
			output.writeUnsignedInt(description.length);
			output.writeUTFBytes(description);
			
			output.writeUnsignedInt(this.subscriptions.length);
			
			for each(var sub:SceneSubscriptionData in this.subscriptions.source)
			{
				sub.writeExternal(output);
			}  
		}
		
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			
			this.id = input.readDouble();
			this.name = input.readUTFBytes(input.readUnsignedInt());
			this.createdAt.time = input.readDouble();
			this.description = input.readUTFBytes(input.readUnsignedInt());
			
			var n:int = input.readUnsignedInt();
			
			for(var i:int = 0; i < n; i++)
			{
				var sub:SceneSubscriptionData = new SceneSubscriptionData();
				sub.readExternal(input);
				
				this.subscriptions.addItem(sub);
			}
			
			this.notifyChange();
		}

	}
}