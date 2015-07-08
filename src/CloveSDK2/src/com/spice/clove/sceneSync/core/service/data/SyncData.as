package com.spice.clove.sceneSync.core.service.data
{
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	
	import flash.display.Scene;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	public class SyncData extends Setting implements IExternalizable
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var id:Number;
        public var createdAt:Date;
        public var screen:ScreenData;
        public var scene:SceneData;
		public var url:String;
		public var compressed:Boolean;
          
        
        //--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
        
        
		public function SyncData(name:String = "",type:int = 0,id:Number = 0,created:Number = 0,compressed:Boolean = false,url:String = null,screen:ScreenData = null,scene:SceneData = null)
		{
			super(name,type);
			
			this.id        = id;
			this.createdAt = new Date(created*1000);
			this.url = url;
			this.screen    = screen;
			this.scene     = scene;
			this.compressed = compressed;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------  

		
		/*
		 */
		
		public function getLastSyncTime():int
		{  
			return this.createdAt.time / 1000;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function writeExternal(output:IDataOutput):void
		{
			output.writeDouble(id);
			output.writeDouble(createdAt.time);
			screen.writeExternal(output);
			scene.writeExternal(output);
			
		}
		
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			this.id = input.readDouble();
			this.createdAt = new Date(input.readDouble());
			this.screen = new ScreenData();
			this.screen.readExternal(input);
			this.scene = new SceneData();
			this.scene.readExternal(input);
			this.notifyChange();
		}

	}
}