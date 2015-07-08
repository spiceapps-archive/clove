package com.spice.aloe
{
	import com.spice.aloe.delegates.BugTrackDelegate;
	import com.spice.aloe.delegates.LogDelegate;
	import com.spice.aloe.delegates.UserDelegate;
	import com.spice.events.log.LogEvent;
	import com.spice.model.Singleton;
	import com.spice.remoting.amfphp.IServiceConnection;
	import com.spice.remoting.amfphp.cue.ServiceCue;
	import com.spice.utils.logging.ISpiceLogger;
	import com.spice.utils.logging.Log;
	import com.spice.utils.queue.QueueManager;

	public class AloeBugTracker extends Singleton implements IServiceConnection
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		
		public static const GATEWAY:String = "http://spiceapps.com/service/core/amfGateway.php?app=bugTrack";
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _project:int;
		private var _callQueue:QueueManager;
		private var _logDelegate:LogDelegate;
		private var _userDelegate:UserDelegate;
		private var _bugTrackDelegate:BugTrackDelegate;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		
		public function AloeBugTracker()
		{
			_callQueue = new QueueManager();
			
			_logDelegate = new LogDelegate(this);
			_userDelegate = new UserDelegate(this);
			_bugTrackDelegate = new BugTrackDelegate(this);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get gateway():String
		{
			return GATEWAY;
		}
		
		/**
		 */
		
		public function get callQueue():QueueManager
		{
			return _callQueue;
		}
		
		
		/**
		 */
		
		public function get project():int
		{
			return _project;
		}
		
		/**
		 */
		
		public function set project(value:int):void
		{
			_project = value;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function report(description:String,priority:int = BugPriority.NORMAL,tags:Object = null):ServiceCue
		{
			return _bugTrackDelegate.submit(description,this.project,priority,-1,tags);
		}
		
		/**
		 */
		
		public static function getInstance():AloeBugTracker
		{
			return Singleton.getInstance(AloeBugTracker);
		}
		
		
		
		/**
		 */
		
		public static function log(code:int,description:String,metadata:Object):ServiceCue
		{
			
			var inst:AloeBugTracker = AloeBugTracker.getInstance();
			
			return inst.logDelegate.log(code,description,metadata,inst.project);
		}
		
		
		/**
		 */
		
		public static function monitor(logger:ISpiceLogger):void
		{
			getInstance().monitor(logger);
		}
		
		
		
		/**
		 */
		
		public function monitor(logger:ISpiceLogger):void
		{
			logger.addEventListener(LogEvent.NEW_LOG,onNewLog);
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function get logDelegate():LogDelegate
		{
			return _logDelegate;
		}
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
	
		private function onNewLog(event:LogEvent):void
		{
			var log:Log = event.log;
			
			
			AloeBugTracker.log(log.code,log.message,log.metadata);
		}
		
	}
}