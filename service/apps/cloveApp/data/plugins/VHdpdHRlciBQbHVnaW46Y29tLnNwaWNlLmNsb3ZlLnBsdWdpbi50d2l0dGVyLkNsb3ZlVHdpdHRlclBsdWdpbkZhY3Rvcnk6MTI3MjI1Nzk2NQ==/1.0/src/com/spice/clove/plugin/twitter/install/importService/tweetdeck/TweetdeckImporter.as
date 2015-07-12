package com.spice.clove.plugin.twitter.install.importService.tweetdeck
{
	import com.spice.clove.commandEvents.CreateColumnEvent;
	import com.spice.clove.plugin.column.ColumnMetaData;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.twitter.CloveTwitterPlugin;
	import com.spice.clove.plugin.twitter.column.control.TwitterDMColumnController;
	import com.spice.clove.plugin.twitter.column.control.TwitterKeywordSearchColumnController;
	import com.spice.clove.plugin.twitter.column.control.TwitterMentionsColumnController;
	import com.spice.clove.plugin.twitter.column.control.TwitterUserSearchColumnController;
	import com.spice.clove.plugin.twitter.column.control.TwitterUserTimelineColumnController;
	import com.spice.clove.plugin.twitter.icons.TwitterIcons;
	import com.spice.clove.plugin.twitter.install.importService.ServiceImporter;
	import com.spice.clove.plugin.twitter.install.importService.tweetdeck.dao.TweetdeckDAO;
	import com.spice.utils.EmbedUtil;
	import com.spice.utils.classSwitch.ClassSwitcher;
	import com.spice.utils.classSwitch.util.SFileUtil;
	
	import flash.filesystem.File;
	
	
	/*
	  imports tweetdeck columns 
	  @author craigcondon
	  
	 */	
	public class TweetdeckImporter extends ServiceImporter
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _dao:TweetdeckDAO;
		private var _sql:File;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
		public function TweetdeckImporter()
		{
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		
		override public function importService(controller:IPluginController):void
		{
			
			
			var cols:Array = this.columns;
			
			
			var cols2:Array = [];
			var gMetadata:Object = {};
			
			gMetadata[ColumnMetaData.COLUMN_ICON] = EmbedUtil.toImageByteArray( TwitterIcons.TWITTER_32_ICON);
			gMetadata[ColumnMetaData.TITLE] = CloveTwitterPlugin(controller.plugin).settings.username;
			
			var metadata:Array = gMetadata.children = [];
			
			if(cols)
			{
				for each(var c:* in cols)
				{
					switch(c.type)
					{
						case TweetdeckColumnType.TWITTER_DM:
							cols2.push([new TwitterDMColumnController(controller)]);
							metadata.push({title:'Direct Messages'});
						break;
						case TweetdeckColumnType.TWITTER_REPLIES:
							cols2.push([new TwitterMentionsColumnController(controller)]);
							metadata.push({title:'Mentions'});
						break;
						case TweetdeckColumnType.TWITTER_SEARCH:
							cols2.push([new TwitterKeywordSearchColumnController(controller,c.data)]);
							metadata.push({title:'Search: '+c.data});
						break;
						case TweetdeckColumnType.TWITTER_STATUS:
							cols2.push([new TwitterUserTimelineColumnController(controller)]);
							metadata.push({title:'Status'});
						break;
						case TweetdeckColumnType.TWITTER_GROUP:
							
							var group:Array = [];
							
							for each(var subCol:* in c.subColumns)
							{
								group.push(new TwitterUserSearchColumnController(controller,subCol.data));
							}
							
							cols2.push(group);
							metadata.push({title:c.name});
							
						break;
					}
				}
				
				new CreateColumnEvent(cols2,null,gMetadata).dispatch();
				
				
			}
			
		}
		
		
		
		/*
		 */
		
		override public function hasService():Boolean
		{
			this.init();
			
			return _sql != null;	
		}
		
		
		
		
		
		/*
		 */
		
		public function get columns():Array
		{
			
			this.init();
			
			if(!_sql)
			{
				return null;
			}
			
			
			_dao = new TweetdeckDAO(_sql);
			var cols:Array = _dao.columns;
			_dao.close();
			return cols;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /*
		 */
		 
		
	
		private function init():void
		{
			//pref directory
			//var dir:File = File.resolvePath(File.applicationDirectory.nativePath);
			
			var tweetdir:* = this.getPrefFolder("Tweetdeck");
			
			
			if(!tweetdir)
				return;
			
			
			_sql = ClassSwitcher.getTargetClass(SFileUtil).searchFile(tweetdir,/td.+?\.db/);
		}
	}
}