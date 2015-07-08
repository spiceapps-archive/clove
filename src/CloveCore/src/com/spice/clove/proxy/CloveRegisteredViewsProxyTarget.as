package com.spice.clove.proxy
{
	import com.spice.clove.plugin.control.ClovePluginMediator;
	import com.spice.clove.plugin.core.calls.CallRegisteredViewType;
	import com.spice.clove.plugin.desktop.views.menu.AIRMenuViewController;
	import com.spice.clove.plugin.flash.views.content.control.render.CloveDataViewController;
	import com.spice.clove.plugin.flex.views.FXIconViewController;
	import com.spice.clove.plugin.flex.views.column.row.DefaultColumnRowView;
	import com.spice.clove.plugin.flex.views.column.row.attachment.CloveDataAttachmentRowView;
	import com.spice.clove.plugin.flex.views.content.FlexContentSearchPreferenceViewController;
	import com.spice.clove.plugin.flex.views.content.filter.FXFilterViewController;
	import com.spice.clove.plugin.flex.views.content.option.FXMenuDataOptionViewController;
	import com.spice.clove.plugin.flex.views.installer.FXUserPassInstallerViewController;
	import com.spice.clove.view.column.row.CloveAppColumnRowView;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;
	
	/**  
	 * called by plugins that are looking for views already registered 
	 * @author craigcondon
	 * 
	 */	
	
	public class CloveRegisteredViewsProxyTarget extends ProxyOwner
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _availableCalls:Vector.<String>;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveRegisteredViewsProxyTarget()
		{
			this.getProxyController().setProxyMediator(ClovePluginMediator.getInstance());
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function answerProxyCall(c:IProxyCall):void
		{
			switch(c.getType())
			{
				
				case CallRegisteredViewType.GET_NEW_REGISTERED_DEFAULT_ROW_VIEW_CONTROLLER: 
					return this.respond(c,new CloveDataViewController(CloveAppColumnRowView));
					
				case CallRegisteredViewType.GET_NEW_REGISTERED_CONTENT_CONTROLLER_SEARCH_PREFERENCE_VIEW:
					return this.respond(c,new FlexContentSearchPreferenceViewController(null));
					
				case CallRegisteredViewType.GET_NEW_REGISTERED_MENU_VIEW_CONTROLLER:
					return this.respond(c,new AIRMenuViewController());
					
				case CallRegisteredViewType.GET_NEW_REGISTERED_MENU_BUTTON_VIEW_CONTROLLER:
					return this.respond(c,new FXMenuDataOptionViewController());
					
				case CallRegisteredViewType.GET_NEW_REGISTERED_ICON_VIEW_CONTROLLER: 
					return this.respond(c,new FXIconViewController());
					
				case CallRegisteredViewType.GET_REGISTERED_DEFAULT_FILTER_VIEW_CONTROLLER:
					return this.respond(c,new FXFilterViewController());
					
				case CallRegisteredViewType.GET_NEW_REGISTERED_USER_PASS_INSTALLER_VIEW_CONTROLLER: 
					return this.respond(c,new FXUserPassInstallerViewController(c.getData()));
					
				case CallRegisteredViewType.GET_NEW_REGISTERED_DEFAULT_ROW_ATTACHMENT_VIEW_CONTROLLER:
					return this.respond(c,new CloveDataViewController(CloveDataAttachmentRowView));
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function setupAvailableCalls():void
		{
			super.setupAvailableCalls();
			
			this.addAvailableCalls([CallRegisteredViewType.GET_NEW_REGISTERED_CONTENT_CONTROLLER_SEARCH_PREFERENCE_VIEW,
								    CallRegisteredViewType.GET_NEW_REGISTERED_DEFAULT_ROW_VIEW_CONTROLLER,
									CallRegisteredViewType.GET_NEW_REGISTERED_MENU_VIEW_CONTROLLER,
									CallRegisteredViewType.GET_NEW_REGISTERED_DEFAULT_ROW_ATTACHMENT_VIEW_CONTROLLER,
									CallRegisteredViewType.GET_NEW_REGISTERED_MENU_BUTTON_VIEW_CONTROLLER,
									CallRegisteredViewType.GET_NEW_REGISTERED_ICON_VIEW_CONTROLLER,
									CallRegisteredViewType.GET_NEW_REGISTERED_USER_PASS_INSTALLER_VIEW_CONTROLLER,
									CallRegisteredViewType.GET_REGISTERED_DEFAULT_FILTER_VIEW_CONTROLLER]);
		}
	}
}