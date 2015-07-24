package com.spice.cloveHello
{
	import com.spice.clove.plugin.IClovePlugin;
	import com.spice.clove.plugin.IPluginFactory;
	import com.spice.clove.plugin.PluginFactory;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.cloveHello.installer.ClovePluginInstaller;
	import com.spice.cloveHello.preferences.CloveHelloPreferenceView;
	
	public class CloveHelloPluginFactory extends PluginFactory implements IPluginFactory
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _installer:IServiceInstaller = new ClovePluginInstaller();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CloveHelloPluginFactory()
		{
			super({preferenceViewClass:CloveHelloPreferenceView,name:"Hello Clove"});
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get installer():IServiceInstaller
		{
			return _installer;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function newPlugin():IClovePlugin
		{
			return new CloveHelloPlugin();
		}

	}
}