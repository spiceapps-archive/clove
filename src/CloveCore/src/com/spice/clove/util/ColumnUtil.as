	package com.spice.clove.util
	{
		import com.spice.clove.events.CloveColumnEvent;
		import com.spice.clove.plugin.column.ClovePluginColumn;
		import com.spice.clove.plugin.column.ColumnMetaData;
		import com.spice.clove.plugin.core.column.ICloveColumn;
		import com.spice.vanilla.impl.settings.basic.BasicSettingType;
		import com.spice.vanilla.impl.settings.basic.NumberSetting;
		
		import flash.geom.ColorTransform;
		import flash.utils.describeType;
		
		public class ColumnUtil
		{
			
			
			
			
			/*
			  used for when metadata needs to be transfered from one column to another. this is usually needed
			  when the single column data type is changed.  
			  @param fromCol the column to copy the metadata from
			  @param toCol the column to copy the metadata to
			  @param constant the constant class that contains the metadata names
			  
			 */		
			 
//			public static function copyMetaData(fromCol:ClovePluginColumn,
//											    toCol:ClovePluginColumn,
//											    constant:Class):void
//			{
//				var desc:XML = flash.utils.describeType(constant);
//				
//				
//				var cname:String;
//				var cvalue:String;
//				
//				for each(var constnt:XML in desc.constant)
//				{
//					cname = constnt.@name;
//					cvalue = constant[cname];
//					
//					
//					var isPrivate:Boolean = constnt.metadata.(@name=='PrivateMetaData').@name == 'PrivateMetaData';
//				
//					if(fromCol.metadata.hasSetting(cvalue) && !isPrivate)
//					{
//						toCol.metadata.saveSetting(cvalue,fromCol.metadata.getSetting(cvalue));
//					}
//				}
//			}
			
			/*
			 */
			
//			public static function saveMetadata(col:ClovePluginColumn,metadata:Object):void
//			{
//				for(var i:String in metadata)
//				{
//					col.metadata.saveSetting(i,metadata[i]);
//				}
//			}
			
			
			/*
			 */
			
			public static function refreshColumn(col:ClovePluginColumn):void
			{
				col.dispatchEvent(new CloveColumnEvent(CloveColumnEvent.LOAD,col));
				
				for each(var ch:ClovePluginColumn in col.children.toArray())
				{
					refreshColumn(ch);
				}
			}
			
			/*
			 */
			
			public static function filterColumns(target:ClovePluginColumn,rule:Function):Array
			{
				var stack:Array = [];
				
				
				var ccol:ClovePluginColumn;
				
				for(var i:int = 0; i < target.children.length; i++)
				{
					ccol = target.children.getItemAt(i) as ClovePluginColumn;
					
					if(rule(ccol))
					{
						stack.push(ccol);
					}
					
					stack = stack.concat(filterColumns(ccol,rule));
				}
				
				return stack;
			}
			
			
			public static function sortColumnByName(target:ClovePluginColumn):void
			{
				var children:Array = target.children.toArray();
				
				Object(target.children).source = null;
				
				children.sortOn("title");
				
				Object(target.children).source = children;
			}
			
			
			
			
			/*
			 */
			
			
			private static const COLOR_VARIATIONS:Array = [8|16/*RG*/,8|32/*RB*/,16|32/*GB*/,8/*R*/,16/*G*/,32/*B*/];
			
			
												
			
			
			public static function generateRandomColumnColor(target:ClovePluginColumn):void
			{
				
				
				var n:uint = 3;
				var i:int  = Math.floor(Math.random() * COLOR_VARIATIONS.length);
				var a:int  = COLOR_VARIATIONS[i];
				
				
																	
				NumberSetting(target.metadata.getNewSetting(BasicSettingType.NUMBER,ColumnMetaData.COLUMN_COLOR)).setData(new ColorTransform(1,1,1,1,  (a & 8) ?  Math.random() * 95 + 160 :  Math.random() * 100 + 25,  (a & 16) ?  Math.random() * 95 + 160 :  Math.random() * 100 + 25,  (a & 32) ?  Math.random() * 95 + 160 :  Math.random() * 100 + 25).color);
			}
			
			
		}
	}