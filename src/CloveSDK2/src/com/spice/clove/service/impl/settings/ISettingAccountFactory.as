package com.spice.clove.service.impl.settings
{
	import com.spice.clove.service.impl.account.AbstractServiceAccount;

	public interface ISettingAccountFactory
	{
		function getNewServiceAccount():AbstractServiceAccount;
	}
}