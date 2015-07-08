package com.spice.clove.plugin.core.sceneSync.impl.installer
{
	import com.spice.clove.plugin.core.sceneSync.impl.SceneSyncPlugin;
	import com.spice.clove.plugin.core.sceneSync.impl.account.SceneSyncAccount;
	import com.spice.clove.plugin.impl.install.AbstractUserPassPluginInstaller;
	import com.spice.vanilla.core.plugin.IPlugin;
	import com.spice.vanilla.core.proxy.IProxyMediator;

	public class SceneSyncPluginInstaller extends AbstractUserPassPluginInstaller
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _plugin:SceneSyncPlugin;
		private var _username:String;
		private var _password:String;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSyncPluginInstaller(plugin:SceneSyncPlugin,mediator:IProxyMediator)
		{
			super(plugin,mediator);
			
			_plugin = plugin;
		}
		
		
		
		/**
		 */
		override public function getTitle():String
		{
			return "Clove App requires you to login.";
		}
		
		/**
		 */
		
		override public function setUsername(value:String):void
		{  
			_username = value;
		}
		
		
		/**
		 */
		override public function setPassword(value:String):void
		{
			_password = value;
		}
		
		
		/**
		 */
		
		override protected function isFinished():Boolean
		{
			var isFinished:Boolean = _username && _password;
			
			if(isFinished)
			{
				SceneSyncAccount(this._plugin.addAcount()).getService().setCredentials(_username,_password);
			}
			
			return true;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function pluginInstalled(plugin:IPlugin):void
		{
		}
		
	}
}