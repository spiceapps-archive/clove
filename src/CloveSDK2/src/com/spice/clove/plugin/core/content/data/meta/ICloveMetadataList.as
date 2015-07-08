package com.spice.clove.plugin.core.content.data.meta
{
	import com.spice.vanilla.core.settings.ISetting;

	public interface ICloveMetadataList extends ISetting
	{
		function getMetadata(name:String):Vector.<ICloveMetadata>;
		function addMetadata(value:ICloveMetadata):ICloveMetadata;
		function getAllMetadata():Vector.<ICloveMetadata>;
		function hasMetadata(name:String):Boolean;
	}
}