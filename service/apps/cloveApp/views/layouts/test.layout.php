<?php
Layout::extend('layouts/master');
Layout::input($title, 'string');
Layout::input($body, 'Block');

$title .= 'Test - ';

$navigation = Part::block('parts/navigation');
?>