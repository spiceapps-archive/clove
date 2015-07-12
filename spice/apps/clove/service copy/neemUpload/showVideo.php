<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Ginger</title>
    <script type="text/javascript" src="assets/Ginger/assets/js/swfobject.js"></script>
    <style type="text/css">

    body {
        height: 100%;
        margin: 0;
        padding: 0;
        background-color: #fff;
        font: normal 80% Helvetica, Arial, sans-serif;
        color: #000;  
		overflow:hidden;
    }
   
    
    #flashcontent {
        width:100%;
		height:100%;
    }
    </style>

</head>
<body>
   
    <div id="flashcontent">                                                                                                       
    </div>
    <script type="text/javascript">
        // <![CDATA[

        var so = new SWFObject("assets/Ginger/assets/swf/Bridge.swf", "bridge", "100%", "100%", "8", "#111111");
        so.addVariable("script","assets/Ginger/assets/xml/GingerMediaPlayer.xml");            
		so.addVariable("plugins","assets/Ginger/assets/plugins/posterFrame.xml");                    
        so.addVariable("skin","assets/Ginger/assets/skins/Ginger/skin.xml");  
        so.addVariable("host","assets/Ginger/assets/");
		so.addVariable("video","<?=$file; ?>");
        so.addParam("scale", "noscale");  
        so.addParam("allowFullScreen","true");
        so.addParam("allowScriptAccess","always");
        so.write("flashcontent");

        // ]]>
    </script>

</body>
</html>