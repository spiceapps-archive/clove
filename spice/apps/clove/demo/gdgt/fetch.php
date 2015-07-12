<?php

require_once(dirname(__FILE__).'/includes/Dapp.php');

// The Dapp constructor throws Exceptions - so we should catch it
try {
	
 	$url = $_GET["url"];
	$specsUrl = $url."/specs/";
	
  
  /* Example 1a: 
   * Perform a MSN search for "good times" using variable arguments*/
  $gdgtReviews = new Dapp('GDGTReviews',$url);
  $gdgtSpecs   = new Dapp('GDGTItemSepcs',$specsUrl);
  
  $dom  = $gdgtReviews->getDOM();
  $info = $dom->getElementsByTagName("Review_Info");




  $specDom = $gdgtSpecs->getDom();
  $specs = $specDom->getElementsByTagName("Spec");

  for($i = 0; $i < $specs->length; $i++)
  {
	$tag = $specs->item($i)->getElementsByTagName("specs")->item(0)->nodeValue;
	
	if($tag == "Original MSRP:")
	{
		$price = $specs->item($i+1)->getElementsByTagName("specs")->item(0)->nodeValue;
		preg_match('/[\d\.]+/',$price,$matches);
		$price = $matches[0];
		break;
	}
	//Original MSRP:
  }


  
  
  $img = $info->item(0)->getAttribute("src");
  $about = $info->item(1)->nodeValue;
  $minusHost = preg_replace('/.*?\.com\//is',"",$url);
  $prodInf = explode("/",$minusHost);
  $manufacturer = array_shift($prodInf);
  $product = implode($prodInf," ");

  $info = array("manufacturer"=>$manufacturer,"product"=>$product,"img"=>$img,"about"=>$about,"price"=>$price);

  echo json_encode($info);

  
  
}
catch (Exception $e) {
  echo 'Exception: '.get_class($e)."\nMessage: ".$e->getMessage()."\n";
}

?>