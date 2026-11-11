{**
 * Child theme override: Issue table of contents (Bootstrap 5.3.3 layout).
 *
 * @uses $issue Issue The issue
 * @uses $issueTitle string Title of the issue. May be empty
 * @uses $issueSeries string Vol/No/Year string for the issue
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $publishedSubmissions array Lists of articles published in this issue
 *   sorted by section.
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $heading string HTML heading element, default: h2
 *}
{if !$heading}
	{assign var="heading" value="h2"}
{/if}
{assign var="articleHeading" value="h3"}
{if $heading == "h3"}
	{assign var="articleHeading" value="h4"}
{elseif $heading == "h4"}
	{assign var="articleHeading" value="h5"}
{elseif $heading == "h5"}
	{assign var="articleHeading" value="h6"}
{/if}
<div class="obj_issue_toc">

	{* Indicate if this is only a preview *}
	{if !$issue->getPublished()}
		{include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
	{/if}

	{* Issue introduction area above articles — removed heading row per prototype *}

	{* Full-issue galleys *}
	{if $issueGalleys}
		<div class="galleys mb-4">
			<{$heading} id="issueTocGalleyLabel" class="h5 mb-2">
				{translate key="issue.fullIssue"}
			</{$heading}>
			<ul class="galleys_links list-unstyled d-flex flex-wrap gap-2 mb-0">
				{foreach from=$issueGalleys item=galley}
					<li>
						{include file="frontend/objects/galley_link.tpl" parent=$issue labelledBy="issueTocGalleyLabel" purchaseFee=$currentJournal->getData('purchaseIssueFee') purchaseCurrency=$currentJournal->getData('currency')}
					</li>
				{/foreach}
			</ul>
		</div>
	{/if}

	{* Articles — flat inside the issue card: section header + list, no
	   boxed wrapper (prototype: card > hairline section header > list). *}
	<div class="sections jrdc-toc-sections">
	{foreach name=sections from=$publishedSubmissions item=section}
		{if $section.articles}
		<div class="jrdc-toc-section__header">
			{if $section.title}
				<{$heading} class="jrdc-toc-section__title">
					{$section.title|escape}
				</{$heading}>
			{/if}
			<span class="jrdc-count-chip">
				{$section.articles|@count} Artikel
			</span>
		</div>
		<ul class="cmp_article_list articles jrdc-toc-section__list">
			{foreach from=$section.articles item=article}
				<li>
					{include file="frontend/objects/article_summary.tpl" heading=$articleHeading}
				</li>
			{/foreach}
		</ul>
		{/if}
	{/foreach}
	</div><!-- .sections -->
</div>
