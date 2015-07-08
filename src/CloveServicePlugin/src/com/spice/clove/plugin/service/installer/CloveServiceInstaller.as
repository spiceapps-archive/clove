package com.spice.clove.plugin.service.installer
{
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.clove.plugin.install.ServiceInstaller;

	public class CloveServiceInstaller extends ServiceInstaller implements IServiceInstaller
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveServiceInstaller()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get icon():*
		{
			return null;
		}
		
		/**
		 */
		
		public function get installViewClass():Class
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
			
		}
		
		/**
		 */
		
		public function check():void
		{
			
		}
		
		/**
		 */
		
		public function init():void
		{
			
		}
		
	}
}