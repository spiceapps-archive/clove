<?php
/**
 * !Database Default
 * !Table plugins
 * !HasMany pluginVersions, Key: plugin
 */
class Plugin extends Model {
	/** !Column PrimaryKey, Integer, AutoIncrement */
	public $id;

	/** !Column Integer */
	public $user;

	/** !Column String */
	public $name;

	/** !Column Text */
	public $description;

	/** !Column Timestamp */
	public $created_at;

	/** !Column Timestamp */
	public $updated_at;

	/** !Column Text */
	public $factory;

	/** !Column String */
	public $version;
	
	
	/** !Column String */
	public $uid;
	

}
?>