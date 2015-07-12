<?php
Layout::extend('layouts/master');
Layout::input($title, 'string');
Layout::input($body, 'Block');

$title .= 'User - ';
$breadcrumbs = array();

$navigation = Part::block('parts/navigation');
?>