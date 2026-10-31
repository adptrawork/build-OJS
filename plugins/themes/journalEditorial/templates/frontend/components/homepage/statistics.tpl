{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/statistics.tpl
 *}
{if $jeStats && ($jeStats->articles > 0 || $jeStats->issues > 0)}
<section class="je-stats" aria-label="Journal statistics">
	<div class="je-container">
		<div class="je-stats__grid">
			<div class="je-stats__item">
				<strong>{$jeStats->articles}</strong>
				<span>Published Articles</span>
			</div>
			<div class="je-stats__item">
				<strong>{$jeStats->issues}</strong>
				<span>Issues</span>
			</div>
		</div>
	</div>
</section>
{/if}
