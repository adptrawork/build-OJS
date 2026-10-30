{**
 * @file plugins/themes/akdisi/templates/frontend/components/latestBySection.tpl
 *
 * Grid artikel terbaru dari section-section jurnal (S-HOME-07).
 * Data diisi lewat hook AkdisiThemePlugin::assignHomepageData().
 *}
{if $akdisiLatestArticles && $akdisiLatestArticles|@count}
	<section class="akdisi-latest" data-slot="S-HOME-07" aria-labelledby="akdisi-latest-heading">
		<div class="akdisi-latest__inner">
			<div class="akdisi-latest__header">
				<h2 id="akdisi-latest-heading">Latest Articles</h2>
				<a class="akdisi-link" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}">
					{translate key="journal.viewAllIssues"}
				</a>
			</div>
			<div class="akdisi-latest__grid">
				{foreach from=$akdisiLatestArticles item=a}
					<article class="akdisi-card">
						{if $a->section}
							<span class="akdisi-card__section">{$a->section|escape}</span>
						{/if}
						<h3 class="akdisi-card__title">
							<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="article" op="view" path=$a->id}">
								{$a->title|escape}
							</a>
						</h3>
						{if $a->authors}
							<p class="akdisi-card__authors">{$a->authors|escape}</p>
						{/if}
						{if $a->date}
							<time class="akdisi-card__date" datetime="{$a->date|escape}">{$a->date|date_format:"%d %B %Y"}</time>
						{/if}
					</article>
				{/foreach}
			</div>
		</div>
	</section>
{else}
	{* Empty state: ditampilkan agar user tahu section ini aktif tapi belum ada data *}
	<section class="akdisi-latest akdisi-latest--empty" data-slot="S-HOME-07" aria-labelledby="akdisi-latest-heading">
		<div class="akdisi-latest__inner">
			<h2 id="akdisi-latest-heading">Latest Articles</h2>
			<p>No published articles yet.</p>
		</div>
	</section>
{/if}
