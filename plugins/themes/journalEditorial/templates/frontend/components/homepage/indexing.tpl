{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/indexing.tpl
 *}
{if $jeIndexers}
<section class="je-section" aria-labelledby="je-indexing-title">
	<div class="je-container">
		<h2 id="je-indexing-title" class="je-section__title">Indexing &amp; Abstracting</h2>
		<div class="je-indexing">
			{$jeIndexers|strip_unsafe_html}
		</div>
	</div>
</section>
{/if}
