{**
 * templates/frontend/pages/userLostPassword.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2000-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Password reset form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}

<div class="page page_lost_password jilp-auth-split">
	<div class="jilp-auth-brand">
		<a class="jilp-auth-brand__home" href="{url page="index"}">
			{if $displayPageHeaderLogo}
				<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" alt="{$displayPageHeaderLogo.altText|escape|default:$currentJournal->getLocalizedName()|escape}" />
			{else}
				{$currentJournal->getLocalizedName()|escape}
			{/if}
		</a>
		<p class="jilp-auth-brand__tagline">{translate key="plugins.themes.journalEditorial.auth.tagline" journalName=$currentJournal->getLocalizedName()|escape}</p>
	</div>

	<div class="jilp-auth-form">
		<h1>{translate key="user.login.resetPassword"}</h1>
		<p class="jilp-auth-instructions">{translate key="user.login.resetPasswordInstructions"}</p>

		<form class="cmp_form lost_password" id="lostPasswordForm" action="{url page="login" op="requestResetPassword"}" method="post" role="form">
		{csrf}
		{if $error}
			<div class="pkp_form_error" role="alert" tabindex="-1" id="authError">
				{translate key=$error reason=$reason}
			</div>
		{/if}

		<div class="fields">
			<div class="email">
				<label>
					<span class="label">
						{translate key="user.login.registeredEmail"}
						<span class="required" aria-hidden="true">*</span>
						<span class="pkp_screen_reader">
							{translate key="common.required"}
						</span>
					</span>
					<input type="email" name="email" id="email" value="{$email|escape}" required aria-required="true" autocomplete="email">
				</label>
			</div>

			{* altcha spam blocker *}
			{if $altchaEnabled}
				<fieldset class="altcha_wrapper">
					<div class="fields">
						<altcha-widget challengejson='{$altchaChallenge|@json_encode}' floating></altcha-widget>
					</div>
				</fieldset>
			{/if}
			
			<div class="buttons">
				<button class="submit" type="submit">
					{translate key="user.login.resetPassword"}
				</button>

				{if !$disableUserReg}
					{capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
					<a href="{$registerUrl}" class="register">
						{translate key="user.login.registerNewAccount"}
					</a>
				{/if}
			</div>
		</div>

	</form>
	{if $error}{literal}<script>document.addEventListener("DOMContentLoaded",function(){var e=document.getElementById("authError");if(e)e.focus();});</script>{/literal}{/if}
	</div><!-- .jilp-auth-form -->
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
