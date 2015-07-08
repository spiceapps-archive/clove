package com.spice.clove.plugin.core.sceneSync.flex
{
	import com.spice.clove.installer.core.calls.CallCloveInstallerType;
	import com.spice.clove.plugin.core.calls.CallDesktopPluginControllerType;
	import com.spice.clove.plugin.core.sceneSync.flex.views.FXAddSceneSyncButton;
	import com.spice.clove.plugin.core.sceneSync.flex.views.FXBannerEditorView;
	import com.spice.clove.plugin.core.sceneSync.flex.views.FXSceneSwitcherView;
	import com.spice.clove.plugin.core.sceneSync.flex.views.prefs.CreateNewSceneView;
	import com.spice.clove.plugin.core.sceneSync.flex.views.prefs.SceneSyncPreferenceView;
	import com.spice.clove.plugin.core.sceneSync.impl.SceneSyncPlugin;
	import com.spice.clove.proxy.calls.CallCloveInternalType;
	import com.spice.clove.root.core.calls.CallRootPluginType;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncPluginType;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	
	import flash.filesystem.File;
	
	import mx.containers.Canvas;

	public class FXSceneSyncPlugin extends SceneSyncPlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		
		private var _preferenceView:SceneSyncPreferenceView;
		private var _historyDirectory:File;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FXSceneSyncPlugin(factory:FXSceneSyncPluginFactory)
		{
			super(factory);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallCloveInstallerType.GET_INSTALLATION_VIEW:
					if(_hasInitialSubscriptions  )
					{
						this.respond(call,this.getPreferenceView());
					}
				return;
				case CallCloveInternalType.CLOVE_INTERNAL_SET_SCENE_SYNC_PREFERENCE_VIEW: return this.respond(call,this.getPreferenceView());
				case CallSceneSyncPluginType.OPEN_CREATE_NEW_SCENE_VIEW: return this.openCreateNewSceneView();
				
					
			}
			
			
			return super.answerProxyCall(call);
		}
		/**
		 */
		
		public function getPreferenceView():SceneSyncPreferenceView
		{
			if(!_preferenceView)
			{
				this._preferenceView = new SceneSyncPreferenceView();
				this._preferenceView.plugin = this;
			}
			
			return this._preferenceView;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		private function openCreateNewSceneView():void
		{
			CreateNewSceneView.open(this);
		}
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
			
			
//			ProxyCallUtils.quickCall(CallRootPluginType.ROOT_PLUGIN_ADD_FOOTER_BUTTON,this.getPluginMediator(),new FXAddSceneSyncButton());
			ProxyCallUtils.quickCall(CallRootPluginType.ROOT_PLUGIN_ADD_HEADER_VIEW,this.getPluginMediator(),new FXBannerEditorView());
		}
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallCloveInternalType.CLOVE_INTERNAL_SET_SCENE_SYNC_PREFERENCE_VIEW,
									CallSceneSyncPluginType.OPEN_CREATE_NEW_SCENE_VIEW,
									CallCloveInstallerType.GET_INSTALLATION_VIEW]);
		}
	}
}