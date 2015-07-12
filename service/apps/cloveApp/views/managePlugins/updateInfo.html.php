<?php 

Layout::extend("layouts/master");

$title = "Plugins";
$breadcrumbs = array(array("name"=>"Plugins","link"=>Url::action("PluginController::index")),array("name"=>"Info"));



 ?>
	
<?php $_form->begin(); ?>
<p><strong>Name:</strong>
<input type="text" name="name" id="name" value="<?=$plugin->name; ?>" /></p>

<p><strong>Description:</strong>
<textarea rows="5" cols="40" name="description" id="description"><?=$plugin->description; ?></textarea></p>

<p><strong>Factory Class:</strong>
<input type="text" name="factory" id="version" value="<?=$plugin->factory; ?>" /></p>


<input type="hidden" name="action" value="submit" />
			<p><input type="submit" value="submit" /></p>
<?php $_form->end();?>






