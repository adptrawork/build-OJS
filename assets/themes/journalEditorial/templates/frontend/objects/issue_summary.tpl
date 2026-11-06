{**
 * @file plugins/themes/journalEditorial/templates/frontend/objects/issue_summary.tpl
 *
 * Issue card for the archive / issue lists (JILP-style cover card).
 *
 * @uses $issue Issue The issue
 *}
{if $issue->getShowTitle()}
	{assign var=issueTitle value=$issue->getLocalizedTitle()}
{/if}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
{assign var=issueUrl value=$issue->getBestIssueId()}

<article class="jilp-issue-summary">
	<a class="cover" href="{url op="view" path=$issueUrl}">
		{if $issueCover}
			<img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}">
		{else}
			<span class="cover-fallback"><i class="bi bi-journal-bookmark"></i></span>
		{/if}
	</a>

	<div class="body">
		<h2>
			<a class="title" href="{url op="view" path=$issueUrl}">
				{if $issueTitle}{$issueTitle|escape}{else}{$issueSeries|escape}{/if}
			</a>
		</h2>

		{if $issueTitle && $issueSeries}
			<div class="series"><i class="bi bi-bookmark me-1"></i>{$issueSeries|escape}</div>
		{/if}

		{if $issue->getDatePublished()}
			<div class="date"><i class="bi bi-calendar3 me-1"></i>{$issue->getDatePublished()|date_format:$dateFormatShort}</div>
		{/if}
	</div>
</article>
