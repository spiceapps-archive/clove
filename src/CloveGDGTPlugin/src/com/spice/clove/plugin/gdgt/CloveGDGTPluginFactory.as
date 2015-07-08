package com.spice.clove.plugin.gdgt
{
	import com.spice.clove.plugin.IClovePlugin;
	import com.spice.clove.plugin.IPluginFactory;
	import com.spice.clove.plugin.PluginFactory;
	import com.spice.clove.plugin.gdgt.installer.CloveGDGTServiceInstaller;
	import com.spice.clove.plugin.install.IServiceInstaller;
	
	[Bindable] 
	public class CloveGDGTPluginFactory extends PluginFactory implements IPluginFactory
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

        public var installer:IServiceInstaller = new CloveGDGTServiceInstaller();
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function CloveGDGTPluginFactory()
		{
			super({name:"GDGT"});
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
			return new CloveGDGTPlugin();
		}
	}
}