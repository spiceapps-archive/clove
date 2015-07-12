<?php
/**
 * !BelongsTo screen, Key: screen
 * !BelongsTo scene, Key: scene
 * !Database Default
 * !Table syncs
 */
class Sync extends Model {
	/** !Column PrimaryKey, Integer, AutoIncrement */
	public $id;

	/** !Column Integer */
	public $screen;

	/** !Column Integer */
	public $scene;

	/** !Column Timestamp */
	public $created_at;
	
	/** !Column String */
	public $name;
}
?>