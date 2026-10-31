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

<section class="jilp-hero shadow-lg{if !$homepageImage} jilp-hero--plain{/if}"
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
								<i class="bi bi-stars me-1"></i> Current Issue
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

			<div class="{if $heroCover}col-lg-7 text-lg-start{else}col-lg-9 mx-auto{/if} text-center">
				<h1 class="jilp-hero-title fw-bold mb-4">
					{$currentJournal->getLocalizedName()|escape}
				</h1>

				<div class="jilp-hero-desc-card mb-4">
					<div class="row g-2 mb-4 justify-content-center justify-content-lg-start">
						<div class="col-6 col-md-auto">
							<div class="jilp-hero-badge jilp-hero-badge--primary">
								<i class="bi bi-shield-check mb-1"></i>
								<span class="fw-bold">Open Access</span>
							</div>
						</div>
						<div class="col-6 col-md-auto">
							<div class="jilp-hero-badge">
								<i class="bi bi-check-circle mb-1"></i>
								<span class="fw-bold">Peer Reviewed</span>
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
							<a class="text-primary fw-bold text-decoration-none" href="{url page="about"}">Read more</a>
						{else}
							{$currentJournal->getLocalizedName()|escape} publishes peer-reviewed research in an open-access format.
						{/if}
					</div>
				</div>

				<div class="d-flex flex-wrap justify-content-center justify-content-lg-start gap-3">
					<a class="btn jilp-btn-hero-primary text-decoration-none px-4 py-3" href="{url page="submission" op="submit"}">
						<i class="bi bi-send-fill me-2"></i> Submit Your Research
					</a>
					<a class="btn jilp-btn-hero-glass text-decoration-none px-4 py-3" href="#current-issue-section">
						<i class="bi bi-compass me-2"></i> Explore Current Issue
					</a>
				</div>
			</div>
		</div>
	</div>
</section>
