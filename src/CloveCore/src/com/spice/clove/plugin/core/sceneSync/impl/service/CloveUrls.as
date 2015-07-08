package com.spice.clove.plugin.core.sceneSync.impl.service
{
	import com.spice.clove.sceneSync.core.service.data.SyncData;

	public class CloveUrls
	{
//		public static const BASE_URL:String = "http://cloveapp.com/service/cloveApp/";
//		public static const BASE_URL:String = "http://169.254.43.73/work/spice/cloveApp/";
		
//		public static const HOST:String = 'http://localhost/work/Spice/';
		  
	    
		public static const HOST:String = "http://api.cloveapp.com/";
		public static const ANALYTICS_URL:String = "http://api.cloveapp.com/public/exec/analytics.php";
		public static const BASE_URL:String = HOST+'sceneSync/';
		
		
		//screen
		public static const SCREEN_NEW_URL:String = BASE_URL+"screen/new.xml";
		
		//sync
		public static const SYNC_AVAILABLE_URL:String = BASE_URL+"sync/available.xml";
		public static const SYNC_NEW_URL:String = BASE_URL+"sync/add.xml";
		public static const SYNC_SHARE_URL:String = BASE_URL+"sync/share.xml";  
		
		//scene
		public static const SCENE_NEW_URL:String = BASE_URL+"scene/new.xml";
		public static const SCENE_DELETE_URL:String = BASE_URL+"scene/remove.xml";
		public static const SCENE_GET_ALL_URL:String = BASE_URL+"scene.xml";
		public static const SCENE_SYNC_UPDATE_URL:String = BASE_URL+"scene/update.xml";
		
		//log
		public static const  THYME_ADD_LOGS_URL:String = HOST+"thyme/add/logs.xml";
		    
		//favorites
		public static const FAVORITES_ADD_URL:String = HOST+"favorites/add.xml";
		public static const FAVORITES_SHOW_URL:String = HOST+"favorites/auth/show.xml";
		public static const FAVORITES_REMOVE_URL:String = HOST+"favorites/remove.xml";
		public static const FAVORITES_ADD_GROUP_URL:String = HOST+"favorites/add/group.xml";
		public static const FAVORITES_UPDATE_GROUP_URL:String = HOST+"favorites/update/group.xml";
		public static const FAVORITES_REMOVE_GROUP_URL:String = HOST+"favorites/remove/group.xml";
		public static const FAVORITES_SHOW_AVAILABLE_GROUPS_URL:String = HOST+"favorites/auth/show/groups.xml";
		
		//bugs
		public static const BUGS_NEW_URL:String = BASE_URL+"bugs/new.xml";
		
		
		//
		public static function GET_SHARE_URL(sync:SyncData,route:Vector.<int>,format:String = 'html'):String
		{
			return HOST+'clove/share/'+sync.getName()+'_'+route.join('_')+'.'+format;
		}

	}
}