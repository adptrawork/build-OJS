{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/currentIssue.tpl
 *}
<section class="je-section" aria-labelledby="je-issue-title">
	<div class="je-container">
		<h2 id="je-issue-title" class="je-section__title">Current Issue</h2>
		{if $issue}
		<div class="je-current-issue">
			<div class="je-cover">
				{if $issue->getLocalizedCoverImageUrl()}
					<img src="{$issue->getLocalizedCoverImageUrl()}" alt="{$issue->getIssueIdentification()|escape}">
				{/if}
			</div>
			<div>
				<h3 class="je-issue__title">{$issue->getIssueIdentification()|escape}</h3>
				{if $issue->getDatePublished()}
					<p style="color:var(--je-muted);font-size:0.9rem;">Published: {$issue->getDatePublished()|date_format:"%Y-%m-%d"}</p>
				{/if}
				{include file="frontend/objects/issue_toc.tpl" issue=$issue}
				<div style="margin-top:var(--je-space-4);">
					<a href="{url page="issue" op="view" path=$issue->getId()}" class="je-btn je-btn--primary">View Issue</a>
					<a href="{url page="issue" op="archive"}" class="je-btn je-btn--outline" style="margin-left:var(--je-space-2);">Full Archive</a>
				</div>
			</div>
		</div>
		{else}
		<p style="color:var(--je-muted);">No current issue published yet.</p>
		{/if}
	</div>
</section>
