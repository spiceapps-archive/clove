<?php
Layout::input($title, 'string');
Layout::input($breadcrumbs, 'array');
Layout::input($body, 'Block');
?>
<html>
	<head>
        <link rel="stylesheet" type="text/css" media="screen" href="/backend/style.css" />
		<title><?=$title; ?></title> 
	</head>
	<body>
		
        <div id="header">
        	<?php 
        	$n = count($breadcrumbs);
        	$m = "";
        	for($i = 0; $i < $n; $i++)
        	{
        		$breadcrumb = $breadcrumbs[$i];
        		
           		$name = @$breadcrumb["name"];
        		$link = @$breadcrumb["link"];
        		
        		if($i < $n-1)
        		{
        			$m .= "<a class=\"light\" href=\"$link\">$name &#9656;</a> ";
        		}
        		else
        		{
        			$m .= $name;
        		}
        		
        	}
        	
        		echo $m;
        	?>
        	
        </div>
        
        <div id="content">
            
			<br />
	        
	        <?=$body; ?>
	
		
   		</div>


    </body>
</html>