package com.spice.clove.utils
{
	import com.spice.display.controls.list.SmoothList;
	
	
	public class CloveColumnUtil
	{
		/*
		  filters the target clove column
		  @param target the target column
		  @param rule the rule function to follow when filtering columns
		  @return the found columns
		  
		 */		
		public static function filterColumns(target:*,rule:Function):Array
		{
			var stack:Array = [];
			
			var ccol:*;
			
			if(target.children)
			for(var i:int = 0; i < target.children.length; i++)
			{
				ccol = target.children.getItemAt(i);
				
				if(!ccol)
					continue;
				
				if(rule(ccol))
				{
					stack.push(ccol);
				}
				
				stack = stack.concat(filterColumns(ccol,rule));
			}
			
			return stack;
		}
		
		
		/*
		  called when the current group changes. This is needed so rendered data doesn't flood memory needlessly
		 */
		
		public static function dumpHistoryExcept(target:*,current:* = null):void
		{
			if(!current)
			{
				current = target;
				
				while(current.parent)
				{
					current = current.parent;	
				}
				
			}
			
			if(current == target)
				return;
			
			
			if(current.dataProvider)
				current.dataProvider.removeAll();
			
			for each(var c:* in current.children.toArray())
			{
				dumpHistoryExcept(target,c);
			}
		}
		
		
		

	}
}