<?php
/**
 * !Database Default
 * !Table plugin_tags
 */
class PluginTag extends Model {
	/** !Column PrimaryKey, Integer, AutoIncrement */
	public $id;

	/** !Column Integer */
	public $plugin;

	/** !Column String */
	public $tag;

}
?>