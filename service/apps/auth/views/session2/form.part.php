<?php
Part::input($form, 'ModelForm');
Part::input($title, 'string');
?>
<?php $form->begin(); ?>
	<fieldset>
		<legend><?php echo $title ?></legend>
		<?php $form->input('id'); ?>		
				<p>
			<label for="<?php echo $form->userId->getName(); ?>">User Id</label><br />
			<?php $form->input('userId'); ?>
		</p>
		<p>
			<label for="<?php echo $form->data->getName(); ?>">Data</label><br />
			<?php $form->input('data'); ?>
		</p>
		<p>
			<label for="<?php echo $form->created_at->getName(); ?>">Created At</label><br />
			<?php $form->input('created_at'); ?>
		</p>

		<input type="submit" value="Save" />
	</fieldset>
<?php $form->end(); ?>