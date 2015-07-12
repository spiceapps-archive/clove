<?php

/**
 * Utiliy functions
 * @package DapperSDK
 */

require_once('Exceptions.php');

/**
 * Utiliy functions class
 * @package DapperSDK
 */
class Util {
 
  /**
   * Performs an HTTP POST
   *
   * @param string $host The hostname of the remote web server
   * @param string $path The path portion of the URL
   * @param array  $data A hash where the keys are the POST variable names, the
   *                     values are the values for those variables
   * @param string $encoding The encoding of the content - if this is not supplied
   *                     when posting to Dapper, the output may be wrong.
   *
   * @return array ($headers, $data) - the headers and content of the resulting
   *               page returned after the POST
   */
  public static function httpPost($host, $path, $data, $encoding = null) {
    $buf = '';
    
    $dataParts = array();
    foreach ($data as $k => $v)
      $dataParts[] = "$k=".rawurlencode($v);

    $data = join('&', $dataParts);      
    
    $fp = fsockopen($host, 80);
    if (!$fp)
      throw new NetworkErrorException("Unable to POST to $host$path");
      
    fputs($fp, "POST $path HTTP/1.0\r\n");
    fputs($fp, "Host: $host\r\n");
    fputs($fp, "Content-type: application/x-www-form-urlencoded".(isset($encoding) ? ";charset=$encoding" : '')."\r\n");
    fputs($fp, "Content-length: ".(strlen($data))."\r\n");
    if (Util::endsWith($host, 'dapper.net')) {
      fputs($fp, "User-Agent: Dapper SDK (PHP5, v0.3)\r\n");
    }
    elseif (ini_get('user_agent')) {
      fputs($fp, "User-Agent: ".ini_get('user_agent')."\r\n");
    }
    fputs($fp, "Connection: close\r\n\r\n");
    fputs($fp, $data);

    $headerLines = array();
    $dataLines   = array();
    $headersOver = false;
    while (!feof($fp)) {      
      $line = fgets($fp,4096);
      if (!$headersOver && preg_replace('/[\r\n\f]+/','',$line) == '') {
        $headersOver = true;
        continue;
      }
      
      if(!$headersOver)
        $headerLines[] = $line;
      else
        $dataLines[]   = $line;
    }

    fclose($fp);
    
    /*
    file_put_contents('/tmp/poo.txt', "headers: ".join("",$headerLines)."\n\n".
                                      "the data: ".join("",$dataLines));
    */
    
    // separate the headers from the rest
    //$buf = preg_replace('/\r\n/m',"\n",$buf);
    //list($headers, $data) = preg_split('/(\r\n\r\n|\n\n)/', $buf, 2);
    list($headers, $data) = array(join('', $headerLines), join('', $dataLines));
    
    return array($headers, $data);
  }  
  
  private function endsWith( $str, $sub ) {
   return ( substr( $str, strlen( $str ) - strlen( $sub ) ) === $sub );
  }
  
}

?>