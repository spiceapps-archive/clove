package com.spice.clove.twitter.impl.content.control
{
	import com.spice.clove.service.core.account.content.control.IAccountContentController;
	import com.spice.clove.twitter.impl.TwitterPlugin;
	import com.spice.clove.twitter.impl.account.TwitterPluginAccount;

	public interface ITwitterContentController extends IAccountContentController
	{
		function getTwitterPlugin():TwitterPlugin;
	}
}