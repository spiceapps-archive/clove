<?php
Library::import('cloveApp.helpers.AccountPrivs');

Part::input($user,'User');

?>

<?=$user->fullName; ?> &nbsp; 
<?=$user->email; ?> 
<a href="<?=Url::action('AdminController::editUser',$user->id); ?>">edit</a> 
<?=date("M j, Y",$user->last_login); ?> <?=$user->permissions & AccountPrivs::ADMIN ? 'admin' : ''?>  
<BR />