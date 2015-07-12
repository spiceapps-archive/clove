package com.spice.clove.plugin.twitter.install.importService
{
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.utils.classSwitch.ClassSwitcher;
	import com.spice.utils.classSwitch.io.SFile;
	
	
	/*
	  
	  @author craigcondon
	  
	 */	
	public class ServiceImporter
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function ServiceImporter()
		{
		}
		
		/*
		 */
		
		public function importService(controller:IPluginController):void
		{
			//abstract
		}
		
		
		/*
		 */
		
		public function hasService():Boolean
		{
			return false;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		protected function getPrefFolder(name:String):*
		{
			
			var fileClass:* = ClassSwitcher.getTargetClass(SFile);
			
			if(!fileClass)
				return null;
				
			var prefDir:* = fileClass.desktopDirectory.resolvePath(fileClass.applicationStorageDirectory.nativePath).parent.parent;
			
			for each(var file:* in prefDir.getDirectoryListing())
			{
				if(file.name.toLocaleLowerCase().indexOf(name.toLocaleLowerCase()) > -1)
				{
					return new SFile(file.nativePath).target;
				}
			}
			
			return null;
		}
		
	

	}
}