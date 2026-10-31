{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/authorResources.tpl
 *}
<section class="je-section" aria-labelledby="je-author-title">
	<div class="je-container">
		<h2 id="je-author-title" class="je-section__title">For Authors</h2>
		<div style="display:flex;flex-wrap:wrap;gap:var(--je-space-3);">
			<a href="{url page="submission" op="submit"}" class="je-btn je-btn--primary">Submit Manuscript</a>
			<a href="{url page="about" op="submissions"}" class="je-btn je-btn--outline">Author Guidelines</a>
			<a href="{url page="about" op="editorialTeam"}" class="je-btn je-btn--outline">Editorial Board</a>
		</div>
	</div>
</section>
