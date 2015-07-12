<?php
/**
 * !Database Default
 * !Table users
 */
class User extends Model {
	/** !Column PrimaryKey, Integer, AutoIncrement */
	public $id;

	/** !Column String */
	public $username;

	/** !Column String */
	public $password;

	/** !Column String */
	public $email;

	/** !Column Boolean */
	public $activated;
	
	
	/** !Column String */
	public $activation_code;
	
	/** !Column Integer */
	public $invite_code;

	/** !Column Integer */
	public $permissions;

	/** !Column Timestamp */
	public $created_at;
	
	/** !Column String */
	public $fullName;
	
	/** !Column Integer */
	public $login_attempts;
	
	/** !Column Timestamp */
	public $last_login;
	
	/** !Column Boolean */
	public $subscribed;

}
?>