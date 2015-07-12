<?php
/**
 * !BelongsTo user, key: user
 * !Database Default
 * !Table scenes
 * !HasMany syncs, Key: id
 * !HasMany scene_subscriptions, key: scene
 */
class Scene extends Model {
	/** !Column PrimaryKey, Integer, AutoIncrement */
	public $id;

	/** !Column Integer */
	public $user;

	/** !Column String */
	public $name;

	/** !Column Boolean */
	public $premium;

	/** !Column Text */
	public $description;

	/** !Column Timestamp */
	public $created_at;

}
?>