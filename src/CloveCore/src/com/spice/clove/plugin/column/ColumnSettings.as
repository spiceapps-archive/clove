package com.spice.clove.plugin.column
{
	import com.spice.events.SettingChangeEvent;
	import com.spice.recycle.IDisposable;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.utils.storage.NotifiableSettings;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	
	[Event(name="change",type="com.spice.events.SettingChangeEvent")]
	/*
	  stores data about a column to be saved as a preference. Index and ID are variables
	  so that toObject can loop through this data and return it
	 */
	 
	
	[RemoteClass(alias='com.spice.clove.plugin.ColumnData')]
	public class ColumnSettings extends NotifiableSettings implements INotifiableSettings, 
															  	  IExternalizable
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		private var _data:Object;
		private var _id:String;
       
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ColumnSettings(id:String = null)
		{
			//error caused when blank column is added, NULL reference cannot be written
			this._id    = id == null ? '0' : id;
			
			_data = {};
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		
		public function get id():String
		{
			return this._id;
		}
		
		/**
		 */
		
		public function set id(value:String):void
		{
			this._id = value;
		}

		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		/*
		 */
		
		public function removeAllSettings():void
		{
			this._data = {};
		}
        /*
		 */
		
		/* public function toObject():Object
		{
			var toObj:Object = new Object();
			
			for(var i:String in this)
			{
				toObj[i] = this[i];
			}
			
			return toObj;
		} */
		
		/*
		 */
		
		/* public function copy(value:Object):void
		{
			for (var i:String in value)
			{
				this[i] = value[i];
			}
		} */
		
		public function readExternal(input:IDataInput):void
		{
			this.id = input.readUTF();
			this._data = input.readObject();
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUTF(this.id);
			output.writeObject(this._data);
		}
		
		
		/*
		 */
		
		public function hasSetting(name:String):Boolean
		{
			return _data[name];
		}
		
		/*
		 */
		
		override public function removeSetting(name:String):*
		{
			var data:Object = this.getSetting(name);
			
			_data[name] = undefined;
			
			
			super.removeSetting(name);
			
			return data;
		}
		
		/*
		 */
		
		override public function saveSetting(name:String,value:*):void
		{
			_data[name] = value;
			
			super.saveSetting(name,value);
		}
		
		/*
		 */
		
		public function getSetting(name:String):*
		{
			return _data[name];
		}

	}
}