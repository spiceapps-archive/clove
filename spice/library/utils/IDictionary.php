<?php
/**
 * The IDictionary interface
 *
 * @author Olavo Alexandrino <oalexandrino@yahoo.com.br>
 * @copyright Copyright 2005-2006, Olavo Alexandrino
 * @link http://oalexandrino.com
 * @package system.collections
 */
interface IDictionary
{
	/**
	* Adds a key and item pair to a Dictionary object.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @param variant The key associated with the item being added.
	* @param variant The item associated with the key being added.
	* @return void 
	*/
	public function add( $key, $item );
	
	/**
	* Returns True if a specified key exists in the Dictionary object, False if it does not.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @param variant Key value being searched for in the Dictionary object.
	* @return boolean 
	*/
	public function exists( $key );
	
	/**
	* Returns an array containing all the items in a Dictionary object.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @return array
	*/
	public function items();	
	
	/**
	* Returns an array containing all existing keys in a Dictionary object.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @return array
	*/
	public function keys();	
	
	/**
	* Removes a key, item pair from a Dictionary object.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @param variant Key associated with the key, item pair you want to remove from the Dictionary object.
	* @return void  
	*/
	public function remove( $key );	
	
	/**
	* The RemoveAll method removes all key, item pairs from a Dictionary object.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @return void 
	*/
	public function removeAll();
}
?>