<?php 
Layout::extend('layouts/session');
$title = 'Details of Session #' . $session->id ;
?>

<?php Part::draw('session/details', $session) ?>

<?php echo Html::anchor(Url::action('SessionController::index'), 'Back to list of sessions') ?>
<hr />