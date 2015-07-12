<?php 

Layout::extend("layouts/master");

$title = "Plugins";
$breadcrumbs = array(array("name"=>"Plugins","link"=>Url::action("PluginController::index")),array("name"=>"Update"));

$_form->enctype="multipart/form-data";
 ?>
	
<?php $_form->begin(); ?>

<p><strong>Version:</strong>
<input type="text" name="version" id="version" value="<?=@$currentVersion->version; ?>" /></p>

<p><strong>Version Description:</strong>
<textarea rows="5" cols="40" name="update_info" id="update_info"><?=@$currentVersion->update_info; ?></textarea></p>

<p><strong>Plugin Archive Zip:</strong><br />
<p>Note: Please do not obfuscate any included libraries. We check every submitted plugin to make sure they're safe.</p>
<input type="file" name="pluginFile" /></p>

			<p><input type="submit" value="submit" /></p>
<?php $_form->end();?>






