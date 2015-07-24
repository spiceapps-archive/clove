package com.cloveHello.plugin
{
	import com.cloveHello.plugin.installer.CloveHelloPluginInstaller;
	import com.cloveHello.plugin.preferences.CloveHelloPluginPreferenceView;
	import com.spice.clove.plugin.IClovePlugin;
	import com.spice.clove.plugin.IPluginFactory;
	import com.spice.clove.plugin.PluginFactory;
	import com.spice.clove.plugin.install.IServiceInstaller;
	
	public class CloveHelloPluginFactory extends PluginFactory implements IPluginFactory
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _installer:CloveHelloPluginInstaller;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CloveHelloPluginFactory()
		{
			super({name:"Hello Clove",preferenceViewClass:CloveHelloPluginPreferenceView});
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
			if(!_installer)
			{
				_installer = new CloveHelloPluginInstaller();
			}
			
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