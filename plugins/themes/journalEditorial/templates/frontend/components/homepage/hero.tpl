{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/hero.tpl
 *
 * @uses $issue Issue Current issue (may be empty)
 * @uses $homepageImage array|null Journal homepage image
 *}
{assign var="heroCover" value=""}
{assign var="heroCoverTitle" value=""}
{if $issue && $issue->getLocalizedCoverImageUrl()}
	{assign var="heroCover" value=$issue->getLocalizedCoverImageUrl()}
	{assign var="heroCoverTitle" value=$issue->getIssueIdentification()}
{elseif $homepageImage}
	{assign var="heroCover" value="$publicFilesDir/$homepageImage.uploadName"}
	{assign var="heroCoverTitle" value=$homepageImage.altText|default:$currentJournal->getLocalizedName()}
{/if}
{assign var="heroLogo" value=""}
{if $displayPageHeaderLogo}
	{assign var="heroLogo" value="$publicFilesDir/$displayPageHeaderLogo.uploadName"}
{/if}

<section class="jilp-hero{if !$homepageImage} jilp-hero--plain{/if}"
	{if $homepageImage}
		style="background-image:linear-gradient(to right, rgba(15,23,42,.95), rgba(15,23,42,.85)), url('{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}');"
	{/if}>
	<div class="container position-relative z-2">
		<div class="row align-items-center gy-5">

			<div class="col-lg-7">
				<p class="jilp-hero-eyebrow">{translate key="plugins.themes.journalEditorial.hero.eyebrow"}</p>
				<h1 class="jilp-hero-title mb-4">
					{$currentJournal->getLocalizedName()|escape}
				</h1>

				<div class="jilp-hero-desc-card mb-4">
					<div class="row g-2 mb-4 justify-content-start">
						<div class="col-6 col-md-auto">
							<div class="jilp-hero-badge jilp-hero-badge--primary">
								<i class="bi bi-shield-check mb-1"></i>
								<span class="fw-bold">{translate key="plugins.themes.journalEditorial.hero.openAccess"}</span>
							</div>
						</div>
						<div class="col-6 col-md-auto">
							<div class="jilp-hero-badge">
								<i class="bi bi-check-circle mb-1"></i>
								<span class="fw-bold">{translate key="plugins.themes.journalEditorial.hero.peerReviewed"}</span>
							</div>
						</div>
						{if $currentJournal->getData('onlineIssn')}
							<div class="col-6 col-md-auto">
								<div class="jilp-hero-badge">
									<span class="jilp-hero-badge-label">e-ISSN</span>
									<span class="fw-bold">{$currentJournal->getData('onlineIssn')|escape}</span>
								</div>
							</div>
						{/if}
						{if $currentJournal->getData('issn')}
							<div class="col-6 col-md-auto">
								<div class="jilp-hero-badge">
									<span class="jilp-hero-badge-label">p-ISSN</span>
									<span class="fw-bold">{$currentJournal->getData('issn')|escape}</span>
								</div>
							</div>
						{/if}
					</div>

					<div class="jilp-hero-description text-white-50 mb-0">
						{if $currentJournal->getLocalizedDescription()}
							{$currentJournal->getLocalizedDescription()|strip_tags|truncate:420|escape}
							<a class="jilp-hero-readmore" href="{url page="about"}" aria-label="About the journal: {$currentJournal->getLocalizedName()|escape}">About the journal <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
						{else}
							{translate key="plugins.themes.journalEditorial.hero.fallbackDesc" journalName=$currentJournal->getLocalizedName()|escape}
						{/if}
					</div>
				</div>

				<div class="d-flex flex-wrap justify-content-start gap-3 mb-0">
					<a class="btn jilp-btn-hero-primary text-decoration-none px-4 py-3" href="{url page="submission"}">
						<i class="bi bi-send-fill me-2"></i> {translate key="plugins.themes.journalEditorial.hero.submit"}
					</a>
					<a class="btn jilp-btn-hero-glass text-decoration-none px-4 py-3" href="#current-issue-section">
						<i class="bi bi-compass me-2"></i> {translate key="plugins.themes.journalEditorial.hero.exploreIssue"}
					</a>
				</div>
			</div>

			<div class="col-lg-5 d-none d-lg-block">
				<div class="jilp-hero-visual" aria-hidden="true">
					<div class="jilp-cover-stack">
						{if $heroCover}
							<img class="jilp-cover jilp-cover-1" src="{$heroCover|escape:"url"}" alt="" loading="eager" />
						{/if}
						{if $heroLogo}
							<img class="jilp-cover jilp-cover-2" src="{$heroLogo|escape:"url"}" alt="" loading="eager" />
						{elseif $heroCover}
							<div class="jilp-cover jilp-cover-2 jilp-cover-fallback"><i class="bi bi-journal-bookmark-fill"></i></div>
						{/if}
						{if $heroCover}
							<div class="jilp-cover jilp-cover-3 jilp-cover-fallback"><i class="bi bi-book"></i></div>
						{elseif $heroLogo}
							<div class="jilp-cover jilp-cover-3 jilp-cover-fallback"><i class="bi bi-journal-bookmark-fill"></i></div>
						{/if}
					</div>
					<div class="jilp-hero-chip jilp-hero-chip-a"><i class="bi bi-unlock-fill"></i> {translate key="plugins.themes.journalEditorial.hero.openAccess"}</div>
					<div class="jilp-hero-chip jilp-hero-chip-b"><i class="bi bi-people-fill"></i> {translate key="plugins.themes.journalEditorial.hero.peerReviewed"}</div>
				</div>
			</div>
		</div>
	</div>
</section>
