<?php
	
	class RequestUtil
	{
		public static function doPostRequest($url, $data, $optional_headers = null) 
		{
			$c= curl_init();
			curl_setopt($c, CURLOPT_URL,$url);
			curl_setopt($c, CURLOPT_POST,true);
			
			$params = array();
			
			foreach($data as $k => $v)
			{
				$params[] = "$k=$v";
			}
			
			
			curl_setopt($c, CURLOPT_POSTFIELDS, implode("&",$params));
			
			//remove the echo that comes in via curl
			ob_start();
			curl_exec($c);
			ob_end_clean();
			
			curl_close($c);
		}
	}
	
?>