{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/authorResources.tpl
 *}
<section class="container py-4 mb-5">
	<div class="jilp-section-title-header">
		<div>
			<h2 class="jilp-section-title">For Authors &amp; Researchers</h2>
			<p class="text-muted mb-0 mt-2">Everything you need to prepare, submit, and publish your research.</p>
		</div>
	</div>

	<div class="row g-4">
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="submission" op="submit"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-send-fill"></i></div>
				<h3 class="jilp-quick-link-title">Submit Your Research</h3>
				<p class="jilp-quick-link-desc">Start a new submission and join our community of scholars.</p>
			</a>
		</div>
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="about" op="editorialTeam"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-people-fill"></i></div>
				<h3 class="jilp-quick-link-title">Editorial Team</h3>
				<p class="jilp-quick-link-desc">Meet the editors and reviewers guiding the journal.</p>
			</a>
		</div>
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="about" op="submissions"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-file-earmark-richtext"></i></div>
				<h3 class="jilp-quick-link-title">Author Guidelines</h3>
				<p class="jilp-quick-link-desc">Read the formatting, scope, and submission requirements.</p>
			</a>
		</div>
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="search"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-search"></i></div>
				<h3 class="jilp-quick-link-title">Search Articles</h3>
				<p class="jilp-quick-link-desc">Find research by title, author, keyword, or DOI.</p>
			</a>
		</div>
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="issue" op="archive"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-collection-fill"></i></div>
				<h3 class="jilp-quick-link-title">Explore Archives</h3>
				<p class="jilp-quick-link-desc">Browse every published issue and article.</p>
			</a>
		</div>
		<div class="col-lg-4 col-md-6">
			<a class="jilp-quick-link-card h-100" href="{url page="about" op="privacy"}">
				<div class="jilp-quick-link-icon"><i class="bi bi-shield-lock-fill"></i></div>
				<h3 class="jilp-quick-link-title">Privacy Statement</h3>
				<p class="jilp-quick-link-desc">Learn how we protect author and reader data.</p>
			</a>
		</div>
	</div>
</section>
