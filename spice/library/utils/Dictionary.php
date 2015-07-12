
<?php 
	require_once(dirname(__FILE__).'/IDictionary.php');     
	
/**
 * Dictionary class is an implementation of IDictionary interface. 
 * 
 * Based on Microsoft Scripting Runtime Library - Dictionary Object, a PHP Dictionary object is the equivalent of a PERL associative array. 
 * Items can be any form of data, and are stored in the array. 
 * Each item is associated with a unique key. 
 * The key is used to retrieve an individual item and is usually an integer or a string, but can be anything except an array.
 *
 * @author Olavo Alexandrino <oalexandrino@yahoo.com.br>
 * @copyright Copyright 2005-2006, Olavo Alexandrino
 * @link http://msdn.microsoft.com/library/default.asp?url=/library/en-us/script56/html/b4a7ddb3-2474-49ef-8540-8d67a747c8db.asp 
 * @package system.collections
 */
class Dictionary implements IDictionary
{
	/**
	* @var array array of itens
	*/	
	protected $itens 	= null;
	
	/**
	* Constructor.
	*/
	function __construct()
	{
		$this->itens 	= array();
	}
	
	/**
	* Append associative array elements.
	* 1.  removes seemingly useless array_unshift function that generates php warning
	* 2.  adds support for non-array arguments
	* @author steve@webthought.ca
	* @param array array with "key" and "item" 
	* @link http://www.php.net/array_push 
	* @return void 
	*/	
	private function array_push_associative( $item ) 
	{
	   $args = func_get_args();
	   
	   foreach ($args as $item) 
	   {
	       if (is_array($item)) 
	       {
	           foreach ($item as $key => $value) 
	           {
	               $this->itens[$key] = $value;
	           }
	       }
	       else
	       {
	          $this->itens[$item] = "";
	       }
	   }
	}
	
	/**
	* Adds a key and item pair to a Dictionary object.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @param variant The key associated with the item being added.
	* @param variant The item associated with the key being added.
	* @return void 
	*/
	public function add( $key, $item )
	{
		if ( !self::exists($key) )
		{
			self::array_push_associative( array( (string) $key => $item ) );
		}
		else
			throw new Exception("Item already added");
				
	}
	
	/**
	* Returns True if a specified key exists in the Dictionary object, False if it does not.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @param variant Key value being searched for in the Dictionary object.
	* @return boolean 
	*/
	public function exists( $key )
	{
		return array_key_exists($key, $this->itens); 
	}	
	
	/**
	* Returns an array containing all the items in a Dictionary object.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @return array
	*/
	public function items()
	{
		return $this->itens;
	}	
	
	/**
	* Returns an array containing all existing keys in a Dictionary object.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @return array
	*/
	public function keys()
	{
		return array_keys( $this->itens );
	}	
	
	/**
	* Removes a key, item pair from a Dictionary object.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @param variant Key associated with the key, item pair you want to remove from the Dictionary object.
	* @return void  
	*/
	public function remove( $key )
	{
		if ( self::exists($key) )
		{
			$objArray = new ArrayObject( $this->itens  );			
			$objArray->offsetUnset($key);
			$objArray = null;
		}
		else
			throw new Exception("Could not remove: Item not found!");		
	}	
	
	/**
	* The RemoveAll method removes all key, item pairs from a Dictionary object.
	* @author Olavo Alexandrino <oalexandrino@yahoo.com.br> 
	* @return void 
	*/
	public function removeAll()
	{
		$this->itens = array();
	}	
	
}
?>
