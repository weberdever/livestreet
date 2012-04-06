{assign var="noSidebar" value=true}
{include file='header.tpl' menu='settings'}


<form method="post" enctype="multipart/form-data">
	{hook run='form_settings_account_begin'}

	<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}">
	
	
	<fieldset>
		<legend>{$aLang.settings_account}</legend>
		
		<p>
			<label for="mail">{$aLang.settings_profile_mail}:</label>
			<input type="email" name="mail" id="mail" value="{$oUserCurrent->getMail()|escape:'html'}" class="input-text input-width-300" required>
			<small class="note">{$aLang.settings_profile_mail_notice}</small>
		</p>

	</fieldset>
		
	<fieldset>
		<legend>{$aLang.settings_account_password}</legend>
		
		<small class="note note-header">{$aLang.settings_account_password_notice}</small>
			
		<p><label for="password_now">{$aLang.settings_profile_password_current}:</label>
		<input type="password" name="password_now" id="password_now" value="" class="input-text input-width-200" /></p>
		
		<p><label for="password">{$aLang.settings_profile_password_new}:</label>
		<input type="password" id="password" name="password" value="" class="input-text input-width-200" /></p>
			
		<p><label for="password_confirm">{$aLang.settings_profile_password_confirm}:</label>
		<input type="password" id="password_confirm" name="password_confirm" value="" class="input-text input-width-200" /></p>
	</fieldset>
	
	{hook run='form_settings_account_end'}
	
	
	<button name="submit_account_edit" class="button button-primary" />{$aLang.settings_account_submit}</button>
</form>








{include file='footer.tpl'}