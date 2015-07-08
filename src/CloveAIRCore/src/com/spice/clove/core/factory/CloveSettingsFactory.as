package  com.spice.clove.core.factory
{
	import com.spice.air.utils.FileUtil;
	import com.spice.air.utils.storage.AIRSettings;
	import com.spice.clove.core.CloveAIRSettings;
	import com.spice.clove.plugin.load.InstalledPluginInfo;
	import com.spice.clove.plugin.settings.IPluginSettingsFactory;
	import com.spice.vanilla.core.settings.ISettingTable;
	import com.spice.vanilla.desktop.settings.FileSettingTable;
	
	import flash.filesystem.File;
	
	import mx.utils.Base64Encoder;
	
	
	/*
	  creates the plugins settings for Clove  
	  @author craigcondon
	  
	 */	
	public class CloveSettingsFactory implements IPluginSettingsFactory
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function newSettings(plugin:InstalledPluginInfo):ISettingTable
		{
			
			var uid:String = plugin.factoryClass.replace("::",".");//ba.drain().replace("\n\s\t","");
//			
			  
			
			return new FileSettingTable("settings",FileUtil.correctPath(CloveAIRSettings.getInstance().pluginSettingsPath+File.separator+uid+File.separator));
		}

	}
}