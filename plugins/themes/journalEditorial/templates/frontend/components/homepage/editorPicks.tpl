{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/editorPicks.tpl
 *}
{if $jilpArticles && $jilpArticles|@count > 0}
<section class="container py-4 mb-5" id="current-issue-section">
	<div class="jilp-section-title-header">
		<div>
			<h2 class="jilp-section-title">{translate key="plugins.themes.journalEditorial.picks.title"}</h2>
			<p class="text-muted mb-0 mt-2">{translate key="plugins.themes.journalEditorial.picks.desc"}</p>
		</div>
		<a class="btn btn-outline-primary rounded-pill px-4 fw-bold" href="{url page="issue" op="archive"}">
			{translate key="plugins.themes.journalEditorial.picks.viewAll"} <i class="bi bi-arrow-right ms-1"></i>
		</a>
	</div>

	<div class="jilp-picks">
		{foreach from=$jilpArticles item=article name=picks}
			{if $smarty.foreach.picks.index < 4}
				{assign var="pickIndex" value=$smarty.foreach.picks.index}
				<a class="jilp-pick jilp-highlight-card" href="{url page="article" op="view" path=$article->id}">
					<span class="jilp-highlight-watermark">{$jilpLetters[$pickIndex]|default:$jilpAcronym|substr:0:1}</span>
					<span class="jilp-highlight-tag">
						{if $pickIndex == 0}{translate key="plugins.themes.journalEditorial.picks.tag1"}
						{elseif $pickIndex == 1}{translate key="plugins.themes.journalEditorial.picks.tag2"}
						{elseif $pickIndex == 2}{translate key="plugins.themes.journalEditorial.picks.tag3"}
						{else}{translate key="plugins.themes.journalEditorial.picks.tag4"}{/if}
					</span>
					<h3 class="jilp-highlight-title">{$article->title|escape}</h3>
					{if $pickIndex == 0 && $article->abstract}
						<p class="jilp-highlight-abstract">{$article->abstract|strip_tags|truncate:230|escape}</p>
					{/if}
					<div class="jilp-highlight-meta">
						<span class="text-truncate" style="max-width:150px;">
							<i class="bi bi-person-fill me-1"></i> {$article->authors|escape}
						</span>
						<span class="badge bg-white text-dark rounded-pill px-3 py-1 fw-bold">PDF</span>
					</div>
				</a>
			{/if}
		{/foreach}
	</div>
</section>
{/if}
