package com.spice.clove.plugin.core.root.impl.settings
{
	import com.spice.clove.plugin.column.CloveColumn;
	import com.spice.clove.plugin.column.ColumnMetaData;
	import com.spice.clove.plugin.column.column_internal;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.impl.settings.Setting;
	import com.spice.vanilla.impl.settings.SettingTable;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.StringSetting;
	
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	use namespace column_internal;

	public class ColumnSetting extends Setting
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _target:CloveColumn;
		private var _factory:RootPluginSettingsFactory;
		private var _clazz:Class;
		private var _metadata:SettingTable;
		private var _settingBytes:ByteArray;
		private var _parent:ColumnSetting;
		private var _children:Vector.<ColumnSetting>;
		private var _historyBytes:ByteArray;
		
		public static const VERSION:int = 1;
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ColumnSetting(name:String,type:int,factory:RootPluginSettingsFactory,clazz:Class = null)
		{
			super(name,type);
			_factory = factory;
			_clazz = clazz;
			
			this._metadata = new SettingTable(BasicSettingFactory.getInstance());
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function getChildren():Vector.<ColumnSetting>
		{
			return this._children;
		}
		
		/**
		 */
		
		public function removeFromParent():void
		{
			if(this._parent)
			{
				var i:int = this._parent._children.indexOf(this);
				if(i > -1)
				{
				this._parent._children.splice(i,1);
				}
			}
		}
		
		/**
		 */
		
		public function initialize():CloveColumn
		{
			this._target = this.getNewColumn();
			
			this._target.metadata.copyFrom(this._metadata);
			
			if(this._historyBytes)
			{
				this._target.setHistorySettings(this._historyBytes);
			}
			
			for each(var child:ColumnSetting in this._children)
			{
				this._target.children.addItem(child.initialize());
			}
			this._children = null;
			this._historyBytes = null;
//			this._metadata = null;
			
			this._target.readExternal(null);
			return this._target;
		}
		
		/**
		 */
		
		public function getTitle():String
		{
			return StringSetting(this._metadata.getNewSetting(BasicSettingType.STRING,"title")).getData();
		}
		
		/**
		 */
		
		public function getUID():String
		{
			return StringSetting(this._metadata.getNewSetting(BasicSettingType.STRING,ColumnMetaData.COLUMN_UID)).getData();
		}
		/**
		 */
		
//		public function getData():CloveColumn
//		{
//			return this._target;
//		}
		
		/**
		 */
		
		public function setData(value:CloveColumn):void
		{
			this._target = value;
		}
		
		/**
		 */
		/**
		 */
		
		override public function writeExternal(output:IDataOutput):void
		{  
			
			
			//since we're saving lots of content, we have a version number incase any of it changes
			//in the future
			output.writeInt(VERSION);
			
			
			
			//write THIS type
//			output.writeUnsignedInt(this._target.type);
				
			
			
			var settings:ByteArray = new ByteArray();
			
			//write out the metadata
			this._target.metadata.writeExternal(output);
			
			
			//if the history controller exists, then write TRUE
			output.writeBoolean(this._target.historyManager != null);
			
			//if the history controller exists, then write its settings to the output
			if(this._target.historyManager)
			{
				settings = new ByteArray();
				
				this._target.historyManager.writeExternal(settings);
				
				settings.position = 0;
				//store the hist settings separately since they are read later 
				output.writeInt(settings.length);
				output.writeBytes(settings);
			}
			
			
			output.writeBoolean(_target.allowChildBuilding);
			
			//only save the children if we're allowed to
			if(_target.allowChildBuilding)
			{
				var children:Vector.<CloveColumn> = new Vector.<CloveColumn>();
				
				for each(var child:CloveColumn in _target.children.toArray())
				{
					if(!child)
						continue;
					
					if(child.allowTreeBuilding)
					{
						children.push(child);
					}
				}
				
				
				
				//get ready for writing the children
				output.writeInt(children.length);
				
				for each(var child:CloveColumn in children)
				{
					var cba:ByteArray = new ByteArray();
					
					
					var set:ColumnSetting = ColumnSetting(_factory.getNewSetting(child.type,null));
					set.setData(child);
					set.writeExternal(cba);
					
					
					cba.position = 0;
					
					//we write the type so we know what column to instantiate
					output.writeInt(child.type);
					//write the length so we can skip the byte array if the child type doesn't exist
					output.writeInt(cba.length);
					output.writeBytes(cba,0,cba.length);
					
				}
			}
			
			_target.writeExternal(null);
				
				
		}
		
		/**
		 */
		
		override public function readExternal(input:IDataInput):void
		{
			
			input.readInt();
			
			
			var ba:ByteArray = new ByteArray();
			
			
			var j:int;
			
			this._metadata = new SettingTable(BasicSettingFactory.getInstance());
			this._metadata.readExternal(input);
			
			
			if(input.readBoolean())
			{
				
				this._historyBytes = new ByteArray();
				
				j = input.readInt();
				
				
				if(j) 
				{
					input.readBytes(this._historyBytes,0,j);
				}
				
			}
			
			
			if(input.readBoolean())
			{
				var n:int = input.readInt();
				
				this._children = new Vector.<ColumnSetting>(n);
				
				for(var i:int = 0; i < n; i++)
				{
					ba = new ByteArray();
					
					j = input.readInt();
					var child:ColumnSetting = ColumnSetting(_factory.getNewSetting(j,null));
					
					j = input.readInt();
					if(j) input.readBytes(ba,0,j);
					
					if(!child)
					{
						continue;
					}
					
					ba.position = 0;
					
					//read the settings
					
					child.readExternal(ba);
					child._parent = this;
					this._children[i] = child;
				}
			}
			
			
			
			
			this.notifyChange();
			
		}
		
		/*override public function readExternal(input:IDataInput):void
		{
		input.readInt();
		
		this._target = this.getNewColumn();
		
		var ba:ByteArray = new ByteArray();
		
		
		var j:int;
		
		this._metadata.readExternal(input);
		this._target.metadata.readExternal(input);
		
		
		if(input.readBoolean())
		{
		ba = new ByteArray();
		j = input.readInt();
		
		if(j) 
		{
		input.readBytes(ba,0,j);	
		this._target.setHistorySettings(ba);
		}
		
		}
		
		
		if(input.readBoolean())
		{
		var n:int = input.readInt();
		
		
		for(var i:int = 0; i < n; i++)
		{
		ba = new ByteArray();
		
		j = input.readInt();
		var child:ColumnSetting = ColumnSetting(_factory.getNewSetting(j,null));
		
		j = input.readInt();
		if(j) input.readBytes(ba,0,j);
		
		if(!child)
		{
		continue;
		}
		
		ba.position = 0;
		
		//read the settings
		
		child.readExternal(ba);
		this._target.children.addItem(child.getData());
		}
		}
		
		
		this._target.readExternal(input);
		
		
		this.notifyChange();
		
		}*/		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function getNewColumn():CloveColumn
		{
			return new _clazz();
		}
		
		
	}
}