{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/issueCard.tpl
 *
 * @uses $issue object
 *}
<article class="jilp-issue-card h-100">
	{if $issue->cover}
		<a class="jilp-issue-cover" href="{url page="issue" op="view" path=$issue->id}">
			<img src="{$issue->cover}" alt="{$issue->title|escape}" loading="lazy" />
		</a>
	{/if}
	<div class="jilp-issue-body">
		<h3 class="jilp-issue-title">
			<a href="{url page="issue" op="view" path=$issue->id}">{$issue->title|escape}</a>
		</h3>
		{if $issue->date}
			<p class="jilp-issue-date"><i class="bi bi-calendar3 me-1"></i> {$issue->date|date_format:$dateFormatShort}</p>
		{/if}
		<a class="btn btn-outline-primary rounded-pill px-4 fw-bold mt-auto" href="{url page="issue" op="view" path=$issue->id}">
			View Issue <i class="bi bi-arrow-right ms-1"></i>
		</a>
	</div>
</article>
