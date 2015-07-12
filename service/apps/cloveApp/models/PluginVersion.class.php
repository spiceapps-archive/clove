<?php
/**
 * !BelongsTo plugin, key: plugin
 * !Database Default
 * !Table plugin_versions
 */
class PluginVersion extends Model {
	/** !Column PrimaryKey, Integer, AutoIncrement */
	public $id;

	/** !Column Integer */
	public $plugin;

	/** !Column String */
	public $version;

	/** !Column Text */
	public $update_info;
	
	/** !Column Timestamp */
	public $created_at;
	
	/** !Column String */
	public $dir;
}
?>