package com.spice.clove.plugin.twitter
{
	import com.spice.clove.plugin.IClovePlugin;
	import com.spice.clove.plugin.IPluginFactory;
	import com.spice.clove.plugin.PluginFactory;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.clove.plugin.twitter.icons.TwitterIcons;
	import com.spice.clove.plugin.twitter.install.TwitterServiceInstaller;
	
	[Bindable] 
	public class CloveTwitterPluginFactory extends PluginFactory implements IPluginFactory
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		
		public var installer:IServiceInstaller = new TwitterServiceInstaller();
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function CloveTwitterPluginFactory()
		{
			super({name:"Twitter",icon:null,hasAccount:true,favicon:TwitterIcons.TWITTER_16_ICON});
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
			return new CloveTwitterPlugin();
		}
		
		
	}
}