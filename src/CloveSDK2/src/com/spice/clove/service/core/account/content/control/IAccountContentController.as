package com.spice.clove.service.core.account.content.control
{
	import com.spice.clove.service.impl.account.AbstractServiceAccount;
	import com.spice.vanilla.core.plugin.IPlugin;

	public interface IAccountContentController
	{
		function getAccount():AbstractServiceAccount;
		function setAccount(value:AbstractServiceAccount):void;
	}
}