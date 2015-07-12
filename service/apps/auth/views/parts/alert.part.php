<?php
Part::input($statusCode, 'string');
Part::input($message, 'string');

if($message != ""):
?>
<div class="<?=$statusCode > 0 ? 'error' : 'tip'; ?>">
			<b>Alert:</b> <?=$message; ?>
		</div>
<?php endif; ?>