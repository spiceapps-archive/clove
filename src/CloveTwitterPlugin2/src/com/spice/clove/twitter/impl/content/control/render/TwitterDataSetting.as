package com.spice.clove.twitter.impl.content.control.render
{
	import com.spice.clove.plugin.core.content.data.ICloveData;
	import com.spice.vanilla.impl.settings.basic.BasicSettingType;
	import com.spice.vanilla.impl.settings.basic.NumberSetting;
	import com.spice.vanilla.impl.settings.basic.StringSetting;

	/**
	 * additional metadata attached to the ICloveData 
	 * @author craigcondon
	 * 
	 */	
	
	public class TwitterDataSetting
	{
		public static const USERNAME:String = "username";
		public static const USER_ID:String = "userId";
		public static const ATTACHMENTS:String = "attachments";
		public static const IN_REPLY_TO_STATUS_ID:String = "inReplyToStatusId";
		public static const PAGE:String = "page";
		
		
		
		public static function getUsername(data:ICloveData):String
		{
			return StringSetting(data.getSettingTable().getNewSetting(BasicSettingType.STRING,USERNAME)).getData();
		}
		
		public static function getUserId(data:ICloveData):Number
		{
			return NumberSetting(data.getSettingTable().getNewSetting(BasicSettingType.STRING,USER_ID)).getData();
		}
		
		public static function getInReplyToStatusId(data:ICloveData):Number
		{
			return NumberSetting(data.getSettingTable().getNewSetting(BasicSettingType.STRING,IN_REPLY_TO_STATUS_ID)).getData();
		}
	}
}
