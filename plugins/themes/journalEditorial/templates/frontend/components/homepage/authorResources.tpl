{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/authorResources.tpl
 *}
<section class="container py-4 mb-5">
	<div class="jilp-section-title-header">
		<div>
			<h2 class="jilp-section-title">{translate key="plugins.themes.journalEditorial.authors.title"}</h2>
			<p class="text-muted mb-0 mt-2">{translate key="plugins.themes.journalEditorial.authors.desc"}</p>
		</div>
	</div>

	<div class="row g-4">
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="submission" op="submit"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-send-fill"></i></div>
				<h3 class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.submitTitle"}</h3>
				<p class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.submitDesc"}</p>
			</a>
		</div>
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="about" op="editorialTeam"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-people-fill"></i></div>
				<h3 class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.teamTitle"}</h3>
				<p class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.teamDesc"}</p>
			</a>
		</div>
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="about" op="submissions"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-file-earmark-richtext"></i></div>
				<h3 class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.guidelinesTitle"}</h3>
				<p class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.guidelinesDesc"}</p>
			</a>
		</div>
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="search"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-search"></i></div>
				<h3 class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.searchTitle"}</h3>
				<p class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.searchDesc"}</p>
			</a>
		</div>
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="issue" op="archive"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-collection-fill"></i></div>
				<h3 class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.archiveTitle"}</h3>
				<p class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.archiveDesc"}</p>
			</a>
		</div>
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="about" op="privacy"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-shield-lock-fill"></i></div>
				<h3 class="jilp-quick-link-title">{translate key="plugins.themes.journalEditorial.authors.privacyTitle"}</h3>
				<p class="jilp-quick-link-desc">{translate key="plugins.themes.journalEditorial.authors.privacyDesc"}</p>
			</a>
		</div>
	</div>
</section>
