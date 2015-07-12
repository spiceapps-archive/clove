<Neem xmlns:plugin="com.neem.module.InstallPluginModule">
	<?php
		$idir = dirname(__FILE__)."/extensions/plugins/core/";
		
		
		
		foreach(scandir($idir) as $file)
		{
			if($file == "." || $file == ".." || $file == ".DS_Store")
				continue;
				
			
			$dir = $idir.$file."/";
			
			$install = "core/".$file;
			
			include(dirname(__FILE__).'/showAssets.php');
			
		}
	
	?>
</Neem>