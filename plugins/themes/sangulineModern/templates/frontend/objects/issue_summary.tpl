{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Child theme override: Issue archive card matching the prototype
 * (archive.html) - compact 3:4 cover row, published date + article count,
 * clamped description, footer with ISSN (when set) and a solid dark
 * "Lihat Edisi" button.
 *
 * @uses $issue Issue The issue
 *}
{if $issue->getShowTitle()}
	{assign var=issueTitle value=$issue->getLocalizedTitle()}
{/if}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
{capture assign="issueUrl"}{url page="issue" op="view" path=$issue->getBestIssueId()}{/capture}

<div class="obj_issue_summary jrdc-issue-card">
	<div class="jrdc-issue-card__main">
		<div class="jrdc-issue-card__row">
			{if $issueCover}
				<a class="cover jrdc-issue-card__cover" href="{$issueUrl}" tabindex="-1" aria-hidden="true">
					<img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}" loading="lazy">
				</a>
			{else}
				<div class="cover jrdc-issue-card__cover" aria-hidden="true"></div>
			{/if}
			<div class="jrdc-issue-card__info">
				<h2 class="title jrdc-issue-card__title">
					<a href="{$issueUrl}">
						{if $issueTitle}
							{$issueTitle|escape}
						{else}
							{$issueSeries|escape}
						{/if}
					</a>
				</h2>
				<span class="count jrdc-issue-card__count">
					{$issue->getNumArticles()} Artikel Ilmiah
				</span>
			</div>
		</div>
		{assign var=issueDescription value=$issue->getLocalizedDescription()}
		{if $issueDescription}
			<p class="description jrdc-issue-card__description">{$issueDescription|strip_unsafe_html}</p>
		{/if}
	</div>
	<div class="jrdc-issue-card__footer">
		{if $currentJournal && $currentJournal->getData('onlineIssn')}
			<span class="issn">ISSN: {$currentJournal->getData('onlineIssn')|escape}</span>
		{/if}
		<a class="jrdc-btn-dark" href="{$issueUrl}">Lihat Edisi</a>
	</div>
</div><!-- .obj_issue_summary -->
