{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/editorPicks.tpl
 *}
{if $jeLatestArticles && count($jeLatestArticles) > 0}
<section class="je-section" aria-labelledby="je-picks-title">
	<div class="je-container">
		<h2 id="je-picks-title" class="je-section__title">Editor's Pick</h2>
		<div class="je-cards">
			{foreach from=$jeLatestArticles item=article name=picks}
				{if $smarty.foreach.picks.index < 4}
				<article class="je-card">
					<h3 class="je-card__title">
						<a href="{url page="article" op="view" path=$article->id}">{$article->title|escape}</a>
					</h3>
					<div class="je-card__meta">{$article->authors|escape}</div>
					{if $article->abstract}
						<p class="je-card__abstract">{$article->abstract|strip_tags|truncate:180|escape}</p>
					{/if}
				</article>
				{/if}
			{/foreach}
		</div>
	</div>
</section>
{/if}
