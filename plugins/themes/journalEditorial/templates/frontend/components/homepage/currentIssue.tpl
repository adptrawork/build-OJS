{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/currentIssue.tpl
 *
 * Current issue hero card with uploadable cover image slot.
 * @uses $issue Issue|null
 *}
{if $issue}
	{assign var="currentIssueCover" value=$issue->getLocalizedCoverImageUrl()}
	{assign var="currentIssueTitle" value=$issue->getIssueIdentification()}
	{assign var="currentIssueUrl" value=$issue->getBestIssueId()}

<section class="container py-4 mb-5" id="current-issue-section">
	<div class="jilp-current-issue">
		<div class="jilp-current-issue-cover">
			<a href="{url page="issue" op="view" path=$currentIssueUrl}" aria-label="{$currentIssueTitle|escape}">
				{if $currentIssueCover}
					<img src="{$currentIssueCover|escape}" alt="{$currentIssueTitle|escape}" loading="lazy" />
				{else}
					<div class="jilp-current-issue-cover-fallback">
						<i class="bi bi-journal-bookmark-fill" aria-hidden="true"></i>
						<span>{translate key="plugins.themes.journalEditorial.currentIssue.uploadCover"}</span>
					</div>
				{/if}
			</a>
		</div>
		<div class="jilp-current-issue-body">
			<span class="jilp-current-issue-eyebrow">{translate key="plugins.themes.journalEditorial.currentIssue.eyebrow"}</span>
			<h2 class="jilp-current-issue-title">
				<a href="{url page="issue" op="view" path=$currentIssueUrl}">{$currentIssueTitle|escape}</a>
			</h2>
			{if $issue->getDatePublished()}
				<p class="jilp-current-issue-date">{$issue->getDatePublished()|date_format:$dateFormatShort}</p>
			{/if}
			{if $issue->getLocalizedDescription()}
				<div class="jilp-current-issue-desc">{$issue->getLocalizedDescription()|strip_unsafe_html}</div>
			{/if}
			<div class="jilp-current-issue-actions">
				<a class="btn jilp-btn-hero-primary text-decoration-none px-4 py-2" href="{url page="issue" op="view" path=$currentIssueUrl}">
					{translate key="plugins.themes.journalEditorial.currentIssue.viewIssue"} <i class="bi bi-arrow-right ms-1" aria-hidden="true"></i>
				</a>
				<a class="btn btn-outline-light text-decoration-none px-4 py-2" href="{url page="issue" op="archive"}">
					{translate key="plugins.themes.journalEditorial.currentIssue.archive"}
				</a>
			</div>
		</div>
	</div>
</section>
{/if}
