package com.spice.clove.plugin.impl.content.data
{
	import com.spice.clove.plugin.impl.content.data.meta.CloveMetadataList;
	import com.spice.vanilla.core.settings.ISetting;
	import com.spice.vanilla.flash.singleton.Singleton;
	import com.spice.vanilla.impl.settings.basic.BasicSettingFactory;

	public class CloveDataSettingFactory extends BasicSettingFactory
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveDataSettingFactory()
		{
			super();
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function getNewSetting(type:int, name:String):ISetting
		{
			switch(type)
			{
				case CloveDataSettingType.HASH: return new CloveHashTableSetting(name,type);
				case CloveDataSettingType.METADATA_LIST: return new CloveMetadataList(name,type);
			}
			
			return super.getNewSetting(type,name);
		}
		
		/**
		 */
		
		public static function getInstance():CloveDataSettingFactory
		{
			return Singleton.getInstance(CloveDataSettingFactory);
		}
	}
}