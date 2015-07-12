<?php 

Library::import('cloveApp.helpers.AccountPrivs');
Layout::extend("layouts/master");

$title = "Edit User";
$breadcrumbs = array(array("name"=>"Admin","link"=>Url::action("AdminController::index")),array("name"=>"Edit User"));


 ?>




<?php $_form->begin(); ?>
	<p><strong>Admin Privileges:</strong>
	<input type="checkbox" name="admin_privs" id="name" value="admin_privs" <?=$user->permissions & AccountPrivs::ADMIN ? 'checked' : ''; ?> /></p>



				<p><input type="submit" value="update" /></p>
<?php $_form->end();?>
