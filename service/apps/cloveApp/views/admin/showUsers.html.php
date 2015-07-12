<?php 

Layout::extend("layouts/master");

$title = "Plugins";
$breadcrumbs = array(array("name"=>"Admin"),array("name"=>"Users page: $currentPage, users: $numUsers"));




 ?>

<?php $_form->begin(); ?>

<p><strong>Filter:</strong>
<input type="text" name="filter" id="version" value="<?=$filter; ?>" /></p>

<?php $_form->end(); ?>


<?php for($i = 0; $i < $numPages; $i++): ?>
	<?php if($i == $currentPage): ?>
		<?=$i; ?>
	<?php else: ?>
	<a href="<?=Url::action('AdminController::showUsers');?>?page=<?=$i;?>&show=<?=$showPages; ?><?=$filter?'&filter='.$filter:'';?>"><?=$i ?></a>
	<?php endif; ?>
<?php endfor; ?>

<BR />




<?php

foreach($userSet as $user)
{
	Part::draw("admin/userListItem",$user);
}

?>