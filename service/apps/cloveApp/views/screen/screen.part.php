<?php 

Part::input($screen, 'Screen');

 ?>
 
<screen>
 <id><?=$screen->id; ?></id>
 <type><?=$screen->type; ?></type>
 <created_at><?=$screen->created_at; ?></created_at>
</screen>