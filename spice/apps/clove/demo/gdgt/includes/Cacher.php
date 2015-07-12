<?php

/**
 * The Dapper SDK, caching class.
 *
 * This class provides caching support for the Dapper SDK.
 *
 * @package DapperSDK
 */

/**
 * The path where cache files are kept
 */  
define('CACHE_DIR', '/tmp/DapperSDKCache');

/**
 * The amount of time before a cache file is expired
 */  
define('CACHE_LIFETIME_SECS',600);

/**
 * @package DapperSDK
 * @version 0.3
 */
class Cacher {

  /**
   * Initializes the Cacher
   *
   * @throws Exception When cannot establish cache directory
   */
  public function Cacher() {

    // make sure the cache directory exists or if not, that we can create it
    if (!file_exists(CACHE_DIR) && !mkdir(CACHE_DIR, 0755, true)) {
        throw new Exception('Cache directory does not exist and unable to '.
                            'create it ('.CACHE_DIR.')');      
    }
  }

  /**
   * Puts contents into the cache
   *
   * @param string $identifier A unique identifier for the cache
   * @param string $contents The contents to cache
   *
   * @return bool 
   * @throws Exception When cannot write cache
   */
  public function putCache($identifier, $contents) {
    $serContents = serialize($contents);

    if (!file_put_contents($this->getCacheFileName($identifier),$serContents))
      throw new Exception('Unable to store cache at '.$this->getCacheFileName($identifier));
    
    return true;
  }
  
  /**
   * Retrieves contents from the cache
   *
   * @param string $identifier The unique identifier of the cache
   *
   * @return string Contents of the cache
   * @throws Exception When cannot read cache or when it is expired or does not
   *                   exist.
   */
  public function getCache($identifier) {
    $fileName = $this->getCacheFileName($identifier);
    
    if (!file_exists($fileName))
      throw new Exception('No such stored cache: '.$identifier);
    
    if ((time() - filemtime($fileName)) > CACHE_LIFETIME_SECS)
      throw new Exception('Cache has expired');
    
    $contents = file_get_contents($fileName);
    
    if (!$contents)
      throw new Exception('Unable to load cache file: '.$fileName);
    
    return unserialize($contents);
  }

  private function getCacheFileName($identifier) {
    return CACHE_DIR.'/'.md5($identifier);
  }

}

?>