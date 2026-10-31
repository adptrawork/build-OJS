{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/latestArticles.tpl
 *}
{if $jeLatestArticles && count($jeLatestArticles) > 0}
<section class="je-section" aria-labelledby="je-latest-title">
	<div class="je-container">
		<h2 id="je-latest-title" class="je-section__title">Latest Articles</h2>
		<div class="je-cards">
			{foreach from=$jeLatestArticles item=article}
			<article class="je-card">
				<h3 class="je-card__title">
					<a href="{url page="article" op="view" path=$article->id}">{$article->title|escape}</a>
				</h3>
				<div class="je-card__meta">
					{$article->authors|escape}
					{if $article->date} &middot; {$article->date|date_format:"%Y-%m-%d"}{/if}
				</div>
				{if $article->abstract}
					<p class="je-card__abstract">{$article->abstract|strip_tags|truncate:200|escape}</p>
				{/if}
			</article>
			{/foreach}
		</div>
		<div style="text-align:center;margin-top:var(--je-space-6);">
			<a href="{url page="issue" op="archive"}" class="je-btn je-btn--outline">View All Articles</a>
		</div>
	</div>
</section>
{/if}
