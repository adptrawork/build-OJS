{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/indexing.tpl
 *}
<section class="jilp-indexing-section" id="indexing">
	<div class="container">
		<div class="text-center mb-4">
			<h2 class="jilp-section-title d-inline-block">{translate key="plugins.themes.journalEditorial.indexing.title"}</h2>
			<p class="text-muted mt-3 mb-0">{translate key="plugins.themes.journalEditorial.indexing.desc"}</p>
		</div>
		<div class="jilp-indexing-grid">
			{foreach from=$jilpIndexers item=indexer}
				<div class="jilp-indexer-badge shadow-sm">{$indexer|escape}</div>
			{/foreach}
		</div>
	</div>
</section>
