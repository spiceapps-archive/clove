<?php 
Layout::extend('layouts/test');
if(isset($test->id)) {
	$title = 'Edit Test #' . $test->id;
} else {
	$title = 'Create New Test';
}
$title = $title;
?>

<?php Part::draw('test/form', $_form, $title) ?>

<?php echo Html::anchor(Url::action('TestController::index'), 'Test List') ?>