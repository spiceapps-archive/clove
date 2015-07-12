<?php 
Layout::extend('layouts/user');
if(isset($user->id)) {
	$title = 'Edit User #' . $user->id;
} else {
	$title = 'Create New User';
}
$title = $title;
$breadcrumbs = array(array("name"=>"Home","link"=>"/"),array("name"=>"Create An Account"));

?>

<?php Part::draw('user/form', $_form, $title,$statusMessage,(string)$statusCode) ?>

