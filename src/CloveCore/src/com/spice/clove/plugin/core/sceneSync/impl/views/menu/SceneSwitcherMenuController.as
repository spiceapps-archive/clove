package com.spice.clove.plugin.core.sceneSync.impl.views.menu
{
	import com.spice.clove.sceneSync.core.service.data.SceneData;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.core.calls.data.ShowMenuOptionViewData;
	import com.spice.clove.plugin.core.sceneSync.impl.models.SceneSyncPluginModelLocator;
	import com.spice.clove.plugin.impl.content.control.option.menu.CloveDataMenuOption;
	import com.spice.clove.plugin.impl.views.menu.AbstractMenuItemViewController;
	import com.spice.clove.plugin.impl.views.menu.AbstractRegisteredMenuItemViewController;
	import com.spice.vanilla.core.observer.INotification;
	import com.spice.vanilla.core.proxy.IProxy;
	import com.spice.vanilla.impl.proxy.IProxyBinding;
	import com.spice.vanilla.impl.proxy.ProxyBindingObserver;
	
	import org.papervision3d.scenes.Scene3D;

	public class SceneSwitcherMenuController extends AbstractRegisteredMenuItemViewController implements IProxyBinding
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _model:SceneSyncPluginModelLocator = SceneSyncPluginModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function SceneSwitcherMenuController(mediator:IProxy)
		{
			super(mediator);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function notifyProxyBinding(n:INotification):void
		{
			for each(var scene:SceneData in this._model.scenes.source)
			{
				if(n.getType() == scene.name)
				{
					return this.setScene(scene);
				}
			}
			super.notifyProxyBinding(n);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setDataOptionsToUse(data:Object):void
		{
			
			var items:Array = [];
			
			for(var i:String in this._availableMenuItems)
			{
				items.push(i);
			}
			
			//the scenes need to be in order, so sort them
			items.sort();
			
			this.useMenuItems(items);
			
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		private function setScene(scene:SceneData):void
		{
			_model.plugin.getSceneSyncAccount().setCurrentScene(scene);
		}
		
	}
}