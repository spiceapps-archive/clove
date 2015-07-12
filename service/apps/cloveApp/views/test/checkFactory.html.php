<?php 
Layout::extend('layouts/test');
$title = 'Index';
?>

<h3><?php echo Html::anchor(Url::action('TestController::newForm'), 'Create New Test') ?></h3>

<?php if(isset($flash)): ?>
	<div class="error">
	<?php echo $flash; ?>
	</div>
<?php endif; ?>

<?php foreach($testSet as $test): ?>
	<?php Part::draw('test/details', $test) ?>
	<hr />
<?php endforeach; ?>