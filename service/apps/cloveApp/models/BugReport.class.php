<?php
/**
 * !Database Default
 * !Table bug_reports
 */
class BugReport extends Model {
	/** !Column PrimaryKey, Integer, AutoIncrement */
	public $id;
	
	/** !Column String */
	public $uid;

	/** !Column String */
	public $title;

	/** !Column Text */
	public $description;
	
	/** !Column String */
	public $reply_to;

	/** !Column String */
	public $priority;

}
?>