<?php

/**
 * The Dapper SDK, primary class.
 *
 * The Dapper SDK provide a programmatic way to access Dapps.  It allows 
 * programmers to supply variable inputs and obtain XML.  Additionally, it 
 * provides various means for manipulating the XML (simplexml, DOM, xpath)
 *
 * @package DapperSDK
 */

require_once(dirname(__FILE__).'/Exceptions.php');
require_once(dirname(__FILE__).'/Util.php');
require_once(dirname(__FILE__).'/Cacher.php');

/**
 * @package DapperSDK
 * @version 0.4
 */
class Dapp {

  /**
   * The host of the Dapper service
   */  
  public static $DAPPER_HOST = 'www.dapper.net';

  /**
   * The path of the Dapper service
   */  
  public static $DAPPER_SERVICE_PATH = '/RunDapp';

  /**
   * The URL of the Dapp information service
   */  
  public static $DAPP_SERVICE_PATH = '/websiteServices/dapp-json.php';

  /**
   * @var string
   */
  private $xml;

  /**
   * @var mixed
   */
  private $dappArray;

  /**
   * @var string
   */
  private $pageUrl;

  /**
   * @var Cacher
   */
  private $cacher = null;

  /**
   * @var bool
   */
  private $cachingEnabled = true;

  /**
   * Sets up the Dapp.
   *
   * Constructor is used to set up the Dapp - it performs the HTTP request 
   * and receives the XML which comes back.
   *
   * @param string $dappName    The identifier of the Dapp.
   * @param string $applyToUrl  The URL of the page you wish to Dapp (optional).
   *                            Only makes sense when $variableArgs is not 
   *                            supplied.
   * @param array $variableArgs The variable input arguments to pass to the 
   *                            Dapp (optional). This should be a hash. If the
   *                            variables are named (in the event of POST Dapp),
   *                            then the hash keys should be the names, 
   *                            otherwise they should be numeric indices.
   * @param array $loginCredentials The username and password for the 
   *                            remote website (optional). This should be a hash
   *                            with keys "username" and "password".  If the 
   *                            credentials are supplied, then there should be
   *                            an additional key called "encryptionAlg" with 
   *                            value "1". If you do not supply this information
   *                            and the Dapp requires it, the constructor will 
   *                            throw MissingLoginCredentialsException.
   *
   * @throws NetworkErrorException
   * @throws DappNotFoundException
   * @throws InvalidDappOutputException
   * @throws MissingLoginCredentialsException
   */
  public function Dapp($dappName, $applyToUrl = null, $variableArgs = array(), $loginCredentials = array()) {
    // try to create a cacher object
    try {
      if ($this->cachingEnabled)
        $this->cacher = new Cacher();
    }
    catch (Exception $e) {
    }

    // get the dapp information from the server (or from cache if applicable)
    try {
      if (!is_null($this->cacher))
        $dappSerialization = $this->cacher->getCache($dappName.'.dappDetails');
      else
        throw new Exception('No Cacher');
    }
    catch (Exception $e) {
      // okay, the dapp details are not cached or there is no cacher
      
      $dappUrl           = 'http://'.
                           self::$DAPPER_HOST.
                           self::$DAPP_SERVICE_PATH.
                           '?mode=serialized'.
                           '&dappName='.rawurlencode($dappName);
      $dappSerialization = file_get_contents($dappUrl);
      if (!$dappSerialization)
        throw new NetworkErrorException('Unable to retrieve Dapp details from '.
                                        $dappUrl);
  
      if (preg_match('/Dapp does not exist/', $dappSerialization))
        throw new DappNotFoundException();
      
      if (!is_null($this->cacher)) {  
        try {
          $this->cacher->putCache($dappName.'.dappDetails', $dappSerialization);
        }
        catch (Exception $e) {
          // could not cache, but that is okay - we just won't cache
        }
      }
    }

    // convert the dapp serialization to a Dapp array
    $this->dappArray = unserialize($dappSerialization);

    $xmlUrl = 
      'http://'.
      self::$DAPPER_HOST.
      self::$DAPPER_SERVICE_PATH.
      '?dappName='.$dappName.
      '&v=1';
    if(isset($applyToUrl) && !empty($applyToUrl))
      $xmlUrl .= '&applyToUrl='.rawurlencode($applyToUrl);
    if(isset($variableArgs) && is_array($variableArgs) && !empty($variableArgs)) {
      $variableArgsModified = array();
      foreach ($variableArgs as $argName => $argValue)
        $variableArgsModified['v_'.$argName] = $argValue;
      $xmlUrl .= '&'.http_build_query($variableArgsModified);
    }
    if(isset($loginCredentials) && is_array($loginCredentials) && !empty($loginCredentials))
      $xmlUrl .= '&'.http_build_query($loginCredentials);


    $ref = '-';
    if (!empty($_SERVER['SERVER_NAME']) && !empty($_SERVER['REQUEST_URI']))
      $ref = 'http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
    $context = stream_context_create(
                 array('http' =>
                         array(
                           'header' => 'Referer: '.$ref."\r\n".
                                       "User-Agent: Dapper SDK (PHP5, v0.3)\r\n"
                         )
                      )
               );
    $xml = file_get_contents($xmlUrl, false, $context);
    if (!$xml)
      throw new NetworkErrorException('Unable to execute Dapp using URL '.
                                      $xmlUrl);

    $this->xml = $xml;   

    $xpath = $this->getXPath();

    // Check if there were errors

    $errorMessages = $xpath->query('/results[./status[.="ERROR"]]/message');
    if($errorMessages->length)
    {
      $errorMessage = $errorMessages->item(0)->nodeValue;
      if(preg_match('/^Missing required parameter: /', $errorMessage))
        throw new InvalidVariableArgumentsException($errorMessage);
      elseif(preg_match('/^Failed converting /', $errorMessage))
        throw new InvalidVariableArgumentsException($errorMessage);
      elseif(preg_match('/does not exist$/', $errorMessage))
        throw new DappNotFoundException($errorMessage);
      else
        throw new InvalidDappOutputException($errorMessage);
    }

    // Get the applyToUrl that was used
    $applyToUrls = $xpath->query('/elements/dapper/applyToUrl');
    if($applyToUrls->length)
    {
      $this->pageUrl = $applyToUrls->item(0)->nodeValue;
    }
    else
    {
      throw new InvalidDappOutputException("Cannot determine applyToUrl from RunDapp output");
    }
  }

  /**
   * Returns the XML output of the Dapp as a string.
   *
   * @return string The XML output of the Dapp
   */
  public function getXML() {
    return $this->xml;
  }

  /**
   * Returns the HTML that the Dapp ran on as a string.
   *
   * @return string The HTML that the Dapp ran on
   */
  public function getHTML() {
    throw new Exception("getHTML() is no longer supported");
  }

  /**
   * Returns a DOMDocument object to work on the XML
   *
   * @link http://www.php.net/dom
   *
   * @return DOMDocument DOMDocument object representing the Dapp's XML
   * 
   * @throws InvalidDappOutputException
   */
  public function getDOM() {
    $doc = new DOMDocument();
    $doc->loadXML($this->getXML());
    if (!$doc->documentElement) {
      throw new InvalidDappOutputException();
    }

    return $doc;
  }

  /**
   * Returns a DOMXPath object to work on the XML
   *
   * @link http://www.php.net/dom
   *
   * @param DOMDocument $doc DOMDocument object, as returned from getDOM() 
   *                         (optional)
   *
   * @return DOMXPath DOMXPath object allowing XPath access to the Dapp's XML
   * 
   * @throws InvalidDappOutputException
   */
  public function getXPath($doc = null) {
    if (!isset($doc))
      $doc = $this->getDOM();
    
    return new DOMXPath($doc);
  }

  /**
   * Returns the URL of the page that was dapped
   *
   * @return string URL of the page that was dapped
   */
  public function getPageURL() {
    return $this->pageUrl;
  }
}

?>
