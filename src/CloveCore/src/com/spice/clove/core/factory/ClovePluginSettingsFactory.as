package com.spice.clove.core.factory
{
	import com.spice.clove.plugin.load.InstalledPluginInfo;
	import com.spice.clove.plugin.settings.IPluginSettingsFactory;
	import com.spice.utils.storage.ChildSettings;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.impl.settings.child.ChildSettingTable;
	
	public class ClovePluginSettingsFactory implements IPluginSettingsFactory
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _rootSettings:INotifiableSettings;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /*
		 */
		 
		public function ClovePluginSettingsFactory()
		{
//			this._rootSettings = rootSettings;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function newSettings(plugin:InstalledPluginInfo):ISettingTable
		{
			
//			var ct:ChildSettingTable = new ChildSettingTable("pluginSettings_"+plugin.factoryClass,
			
//			var cs:ChildSettings =  new ChildSettings(_rootSettings,"pluginSettings_"+plugin.factoryClass);
			
			return null;
//			return cs;
		}
	}
}