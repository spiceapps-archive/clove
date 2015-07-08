package com.spice.clove.twitter.impl.text.command
{
	import com.spice.clove.twitter.impl.account.TwitterPluginAccount;
	import com.spice.clove.twitter.impl.content.control.render.TwitterSearchDataRenderer;
	import com.spice.core.text.command.handle.ITextCommandResultController;
	import com.spice.impl.text.command.handle.TextCommandHandler;
	
	/**
	 * shows a tooltip for @username friends for the post window
	 * @author craigcondon
	 * 
	 */	
	
	public class UsernameTooltipCommandHandler extends TextCommandHandler
	{
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _account:TwitterPluginAccount;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function UsernameTooltipCommandHandler(account:TwitterPluginAccount)
		{
			super(TwitterSearchDataRenderer.USERNAME_SEARCH_REGEXP);
			
			_account = account;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function handleResultController(target:ITextCommandResultController):void
		{
//			var abs:AbstractRegisteredOptionViewController;  CallRegisteredViewType.GET_NEW_REGISTERED_DATA_MENU_OPTION_VIEW_CONTROLLER
		}
		
		
	}
}