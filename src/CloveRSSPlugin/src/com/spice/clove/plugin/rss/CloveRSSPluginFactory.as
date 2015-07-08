package com.spice.clove.plugin.rss
{
	import com.spice.clove.plugin.IClovePlugin;
	import com.spice.clove.plugin.IPluginFactory;
	import com.spice.clove.plugin.PluginFactory;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.clove.plugin.rss.icons.RSSIcons;
	import com.spice.clove.plugin.rss.install.RSSServiceInstaller;
	import com.spice.clove.plugin.rss.pref.CloveRSSPreferences;
	
	
	[Bindable] 
	public class CloveRSSPluginFactory extends PluginFactory implements IPluginFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		
		public var installer:IServiceInstaller = new RSSServiceInstaller();
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function CloveRSSPluginFactory()
		{
			super({name:"RSS",preferenceViewClass:CloveRSSPreferences,favicon: RSSIcons.RSS_ICON_16});
		}
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		
		public function newPlugin():IClovePlugin
		{
			return new CloveRSSPlugin();
		}
	}
}