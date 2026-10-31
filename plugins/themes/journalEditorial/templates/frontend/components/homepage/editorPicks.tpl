{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/editorPicks.tpl
 *}
{if $jilpArticles && $jilpArticles|@count > 0}
<section class="container py-4 mb-5" id="current-issue-section">
	<div class="jilp-section-title-header">
		<div>
			<h2 class="jilp-section-title">Editor's Pick</h2>
			<p class="text-muted mb-0 mt-2">Hand-picked groundbreaking research and high-impact publications curated by our Editorial Board</p>
		</div>
		<a class="btn btn-outline-primary rounded-pill px-4 fw-bold" href="{url page="issue" op="archive"}">
			View All Issues <i class="bi bi-arrow-right ms-1"></i>
		</a>
	</div>

	<div class="row g-4">
		{foreach from=$jilpArticles item=article name=picks}
			{if $smarty.foreach.picks.index < 4}
				{assign var="pickIndex" value=$smarty.foreach.picks.index}
				<div class="col-md-6 col-lg-3">
					<a class="jilp-highlight-card jilp-highlight-card-{$pickIndex+1}" href="{url page="article" op="view" path=$article->id}">
						<span class="jilp-highlight-watermark">{$jilpLetters[$pickIndex]|default:$jilpAcronym|substr:0:1}</span>
						<span class="jilp-highlight-tag">
							{if $pickIndex == 0}# Editor's Choice
							{elseif $pickIndex == 1}# Featured Article
							{elseif $pickIndex == 2}# Top Cited
							{else}# Recommended{/if}
						</span>
						<h3 class="jilp-highlight-title">{$article->title|escape}</h3>
						<div class="jilp-highlight-meta">
							<span class="text-truncate" style="max-width:150px;">
								<i class="bi bi-person-fill me-1"></i> {$article->authors|escape}
							</span>
							<span class="badge bg-white text-dark rounded-pill px-3 py-1 fw-bold">PDF</span>
						</div>
					</a>
				</div>
			{/if}
		{/foreach}
	</div>
</section>
{/if}
