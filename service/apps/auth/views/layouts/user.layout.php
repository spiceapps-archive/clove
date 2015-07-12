<?php
Layout::input($breadcrumbs, 'array');
Layout::extend('layouts/master');
Layout::input($title, 'string');
Layout::input($body, 'Block');

$title .= '';

$navigation = Part::block('parts/navigation');
?>