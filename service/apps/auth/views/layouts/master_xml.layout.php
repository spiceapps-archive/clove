<?php

Layout::input($statusCode, 'int');
Layout::input($statusMessage, 'string');
Layout::input($body, 'Block');

echo '<?xml version="1.0" encoding="UTF-8"?>';
?>

<response>
	<status>
		<code><?=$statusCode; ?></code>
		<message><?=$statusMessage; ?></message>
	</status>
	<?=$body; ?>
</response>
