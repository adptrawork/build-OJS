{**
 * Override theme AKDISI. Slot S-ISS-01..03 mengikuti PRD §4.3.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}

<div class="page page_issue" data-slot="S-ISS-01">
	{if !$issue}
		<h1>{translate key="current.noCurrentIssue"}</h1>
		{include file="frontend/components/notification.tpl" type="warning" messageKey="current.noCurrentIssueDesc"}
	{else}
		<div data-slot="S-ISS-03">
			{include file="frontend/objects/issue_toc.tpl"}
		</div>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
