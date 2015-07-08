package com.spice.clove.plugin.bestBuy.install
{
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.clove.plugin.install.ServiceInstaller;
	
	import mx.containers.Canvas;
	
	public class BestBuyServiceInstaller extends ServiceInstaller implements IServiceInstaller
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function BestBuyServiceInstaller()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get installViewClass():Class
		{
			return Canvas;
		}
		
		/**
		 */
		
		public function get icon():*
		{
			return null;
		}
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function install(controller:IPluginController):void
		{
			//nothing
		}
		
		/**
		 */
		
		public function check():void
		{
			this.completeInstallation();
		}
		
		
		/**
		 */
		
		public function init():void
		{
			this.completeInstallation();
		}

	}
}