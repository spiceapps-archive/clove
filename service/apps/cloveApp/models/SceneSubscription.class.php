<?php
/**
 * !BelongsTo scene, key: scene
 * !Database Default
 * !Table scene_subscriptions
 */
class SceneSubscription extends Model {
	/** !Column PrimaryKey, Integer, AutoIncrement */
	public $id;

	/** !Column Integer */
	public $scene;

	/** !Column Integer */
	public $subscribed_to;

	/** !Column Timestamp */
	public $created_at;

}
?>