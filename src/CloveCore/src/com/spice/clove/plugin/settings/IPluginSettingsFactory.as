package com.spice.clove.plugin.settings
{
	import com.spice.clove.plugin.load.InstalledPluginInfo;
	import com.spice.vanilla.core.settings.ISettingTable;
	
	public interface IPluginSettingsFactory
	{
		function newSettings(plugin:InstalledPluginInfo):ISettingTable;
	}
}