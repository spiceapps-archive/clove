<?php 
Layout::extend('layouts/test');
$title = 'Details of Test #' . $test->id ;
?>

<?php Part::draw('test/details', $test) ?>

<?php echo Html::anchor(Url::action('TestController::index'), 'Back to list of tests') ?>
<hr />