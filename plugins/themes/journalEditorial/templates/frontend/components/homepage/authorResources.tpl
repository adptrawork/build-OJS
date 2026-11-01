{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/authorResources.tpl
 * Ruled link list — no card boxes.
 *}
<section class="container py-4 mb-5">
	<div class="jilp-section-title-header">
		<div>
			<h2 class="jilp-section-title">{translate key="plugins.themes.journalEditorial.authors.title"}</h2>
			<p class="text-muted mb-0 mt-2">{translate key="plugins.themes.journalEditorial.authors.desc"}</p>
		</div>
	</div>

	<ul class="jilp-link-list">
		<li>
			<a href="{url page="submission"}">
				<i class="bi bi-send jilp-link-icon" aria-hidden="true"></i>
				<span class="jilp-link-body">
					<span class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.submitTitle"}</span>
					<span class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.submitDesc"}</span>
				</span>
				<i class="bi bi-arrow-right jilp-link-arrow" aria-hidden="true"></i>
			</a>
		</li>
		<li>
			<a href="{url page="about" op="submissions"}">
				<i class="bi bi-file-earmark-text jilp-link-icon" aria-hidden="true"></i>
				<span class="jilp-link-body">
					<span class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.guidelinesTitle"}</span>
					<span class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.guidelinesDesc"}</span>
				</span>
				<i class="bi bi-arrow-right jilp-link-arrow" aria-hidden="true"></i>
			</a>
		</li>
		<li>
			<a href="{url page="search"}">
				<i class="bi bi-search jilp-link-icon" aria-hidden="true"></i>
				<span class="jilp-link-body">
					<span class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.searchTitle"}</span>
					<span class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.searchDesc"}</span>
				</span>
				<i class="bi bi-arrow-right jilp-link-arrow" aria-hidden="true"></i>
			</a>
		</li>
		<li>
			<a href="{url page="issue" op="archive"}">
				<i class="bi bi-journals jilp-link-icon" aria-hidden="true"></i>
				<span class="jilp-link-body">
					<span class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.archiveTitle"}</span>
					<span class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.archiveDesc"}</span>
				</span>
				<i class="bi bi-arrow-right jilp-link-arrow" aria-hidden="true"></i>
			</a>
		</li>
		<li>
			<a href="{url page="about" op="privacy"}">
				<i class="bi bi-shield-check jilp-link-icon" aria-hidden="true"></i>
				<span class="jilp-link-body">
					<span class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.privacyTitle"}</span>
					<span class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.privacyDesc"}</span>
				</span>
				<i class="bi bi-arrow-right jilp-link-arrow" aria-hidden="true"></i>
			</a>
		</li>
		<li>
			<a href="{url page="about" op="editorialMasthead"}">
				<i class="bi bi-people jilp-link-icon" aria-hidden="true"></i>
				<span class="jilp-link-body">
					<span class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.teamTitle"}</span>
					<span class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.teamDesc"}</span>
				</span>
				<i class="bi bi-arrow-right jilp-link-arrow" aria-hidden="true"></i>
			</a>
		</li>
	</ul>
</section>
