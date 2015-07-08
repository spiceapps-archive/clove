package com.spice.clove.sceneSync.core.service.data
{
	import com.spice.clove.sceneSync.core.service.settings.CloveServiceSettingType;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	[Bindable] 
	public class ScreenData extends Setting implements IExternalizable
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var id:Number;
        public var type:String;
        public var createdAt:Date;
        
        
        
        
		public function ScreenData(name:String = "",tp:int = 0,id:Number = -1,type:String = "",created:Number = 0)
		{
			super(name,tp);
			
			this.id        = id;
			this.type      = type;
			this.createdAt = new Date(created*1000);
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
       
        /*
		 */
		
		public static function fromXML(data:*):ScreenData
		{
			return new ScreenData("",CloveServiceSettingType.SCREEN_DATA,data.id,data.type,data.created_at);
		}
		
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			this.id = input.readDouble();
			this.type = input.readUTF();
			this.createdAt.time = input.readDouble();
			this.notifyChange();
		}
		
		/**
		 */
		
		override public function writeExternal(output:IDataOutput):void
		{  
			output.writeDouble(this.id);
			output.writeUTF(this.type);
			output.writeDouble(createdAt.time);
		}
		
		

	}
}