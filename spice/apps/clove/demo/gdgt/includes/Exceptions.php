<?php

/**
 * Dapper Exceptions
 *
 * @package DapperSDK
 */

/**
 * An exception thrown when a network error occurs (timeout, server down, etc.)
 *
 * @package DapperSDK
 */
class NetworkErrorException extends Exception {
  
}

/**
 * An exception thrown when the output of a Dapp is not valid XML.
 *
 * Some times Dapper does not return valid XML.  This typically occurs when a 
 * serious error has been encountered. 
 *
 * @package DapperSDK
 */
class InvalidDappOutputException extends Exception {
  
}
 
/**
 * An exception thrown when the an attempt is made to use a non-existant Dapp
 *
 * @package DapperSDK
 */
class DappNotFoundException extends Exception {
  
}

/**
 * An exception thrown when the variable arguments to a Dapp do not match the
 * variable arguments expected
 *
 * @package DapperSDK
 */
class InvalidVariableArgumentsException  extends Exception {
  
}

/**
 * An exception thrown when trying to access a Dapp that works with a website
 * that requires login, but the username and password are not supplied
 *
 * @package DapperSDK
 */
class MissingLoginCredentialsException  extends Exception {
  
}
?>