{**
 * Child theme override: Issue landing page.
 * Same Bootstrap 5 card skin as the homepage "Terbitan Jurnal Terbaru"
 * card (section.card.jrdc-card-section.jrdc-issue) so both pages render
 * the table of contents identically.
 *
 * @uses $issue Issue The issue
 * @uses $issueIdentification string Label for this issue, consisting of one or
 *       more of the volume, number, year and title, depending on settings
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $primaryGenreIds array List of file genre IDs for primary types
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}

<div class="page page_issue">

	{* Display a message if no current issue exists *}
	{if !$issue}
		{include file="frontend/components/breadcrumbs_issue.tpl" currentTitleKey="current.noCurrentIssue"}
		<h1>
			{translate key="current.noCurrentIssue"}
		</h1>
		{include file="frontend/components/notification.tpl" type="warning" messageKey="current.noCurrentIssueDesc"}

	{* Display an issue with the Table of Contents *}
	{else}
		{include file="frontend/components/breadcrumbs_issue.tpl" currentTitle=$issueIdentification}

		<section class="card jrdc-card-section jrdc-issue" aria-labelledby="issueTitle">
			<div class="card-header jrdc-card-header jrdc-issue__header">
				<h1 id="issueTitle" class="jrdc-card-title">
					{$issueIdentification|escape}
				</h1>
			</div>

			<div class="jrdc-issue__toc">
				{include file="frontend/objects/issue_toc.tpl"}
			</div>
		</section>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
