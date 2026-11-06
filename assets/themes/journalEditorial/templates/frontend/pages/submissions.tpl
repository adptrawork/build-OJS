{**
 * templates/frontend/pages/submissions.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2003-2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view information about submissions.
 *}
{capture assign="submissionChecklistAfterContent"}
    {foreach from=$sections item="section"}
        {if $section->getLocalizedPolicy()}
            <div class="section_policy">
                <h2>{$section->getLocalizedTitle()|escape}</h2>
                {$section->getLocalizedPolicy()}
                {if $isUserLoggedIn}
                    {capture assign="sectionSubmissionUrl"}{url page="submission" sectionId=$section->getId()}{/capture}
                    <p>
                        {translate key="about.onlineSubmissions.submitToSection" name=$section->getLocalizedTitle()|escape url=$sectionSubmissionUrl}
                    </p>
                {/if}
            </div>
        {/if}
    {/foreach}
{/capture}

{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

<div class="page page_submissions">

	<div class="cmp_notification">
		{if $sections|@count == 0 || $currentContext->getData('disableSubmissions')}
			{translate key="author.submit.notAccepting"}
		{else}
			{if $isUserLoggedIn}
				{capture assign="newSubmission"}<a href="{url page="submission"}">{translate key="about.onlineSubmissions.newSubmission"}</a>{/capture}
				{capture assign="viewSubmissions"}<a href="{url page="submissions"}">{translate key="about.onlineSubmissions.viewSubmissions"}</a>{/capture}
				{translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}
			{else}
				{capture assign="login"}<a href="{url page="login"}">{translate key="about.onlineSubmissions.login"}</a>{/capture}
				{capture assign="register"}<a href="{url page="user" op="register"}">{translate key="about.onlineSubmissions.register"}</a>{/capture}
				{translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}
			{/if}
		{/if}
	</div>

	{if $currentContext->getLocalizedData('authorGuidelines')}
	<div class="author_guidelines" id="authorGuidelines">
		<h2>
			{translate key="about.authorGuidelines"}
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/instructions" sectionTitleKey="about.authorGuidelines"}
		</h2>
		{$currentContext->getLocalizedData('authorGuidelines')}
	</div>
	{/if}

	{if $submissionChecklist}
		<div class="submission_checklist">
			<h2>
				{translate key="about.submissionPreparationChecklist"}
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/instructions" sectionTitleKey="about.submissionPreparationChecklist"}
			</h2>
			{$submissionChecklist}
		</div>
	{/if}

	{if isset($submissionChecklistAfterContent)}
		{$submissionChecklistAfterContent}
	{/if}

	{if $currentContext->getLocalizedData('copyrightNotice')}
		<div class="copyright_notice">
			<h2>
				{translate key="about.copyrightNotice"}
				{include file="frontend/components/editLink.tpl" page="management" op="settings" path="workflow" anchor="submission/instructions" sectionTitleKey="about.copyrightNotice"}
			</h2>
			{$currentContext->getLocalizedData('copyrightNotice')}
		</div>
	{/if}

	{if $currentContext->getLocalizedData('privacyStatement')}
	<div class="privacy_statement" id="privacyStatement">
		<h2>
			{translate key="about.privacyStatement"}
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="setup/privacy" sectionTitleKey="about.privacyStatement"}
		</h2>
		{$currentContext->getLocalizedData('privacyStatement')}
	</div>
	{/if}

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
