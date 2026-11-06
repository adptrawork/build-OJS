{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/indexing.tpl
 *}
<section class="jilp-indexing-section" id="indexing">
	<div class="container">
		<div class="mb-4">
			<h2 class="jilp-section-title">{translate key="plugins.themes.journalEditorial.indexing.title"}</h2>
			<p class="text-muted mt-3 mb-0" style="max-width: 65ch;">{translate key="plugins.themes.journalEditorial.indexing.desc"}</p>
		</div>
		<div class="jilp-indexing-grid">
			{foreach from=$jilpIndexers item=indexer}
				<div class="jilp-indexer-badge">{$indexer|escape}</div>
			{/foreach}
		</div>
	</div>
</section>
