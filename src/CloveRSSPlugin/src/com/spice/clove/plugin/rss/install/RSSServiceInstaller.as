package  com.spice.clove.plugin.rss.install
{
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.clove.plugin.install.ServiceInstaller;
	import com.spice.clove.plugin.rss.icons.RSSIcons;
	
	[Bindable] 
	public class RSSServiceInstaller extends ServiceInstaller implements IServiceInstaller
	{
		
	
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var name:String = "RSS";
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function RSSServiceInstaller()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		/*
		 */
		
		public function get installViewClass():Class
		{
			return RSSFeedInstallerView;
		}
		
		/*
		 */
		
		public function get icon():*
		{
			return RSSIcons.RSS_ICON_32;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		public function init():void
		{
			this.completeInstallation();
		}
		
		/*
		 */
		
		public function install(controller:IPluginController):void
		{
//			var rss:RSSPlugin = RSSPlugin(plugin);
			
//			_installer.opmlImporter.plugin = rss;
//			rss.persistentSettings.expandAll = _installer.autoExpand.selected;
			
//			if(_installer.feedXML.text != RSSFeedInstaller.INIT_FEED_TITLE && _installer.feedXML.text.length > 0)
			{
				/* 
				var col:GroupColumn = new GroupColumn();
				col.title = "RSS Feed";
				
				new CloveEvent(CloveEvent.ADD_GROUP,col).dispatch();
	
				rss.addFeed("RSS Feed",_installer.feedXML.text); */
				
			}
			
		}
		
		public function check():void
		{
			this.completeInstallation();
		}
		
		

	}
}