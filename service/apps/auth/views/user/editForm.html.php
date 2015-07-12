<?php 
Layout::extend('layouts/user');
if(isset($user->id)) {
	$title = 'Edit User #' . $user->id;
} else {
	$title = 'Create New User';
}
$title = $title;
$breadcrumbs = array();
?>

<?php Part::draw('user/form', $_form, $title,$statusMessage,(string)$statusCode) ?>

<?php echo Html::anchor(Url::action('UserController::index'), 'User List') ?>