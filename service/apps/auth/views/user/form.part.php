<?php
Part::input($form, 'ModelForm');
Part::input($title, 'string');
Part::input($statusMessage, 'string');
Part::input($statusCode, 'string');
?>
<?php if(isset($statusMessage)): ?>
	<div class="<?=$statusCode ? 'error' : '' ?>">
	<?php echo $statusMessage; ?>
	</div>
<?php endif; ?>

<?php $form->begin(); ?>
	<fieldset>
		<legend><?php echo $title ?></legend>
		<?php $form->input('id'); ?>		
		<p>
			<label for="username">Username</label><br />
			<input type="text" name="username" id="username" value="<?=@$_POST['username']; ?>" />
		</p>
		
		<p>
			<label for="full_name">Full Name</label><br />
			<input type="text" name="name" id="name" value="<?=@$_POST['name']; ?>" />
		</p>
		<p>
			<label for="email">Email</label><br />
			<input type="text" name="email" id="email" value="<?=@$_POST['email']; ?>" />
		</p>
		<p>
			<label for="password">Password</label><br />
			<input type="password" name="password" id="password"/>
		</p>
		
		<p>
			<label for="password">Join Newsletter:</label><br />
			<input type="checkbox" name="subscribe" value="yes" checked="checked" />
		</p>
		

		<input type="submit" value="Save" />
	</fieldset>
<?php $form->end(); ?>