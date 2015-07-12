<?php
Part::input($session, 'Session');
?>
<form method="POST" action="<?php echo Url::action('SessionController::delete', $session->id) ?>">
	<fieldset>
	<h3><?php echo Html::anchor(Url::action('SessionController::details', $session->id), 'Session #' . $session->id) ?></h3>
	<p>
		<strong>User Id</strong>: <?php echo $session->userId; ?><br />
		<strong>Data</strong>: <?php echo $session->data; ?><br />
		<strong>Created At</strong>: <?php echo date(DATE_ISO8601,$session->created_at); ?><br />

	</p>
	<?php echo Html::anchor(Url::action('SessionController::editForm', $session->id), 'Edit') ?> - 
	<input type="hidden" name="_METHOD" value="DELETE" />
	<input type="submit" name="delete" value="Delete" />
	</fieldset>
</form>