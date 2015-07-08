package com.spice.clove.plugin.core.root.desktop
{
	import com.spice.clove.plugin.core.calls.CallDesktopPluginControllerType;
	import com.spice.clove.plugin.core.column.ICloveColumn;
	import com.spice.clove.plugin.core.post.desktop.views.posting.PostWindow;
	import com.spice.clove.plugin.core.root.desktop.content.control.RootContentControllerFactory;
	import com.spice.clove.plugin.core.root.desktop.history.CloveDataHistoryController;
	import com.spice.clove.plugin.core.root.desktop.history.DesktopHistoryController;
	import com.spice.clove.plugin.core.root.desktop.views.column.RootColumnViewController;
	import com.spice.clove.plugin.core.root.desktop.views.sceneSync.SceneSyncColumnFilterView;
	import com.spice.clove.plugin.core.root.desktop.views.sceneSync.SceneSyncRootInstallerView;
	import com.spice.clove.plugin.core.root.impl.CloveRootPlugin;
	import com.spice.clove.plugin.core.views.render.ICloveDataViewController;
	import com.spice.clove.plugin.flash.views.content.control.render.CloveDataViewController;
	import com.spice.clove.plugin.impl.ClovePluginFactory;
	import com.spice.clove.view.column.ColumnViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxyMediator;
	import com.spice.vanilla.flash.utils.ProxyCallUtils;
	import com.spice.vanilla.impl.proxy.ProxyCall;
	
	import flash.filesystem.File;
	
	import mx.controls.Alert;

	public class CloveDesktopRootPlugin extends CloveRootPlugin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _settingsDir:File;
		private var _serviceHistFile:File;
		private var _postWindow:PostWindow;
		private var _deletedDataController:CloveDataHistoryController;
		private var _filterViewController:CloveDataViewController;
		private var _sceneSyncInstallerViewController:CloveDataViewController;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveDesktopRootPlugin(factory:ClovePluginFactory)
		{
			
			super(factory,new RootContentControllerFactory(this),new DesktopHistoryController(this));
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**  
		 */
		
		public function get databaseFile():File
		{
			return _serviceHistFile;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getDeletedDataController():CloveDataHistoryController
		{
			return this._deletedDataController;
		}
		
		/**
		 */
		
		override public function handleProxyResponse(n:INotification):void
		{
			switch(n.getType())
			{
				case CallDesktopPluginControllerType.GET_SETTINGS_DIRECTORY:
					_serviceHistFile = new File(n.getData().nativePath+
						File.separator+"service_history.db");
					
				return;
			}
			
			super.handleProxyResponse(n);
		}
		
		
		/**
		 */
		
		override public function refreshAllFeeds():void
		{
			if(this.isSelfLoading())
			{
				this.getRootColumn().loadNewerContent();
			}else
			if(this._model.rootContentController)
			{
				
				var vc:ColumnViewController = RootColumnViewController(this._model.rootContentController.viewController).currentTargetController;
				
				
				//it MAY be null ifthere are no groups
				if(vc)
				vc.target.loadNewerContent();
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		override protected function getFilterViewController():ICloveDataViewController
		{
			if(!this._filterViewController)
			{
				this._filterViewController = new CloveDataViewController(SceneSyncColumnFilterView);
			}
			
			return this._filterViewController;
		}
		
		/**
		 */
		
		override protected function getSceneSyncInstallerViewController():ICloveDataViewController
		{
			if(!this._sceneSyncInstallerViewController)
			{
				this._sceneSyncInstallerViewController = new CloveDataViewController(SceneSyncRootInstallerView);
			}
			
			return this._sceneSyncInstallerViewController;
		}
		/**
		 */
		
		
		override protected function initialize():void
		{
			super.initialize();
			
			ProxyCallUtils.quickCall(CallDesktopPluginControllerType.GET_SETTINGS_DIRECTORY,this.getPluginController().getProxy(),null,this)
			
			
			_deletedDataController = new CloveDataHistoryController(this);
			
			this.finishInitialization();
		}
		
		
		/**
		 */
		
		override protected function applicationInitialized():void
		{
			super.applicationInitialized();
			
			
			var mediator:IProxyMediator = this.getPluginMediator();
			
		}
		
	}
}