package com.spice.clove.post.core.notifications
{
	import com.spice.clove.service.core.calls.CallToServiceAccountType;
	import com.spice.vanilla.core.notifications.Notification;

	public class ServiceAccountNotification extends Notification
	{
		public static const SERVICE_ACCOUNT_UNINSTALL:String = CallToServiceAccountType.SERVICE_ACCOUNT_UNINSTALL;
		
		public function ServiceAccountNotification(type:String,data:Object = null)
		{
			super(type,data);
		}
	}
}