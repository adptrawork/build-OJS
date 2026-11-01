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

<section class="jilp-hero{if !$homepageImage} jilp-hero--plain{/if}"
	{if $homepageImage}
		style="background-image:linear-gradient(to right, rgba(15,23,42,.95), rgba(15,23,42,.85)), url('{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}');"
	{/if}>
	<div class="container position-relative z-2">
		<div class="row align-items-center gy-5">

			{if $heroCover}
				<div class="col-lg-5 jilp-hero-cover-wrapper">
					<div class="jilp-hero-cover-card">
						{if $issue && $issue->getLocalizedCoverImageUrl()}
							<span class="jilp-hero-cover-badge">
								<i class="bi bi-stars me-1"></i> {translate key="plugins.themes.journalEditorial.hero.currentIssue"}
							</span>
						{/if}
						{if $issue && $issue->getLocalizedCoverImageUrl()}
							<a href="{url page="issue" op="view" path=$issue->getId()}" title="{$heroCoverTitle|escape}">
						{/if}
							<img class="img-fluid" src="{$heroCover|escape:"url"}" alt="{$heroCoverTitle|escape}" />
						{if $issue && $issue->getLocalizedCoverImageUrl()}
							</a>
						{/if}
					</div>
				</div>
			{/if}

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
							<a class="jilp-hero-readmore" href="{url page="about"}">{translate key="plugins.themes.journalEditorial.hero.readMore"}</a>
						{else}
							{translate key="plugins.themes.journalEditorial.hero.fallbackDesc" journalName=$currentJournal->getLocalizedName()|escape}
						{/if}
					</div>
				</div>

				<div class="d-flex flex-wrap justify-content-start gap-3 mb-0">
					<a class="btn jilp-btn-hero-primary text-decoration-none px-4 py-3" href="{url page="submission" op="submit"}">
						<i class="bi bi-send-fill me-2"></i> {translate key="plugins.themes.journalEditorial.hero.submit"}
					</a>
					<a class="btn jilp-btn-hero-glass text-decoration-none px-4 py-3" href="#current-issue-section">
						<i class="bi bi-compass me-2"></i> {translate key="plugins.themes.journalEditorial.hero.exploreIssue"}
					</a>
				</div>
			</div>

			{if !$heroCover}
				<div class="col-lg-4 offset-lg-1 d-none d-lg-block">
					<dl class="jilp-hero-facts">
						{if $currentJournal->getData('onlineIssn')}
							<div><dt>e-ISSN</dt><dd>{$currentJournal->getData('onlineIssn')|escape}</dd></div>
						{/if}
						{if $currentJournal->getData('printIssn')}
							<div><dt>p-ISSN</dt><dd>{$currentJournal->getData('printIssn')|escape}</dd></div>
						{/if}
						{if $currentJournal->getData('publisherInstitution')}
							<div><dt>{translate key="plugins.themes.journalEditorial.hero.publisher"}</dt><dd>{$currentJournal->getData('publisherInstitution')|escape}</dd></div>
						{/if}
						{if $currentJournal->getData('contactEmail')}
							<div><dt>{translate key="plugins.themes.journalEditorial.hero.contact"}</dt><dd><a href="mailto:{$currentJournal->getData('contactEmail')|escape}">{$currentJournal->getData('contactEmail')|escape}</a></dd></div>
						{/if}
					</dl>
				</div>
			{/if}
		</div>
	</div>
</section>
