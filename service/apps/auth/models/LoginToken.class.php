<?php
/**
 * !Database Default
 * !Table login_tokens
 */
class LoginToken extends Model {
	/** !Column PrimaryKey, Integer, AutoIncrement */
	public $id;

	/** !Column Integer */
	public $user;

	/** !Column String */
	public $token;

	/** !Column Timestamp */
	public $created_at;

}
?>