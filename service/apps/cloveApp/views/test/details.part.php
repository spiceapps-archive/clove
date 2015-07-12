<?php
Part::input($test, 'Test');
?>
<form method="POST" action="<?php echo Url::action('TestController::delete', $test->id) ?>">
	<fieldset>
	<h3><?php echo Html::anchor(Url::action('TestController::details', $test->id), 'Test #' . $test->id) ?></h3>
	<p>
		<strong>Name</strong>: <?php echo $test->name; ?><br />
		<strong>Last</strong>: <?php echo $test->last; ?><br />
		<strong>Email</strong>: <?php echo $test->email; ?><br />

	</p>
	<?php echo Html::anchor(Url::action('TestController::editForm', $test->id), 'Edit') ?> - 
	<input type="hidden" name="_METHOD" value="DELETE" />
	<input type="submit" name="delete" value="Delete" />
	</fieldset>
</form>