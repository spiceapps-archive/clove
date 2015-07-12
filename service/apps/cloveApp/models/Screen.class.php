<?php
/**
 * !BelongsTo user, key: user
 * !Database Default
 * !Table screens
 * !HasMany syncs, Key: id
 */
class Screen extends Model {
	/** !Column PrimaryKey, Integer, AutoIncrement */
	public $id;

	/** !Column Integer */
	public $user;

	/** !Column String */
	public $type;

	/** !Column Timestamp */
	public $created_at;

}
?>