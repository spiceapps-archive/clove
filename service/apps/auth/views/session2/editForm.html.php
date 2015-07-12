
<script src="<?=$response->meta->app->contentUrl?>js/jquery.validate.min.js" type="text/javascript"></script>

<h1>Sign In...</h1>

<?php if(isset($flash)) { ?>
	<div class="flash error span-8"><?php echo $flash; ?></div>
<?php } ?>
<div class="span-7 prepend-1 clear" id="signin">
<?php $_form->begin(); ?>
	<fieldset>
		<div class="field">
			<label for="user[login]">Username</label>
			<input type="text" class="text" id="user[login]" name="user[login]" value="<?php echo $user->login; ?>" />
		</div>
		<div class="field">
			<label for="user[password]">Password</label>
			<input type="password" class="text password" id="user[password]" name="user[password]"/>
		</div>
	</fieldset>
	<fieldset class="submit">
		<div class="field">
			<input type="submit" class="submit" value="Sign In" />
		</div>
	</fieldset>
<?php $_form->end(); ?>
</div>
<script type="text/javascript">

	// Autofocus Username Field
	$("input[name=user[login]]").focus();
	
	// Validation
	$().ready(function() {
		$("#signin form").validate({
			rules: {
				'user[login]': {
					required: true,
					minlength: 3
				},
				'user[password]': {
					required: true,
					minlength: 6
				}
			},
			messages: {
				'user[login]': {
					required: "Please enter a Username",
					minlength: "Please enter a Username"
				},
				'user[password]': {
					required: "Please enter your Password",
					minlength: "Please enter your Password"
				}
			}
		});
	});
	
</script>

<?php include_once($response->meta->app->commonViewsDir . 'common/footer.php'); ?>