package com.spice.clove.model
{
	import com.spice.clove.plugin.install.AvailableInternalService;
	
	import mx.collections.ArrayCollection;
	
	
	/*
	  Used for debugging Plugin installers 
	  @author craigcondon
	  
	 */		
	 
	public class InstallModel
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var installers:ArrayCollection = new ArrayCollection();
        
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function addInstaller(installer:AvailableInternalService):void
		{
			this.installers.addItem(installer);
		}
	}
}