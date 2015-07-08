package com.spice.clove.util.importService
{
	import flash.filesystem.File;
	
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
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		protected function getPrefFolder(name:String):File
		{
			var prefDir:File = File.desktopDirectory.resolvePath(File.applicationStorageDirectory.nativePath).parent.parent;
			
			for each(var file:File in prefDir.getDirectoryListing())
			{
				if(file.name.toLocaleLowerCase().indexOf(name.toLocaleLowerCase()) > -1)
				{
					return file;
				}
			}
			
			return null;
		}

	}
}