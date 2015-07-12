<?php

Layout::extend("layouts/master");
$title = "Not Logged In";
$statusCode = 1;
$statusMessage = 'You must be <a href="'.PluginUtil::urlTo('AuthApplication::UserController::login').'">logged in</a> to view this page.';

Library::import("spice.library.recess.utils.PluginUtil");


?>

