package com.spice.clove.proxy
{
	import com.spice.clove.plugin.core.calls.CallAppCommandType;
	import com.spice.clove.sceneSync.core.calls.CallSceneSyncPluginType;
	import com.spice.utils.textCommand.link.LinkifyHandler2;
	import com.spice.vanilla.core.proxy.IProxyCall;
	import com.spice.vanilla.impl.proxy.ProxyOwner;

	public class CloveAppProxyTarget extends ProxyOwner
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _urlRegexp
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function CloveAppProxyTarget()
		{
			super();
			
			var lh:LinkifyHandler2;
			
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
			
			this.addAvailableCalls([ CallAppCommandType.GET_DEFAULT_TEXT_REPLACEMENTS]);
		}
		
		
		/**
		 */
		
		override public function answerProxyCall(call:IProxyCall):void
		{
			switch(call.getType())
			{
				case CallAppCommandType.GET_DEFAULT_TEXT_REPLACEMENTS:
					
				return;
				
				
			}
		}
		
	}
}