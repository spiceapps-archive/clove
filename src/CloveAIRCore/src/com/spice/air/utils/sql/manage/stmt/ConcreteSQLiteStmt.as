package com.spice.air.utils.sql.manage.stmt
{
	import com.ei.utils.ObjectUtils;
	import com.ei.utils.info.ClassInfo;
	import com.spice.impl.utils.DescribeTypeUtil;
	import com.spice.utils.metadata.MetadataUtil;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.SQLErrorEvent;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.events.PropertyChangeEvent;
	import mx.events.PropertyChangeEventKind;
	import mx.utils.ObjectUtil;
	
	
	[Event(name="change",type="flash.events.Event")]
	
	public class ConcreteSQLiteStmt extends EventDispatcher implements ISQLiteStmt
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _ignoreChange:Boolean;
		private var _target:SQLStatement;
		private var _changeEvent:Event;
		private var _parameterChange:PropertyChangeEvent;
		private var _parameters:Object;
		private var _hasChange:Boolean;
		private var _initialized:Boolean;
		private var _children:Vector.<ConcreteSQLiteStmt>;
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ConcreteSQLiteStmt()
		{
			_children = new Vector.<ConcreteSQLiteStmt>();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function get target():SQLStatement
		{
			if(!_target)
			{
				_target = new SQLStatement();
				_target.addEventListener(SQLErrorEvent.ERROR,onError);
				_target.text = this.toString();
				this.initialize();
				
			}
			else
				if(_hasChange)
				{
					_hasChange = false;
					//if the statement doesn't exist, don't bother instantiated it
					//because it could be a sub-statement we don't use
					_target.text = this.toString();
					
					Logger.log("query="+_target.text,this);
				}
			
			if(this._parameters)
			{
				var params:Object = _target.parameters;
				
				var hasNewParam:Boolean;
				
				for(var i:String in _parameters)
				{
					if(params[i] == undefined) 
						hasNewParam = true;
					
					params[i] = _parameters[i];
				}
				
				this._parameters = undefined;
				
				//if there is a new parameter, then a child has changed
				if(hasNewParam)
				{
					_target.text = this.toString();
				}
			}
			
			return _target;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ignoreChange():void
		{
			this._ignoreChange = true;
			
			for each(var child:ConcreteSQLiteStmt in this._children)
			{
				child.ignoreChange();
			}
		}
		
		/**
		 */
		
		public function listenForChange(update:Boolean = false):void
		{
			this._ignoreChange = false;
			
			for each(var child:ConcreteSQLiteStmt in this._children)
			{
				child.listenForChange(false);
			}
			
			if(update)
			{
				this.change();
			}
		}
		/**
		 */
		
		public function change():void
		{
			
			if(this._ignoreChange)
				return;
			
			_hasChange = true;	
			
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		
		
		/**
		 */
		
		public function setParameter(name:String,value:Object):void
		{
			
			
			
			
			if(this._target)
			{
				//if the parameter is new, then either this, or a child statement is writing out the part that uses it.
				if(_target.parameters[name] == undefined)
					this.change();
				
				_target.parameters[name] = value;//value == null ? undefined : value;
			}
			else	
				//if the target exists, but the value set is UNDEFINED, then do not proceed to add the value
				if(value != null)
				{
					if(!_parameters) _parameters = {};
					
					this._parameters[name] = value;
				}
				else
				{
					return;
				}
			
//			if(this._initialized)
			{
				this.dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE,false,false,null,name,null,value));
			}
		}
		
		/**
		 */
		
		public function digestParameters(props:Object):void
		{
			
			for(var i:String in props)
			{
				this.setParameter(i,props[i]);
			}
			
			this.change();
		}
		
		
		/**
		 */
		
		public function getParameters():Object
		{
			return this._parameters;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function watchForChanges():void
		{
			
			
			
			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function removeChildStatement(value:ConcreteSQLiteStmt):void
		{
			if(!value || value == this)
				return;
			
			var i:int = this._children.indexOf(value);
			
			if(i == -1)
				return;
			
			this._children.splice(i,1);
			
			value.removeEventListener(Event.CHANGE,onChildChange);
			value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onParamsChange);
			
		}
		/**
		 */
		
		public function addChildStatement(value:ConcreteSQLiteStmt):void
		{
			if(!value || value == this)
				return;
			
			
			value._ignoreChange = this._ignoreChange;
			
			if(this._children.indexOf(value) == 0)
				this._children.push(value);
			
			this.digestParameters(value.getParameters());
			
			value.addEventListener(Event.CHANGE,onChildChange);
			value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,onParamsChange);
		}
		
		/**
		 */
		
		public function swapChildren(oldChild:ConcreteSQLiteStmt,newChild:ConcreteSQLiteStmt):void
		{
			this.removeChildStatement(oldChild);
			this.addChildStatement(newChild);
		}
		/**
		 */
		
		public function clone():ISQLiteStmt
		{
			return null;
		}
		
		/**
		 */
		
		override public function toString():String
		{
			return "";
		}
		
		
		/**
		 */
		
		protected function initialize():void
		{
			if(this._initialized)
				return;
			
			this._initialized = true;
			
			for each(var child:ConcreteSQLiteStmt in this._children)
			{
				child.initialize();
			}
			
		}
		
		/**
		 */
		
		protected function onChildChange(event:Event):void
		{
			this.change();
		}
		
		/**
		 */
		
		private function onParamsChange(event:PropertyChangeEvent):void
		{
			this.setParameter(event.property.toString(),event.newValue);
		}
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		
		/**
		 */
		
		private function onError(event:SQLErrorEvent):void
		{
			Logger.log(event.error,this);
			
			dispatchEvent(event.clone());
		}
		
		
		
		
	}
}

/*class PropWatcher
{
private var _stmt:ConcreteSQLiteStmt;
private var _prop:String;

function PropWatcher(stmt:ConcreteSQLiteStmt,property:String)
{
_prop = property;
_stmt = stmt;



ChangeWatcher.watch(stmt,property,onPropChange,false,true);

onPropChange();
}

public function onPropChange(event:* = null):void
{
var prop:Object = _stmt[_prop];
if(prop is ISQLiteStmt)  
{
var params:Object = ConcreteSQLiteStmt(prop).getParameters();

if(params)
this._stmt.digestParameters(params);

prop.removeEventListener(Event.CHANGE,onChange);
prop.removeEventListener("parameterChange",onParameterSet);
prop.addEventListener(Event.CHANGE,onChange);
prop.addEventListener("parameterChange",onParameterSet);
}
_stmt.change();
}

private function onChange(event:* = null):void
{
_stmt.change();
}


private function onParameterSet(event:PropertyChangeEvent):void
{
_stmt.setParameter(event.property.toString(),event.newValue);
}
}*/