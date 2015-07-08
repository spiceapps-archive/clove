package com.spice.clove.plugin
{
	internal class SDKInfo
	{
		[Embed(source="clove_sdk_info.xml",mimeType="application/octet-stream")]
		private static const INFO:Class;
		
		private static var _info:XML;
		
		
		private static function init():void
		{
			if(!_info)
			{
				_info = new XML(new INFO());
			}
			
			
		}
			
		
		
		public static function getVersionNumber():Number
		{
			init();
			
			return _info.version;
		}
	}
}