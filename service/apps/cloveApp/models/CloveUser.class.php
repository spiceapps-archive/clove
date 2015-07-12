<?php

//NOTE: this is ONLY a wrapper class to connect belongs to / has many relationships with
//models

Library::import('auth.models.User');

/**
 * !Database Default
 * !Table users
 * !HasMany screens, Key: screen
 * !hasMany scenes, Key: scene
 * !HasMany plugins, Key: user
 */
class CloveUser extends User{}


?>