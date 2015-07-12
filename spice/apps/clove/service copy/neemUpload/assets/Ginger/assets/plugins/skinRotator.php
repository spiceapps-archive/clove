<Bridge> 
	<action:script>
		<![CDATA[  
			                    
			
			cueHandlers.skinRotator = skinRotator;
			
			
			function loadSkin2(skin:String)
			{
				var skinPath = "assets/skins/"+skin+"/skin.xml";
				
				loadSkin(skinPath);
			}
		]]> 
	</action:script> 
	          
	
	<?php   
		$i = 0; 
		foreach(scandir(dirname(__FILE__)."/../skins/") as $file) 
		{                
			if($file == ".." || $file == "." || $file == ".DS_Store")
				continue;
	?>
	<Container buttonMode="{true}" width="100" height="50" right="<?=$i; ?>" style="backgroundAlphas:0.5;" observer:click="loadSkin2('<?=$file; ?>')">
		<Label verticalCenter="0" horizontalCenter="0" text="<?=$file;?> Skin" style="fontColor:#FFFFFF;fontSize:12;" />
	</Container>
	
	<?php
		$i += 110;
		}
	?>
	
	
</Bridge>