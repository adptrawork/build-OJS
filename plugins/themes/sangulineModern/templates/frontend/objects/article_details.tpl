{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * SangulineModern override: layout rebuilt to match the article prototype
 * (build-OJS/article.html) — one "Detail Artikel" card (badges, authors with
 * superscript affiliations, DOI/received/published/pages info grid, abstract,
 * keywords), an embedded PDF viewer card, a references card with an expand
 * toggle in the main column; the sidebar carries the issue block, the
 * download/LoA box, usage stats, share actions and the license card.
 * All core Smarty logic, hooks and data are preserved.
 *}
<article class="obj_article_details jrdc-article">

	{* Indicate if this is only a preview *}
	{if $publication->getData('status') !== $smarty.const.STATUS_PUBLISHED}
	<div class="cmp_notification notice">
		{capture assign="submissionUrl"}{url page="workflow" op="access" path=$article->getId()}{/capture}
		{translate key="submission.viewingPreview" url=$submissionUrl}
	</div>
	{* Notification that this is an old version *}
	{elseif $currentPublication->getId() !== $publication->getId()}
		<div class="cmp_notification notice">
			{capture assign="latestVersionUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
			{translate key="submission.outdatedVersion"
				datePublished=$publication->getData('datePublished')|date_format:$dateFormatShort
				urlRecentVersion=$latestVersionUrl|escape
			}
		</div>
	{/if}

	{assign var="isOpenAccess" value=0}
	{if $currentContext->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == $smarty.const.ARTICLE_ACCESS_OPEN}
		{assign var="isOpenAccess" value=1}
	{/if}

	<div class="row g-4 jrdc-article__row">

		{* ===================== Main column ===================== *}
		<div class="col-12 col-lg-8 jrdc-article__main">

			{* ---------- Detail Artikel card ---------- *}
			<section class="card jrdc-article__card jrdc-article__detail">
				<div class="card-body jrdc-article__detail-body">

					<div class="jrdc-article__badges">
						{if $section}
							<span class="jrdc-article__badge jrdc-article__badge--section">
								{$section->getLocalizedTitle()|escape}
							</span>
						{/if}
						{if $isOpenAccess}
							<span class="jrdc-article__badge jrdc-article__badge--open">{translate key="plugins.themes.sangulineModern.article.openAccess"}</span>
						{/if}
						{if $publication->getLocalizedData('pages')}
							<span class="jrdc-article__badge jrdc-article__badge--pages">
								{translate key="plugins.themes.sangulineModern.article.pagesBadge"}{$publication->getLocalizedData('pages')|escape}
							</span>
						{/if}
					</div>

					<h1 class="page_title jrdc-article__title">
						{$publication->getLocalizedTitle()|strip_unsafe_html}
					</h1>

					{if $publication->getLocalizedData('subtitle')}
						<h2 class="subtitle jrdc-article__subtitle">
							{$publication->getLocalizedData('subtitle')|strip_unsafe_html}
						</h2>
					{/if}

					{if $publication->getData('authors')}
						<div class="jrdc-article__authors-block">
							<div class="jrdc-article__author-line">
								{assign var="affiliationIndex" value=0}
								{foreach from=$publication->getData('authors') item=author name="authorLine"}
									{if $smarty.foreach.authorLine.iteration > 1}, {/if}
									<span class="jrdc-article__author-name">{$author->getFullName()|escape}{if $author->getLocalizedData('affiliation')}<sup class="jrdc-article__sup">{$affiliationIndex+1}</sup>{assign var="affiliationIndex" value=$affiliationIndex+1}{/if}</span>
								{/foreach}
							</div>

							<ul class="jrdc-article__affils">
								{assign var="affiliationIndex" value=0}
								{foreach from=$publication->getData('authors') item=author name="affilList"}
									{if $author->getLocalizedData('affiliation')}
										{assign var="affiliationIndex" value=$affiliationIndex+1}
										<li>
											<sup class="jrdc-article__sup">{$affiliationIndex}</sup>
											{$author->getLocalizedData('affiliation')|escape}
											{assign var="authorCountry" value=$author->getCountryLocalized()}
											{if $authorCountry}, {$authorCountry|escape}{/if}
											{if $author->getData('rorId')}
												<a class="jrdc-article__ror" href="{$author->getData('rorId')|escape}" title="ROR ID" rel="noopener">{$rorIdIcon}</a>
											{/if}
										</li>
									{/if}
								{/foreach}
							</ul>

							{assign var="orcidCount" value=0}
							{foreach from=$publication->getData('authors') item=author}
								{if $author->getData('orcid')}{assign var="orcidCount" value=$orcidCount+1}{/if}
							{/foreach}
							{if $orcidCount}
								<ul class="jrdc-article__orcids">
									{foreach from=$publication->getData('authors') item=author}
										{if $author->getData('orcid')}
											<li class="jrdc-article__orcid">
												<span class="jrdc-orcid-id">{$orcidIcon}</span>
												<a href="{$author->getData('orcid')|escape}" target="_blank" rel="noopener">{$author->getFullName()|escape} — {$author->getData('orcid')|escape}</a>
											</li>
										{/if}
									{/foreach}
								</ul>
							{/if}
						</div>
					{/if}

					<div class="jrdc-article__info">
						<div>
							<span class="jrdc-article__info-label">DOI</span>
							{assign var="doi" value=''}
							{assign var="doiUrl" value=''}
							{foreach from=$pubIdPlugins item=pubIdPlugin}
								{if $pubIdPlugin->getPubIdType() == 'doi'}
									{assign var="doi" value=$article->getStoredPubId('doi')}
									{if $doi}
										{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $doi)|escape}
									{/if}
								{/if}
							{/foreach}
							{if $doi}
								<a class="jrdc-article__info-value jrdc-article__doi-link" href="{$doiUrl}">{$doi|escape}</a>
								<button type="button" class="jrdc-doi-copy jrdc-article__doi-copy" data-doi="{$doiUrl}" aria-label="{translate key="plugins.themes.sangulineModern.article.copyDoi"}" title="{translate key="plugins.themes.sangulineModern.article.copyDoi"}">
									<span class="bi bi-copy" aria-hidden="true"></span>
								</button>
							{else}
								<span class="jrdc-article__info-value">—</span>
							{/if}
						</div>
						<div>
							<span class="jrdc-article__info-label">{translate key="plugins.themes.sangulineModern.article.received"}</span>
							<span class="jrdc-article__info-value">{$article->getData('dateSubmitted')|date_format:$dateFormatShort}</span>
						</div>
						<div>
							<span class="jrdc-article__info-label">{translate key="plugins.themes.sangulineModern.article.published"}</span>
							<span class="jrdc-article__info-value">{$publication->getData('datePublished')|date_format:$dateFormatShort}</span>
						</div>
						<div>
							<span class="jrdc-article__info-label">{translate key="plugins.themes.sangulineModern.article.pagesInfoLabel"}</span>
							<span class="jrdc-article__info-value">{$publication->getLocalizedData('pages')|escape|default:'—'}</span>
						</div>
					</div>

					{if $publication->getLocalizedData('abstract')}
						<div class="jrdc-article__abstract">
							<h2 class="jrdc-article__section-title">{translate key="article.abstract"}</h2>
							<div class="jrdc-article__abstract-body">
								{$publication->getLocalizedData('abstract')|strip_unsafe_html}
							</div>
						</div>
					{/if}

					{if !empty($publication->getLocalizedData('keywords'))}
						<div class="jrdc-article__keywords">
							<span class="jrdc-article__keywords-label">{translate key="plugins.themes.sangulineModern.article.keywords"}</span>
							<span class="jrdc-article__keyword-list">
								{foreach name="keywords" from=$publication->getLocalizedData('keywords') item="keyword"}
									<span class="jrdc-article__keyword">{$keyword|escape}</span>
								{/foreach}
							</span>
						</div>
					{/if}

				</div>
			</section>

			{call_hook name="Templates::Article::Main"}

			{* ---------- Embedded PDF viewer card ---------- *}
			{if $primaryGalleys}
				{assign var="firstGalley" value=$primaryGalleys[0]}
				{* Same path logic as core frontend/objects/galley_link.tpl. *}
				{assign var="galleyPath" value=$article->getBestId()|to_array:$firstGalley->getBestGalleyId()}
				{if $publication && $publication->getId() !== $article->getData('currentPublicationId')}
					{assign var="galleyPath" value=$article->getBestId()|to_array:"version":$publication->getId():$firstGalley->getBestGalleyId()}
				{/if}
				{capture assign="galleyUrl"}{url page="article" op="view" path=$galleyPath}{/capture}
				<section class="card jrdc-article__card jrdc-article__pdf">
					<div class="card-header jrdc-article__card-header jrdc-article__pdf-header">
						<div class="jrdc-article__pdf-heading">
							<h2 class="jrdc-article__section-title">{translate key="plugins.themes.sangulineModern.article.pdfCardTitle"}</h2>
							<p class="jrdc-article__pdf-subtitle">
								{$firstGalley->getLabel()|escape}
								{if $publication->getLocalizedData('pages')} · {translate key="plugins.themes.sangulineModern.article.pagesBadge"}{$publication->getLocalizedData('pages')|escape}{/if}
							</p>
						</div>
						<a class="btn btn-primary jrdc-button jrdc-article__pdf-cta" href="{$galleyUrl}">
							<span class="bi bi-download" aria-hidden="true"></span> {translate key="plugins.themes.sangulineModern.article.downloadCta"}
						</a>
					</div>
					<div class="card-body jrdc-article__pdf-body">
						<iframe class="jrdc-article__pdf-frame" src="{$galleyUrl}" title="PDF Viewer" loading="lazy"></iframe>
					</div>
				</section>
			{/if}

			{* ---------- References with expand toggle ---------- *}
			{if $parsedCitations || $publication->getLocalizedData('citationsRaw')}
				<section class="card jrdc-article__card jrdc-article__references">
					<div class="card-header jrdc-article__card-header">
						<h2 class="jrdc-article__section-title">{translate key="submission.citations"}</h2>
					</div>
					<div class="card-body jrdc-article__references-body">
						{if $parsedCitations}
							<ol class="jrdc-article__reference-list">
								{foreach from=$parsedCitations item="parsedCitation"}
									<li>{$parsedCitation->getCitationWithLinks()|strip_unsafe_html} {call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}</li>
								{/foreach}
							</ol>
						{else}
							<ol class="jrdc-article__reference-list">
								{assign var="shown" value=0}
								{foreach from=$publication->getLocalizedData('citationsRaw')|@explode:"\n" item="citation" name="refs"}
									{assign var="trimmed" value=$citation|@trim}
									{if $trimmed == ''}{continue}{/if}
									{if $shown < 5}
										<li>{$trimmed|escape}</li>
										{assign var="shown" value=$shown+1}
									{/if}
								{/foreach}
							</ol>
							{capture assign="allRefs"}{foreach from=$publication->getLocalizedData('citationsRaw')|@explode:"\n" item="citation" name="allRefs"}{assign var="trimmed" value=$citation|@trim}{if $trimmed == ''}{continue}{/if}{if $smarty.foreach.allRefs.iteration > 5}<li>{$trimmed|escape}</li>{/if}{/foreach}{/capture}
							{if $allRefs|@trim != ''}
								<div class="collapse mt-2" id="extraReferences">
									<ol class="jrdc-article__reference-list" start="6">
										{$allRefs}
									</ol>
								</div>
								<button type="button" class="btn jrdc-article__references-toggle" data-bs-toggle="collapse" data-bs-target="#extraReferences" aria-expanded="false" aria-controls="extraReferences">
									{translate key="plugins.themes.sangulineModern.article.referencesMore"}
								</button>
							{/if}
						{/if}
					</div>
				</section>
			{/if}

			{* ---------- Author biographies ---------- *}
			{assign var="hasBiographies" value=0}
			{foreach from=$publication->getData('authors') item=author}
				{if $author->getLocalizedData('biography')}
					{assign var="hasBiographies" value=$hasBiographies+1}
				{/if}
			{/foreach}
			{if $hasBiographies}
				<section class="card jrdc-article__card jrdc-article__bios">
					<div class="card-header jrdc-article__card-header">
						<h2 class="jrdc-article__section-title">
							{if $hasBiographies > 1}
								{translate key="submission.authorBiographies"}
							{else}
								{translate key="submission.authorBiography"}
							{/if}
						</h2>
					</div>
					<ul class="list-group list-group-flush authors">
						{foreach from=$publication->getData('authors') item=author}
							{if $author->getLocalizedData('biography')}
								<li class="list-group-item sub_item">
									<div class="label">
										{$author->getFullName()|escape}
									</div>
									<div class="value">
										{$author->getLocalizedData('biography')|strip_unsafe_html}
									</div>
								</li>
							{/if}
						{/foreach}
					</ul>
				</section>
			{/if}

			{* ---------- Data Availability Statement ---------- *}
			{if $publication->getLocalizedData('dataAvailability')}
				<section class="card jrdc-article__card jrdc-article__data-availability" id="data-availability-statement">
					<div class="card-header jrdc-article__card-header">
						<h2 class="jrdc-article__section-title">{translate key="submission.dataAvailability"}</h2>
					</div>
					<div class="card-body">
						{$publication->getLocalizedData('dataAvailability')|strip_unsafe_html}
					</div>
				</section>
			{/if}

		</div><!-- .jrdc-article__main -->

		{* ===================== Sidebar ===================== *}
		<div class="col-12 col-lg-4 jrdc-article__sidebar">

			{* ---------- Issue card ---------- *}
			{if $issue}
				<div class="card jrdc-article__card jrdc-article__issue">
					<div class="card-body jrdc-article__issue-body">
						<div class="jrdc-article__issue-head">
							<span class="jrdc-article__issue-cover" aria-hidden="true">
								<span class="jrdc-article__issue-cover-title">JRDC</span>
								<span class="jrdc-article__issue-cover-vol">Vol. 1 No. 1</span>
								<span class="jrdc-article__issue-cover-year">2026</span>
							</span>
							<span class="jrdc-article__issue-meta">
								<span class="jrdc-article__side-eyebrow">{translate key="plugins.themes.sangulineModern.article.issueEyebrow"}</span>
								<a class="jrdc-article__issue-title" href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
									{$issue->getIssueIdentification()|escape}
								</a>
								<span class="jrdc-article__issue-journal">{$currentContext->getLocalizedData('name')|escape}</span>
							</span>
						</div>
						<a class="jrdc-article__issue-link" href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
							{translate key="plugins.themes.sangulineModern.article.issueAllCta"}
							<span class="bi bi-arrow-right" aria-hidden="true"></span>
						</a>
					</div>
				</div>
			{/if}

			{* ---------- Download box ---------- *}
			<div class="card jrdc-article__card jrdc-article__download">
				<div class="card-header jrdc-article__card-header jrdc-article__download-header">
					<h2 class="jrdc-article__side-title">{translate key="plugins.themes.sangulineModern.article.downloadBoxTitle" galley=$primaryGalleys[0]->getLabel()|upper|escape}</h2>
					{if $isOpenAccess}<span class="jrdc-article__badge jrdc-article__badge--open">{translate key="plugins.themes.sangulineModern.article.openAccess"}</span>{/if}
				</div>
				<div class="card-body">
					<div class="jrdc-article__download-row">
						<span>{translate key="plugins.themes.sangulineModern.article.pagesRow"}</span>
						<span class="jrdc-article__download-value">{$publication->getLocalizedData('pages')|escape|default:'—'}</span>
					</div>
					{if $primaryGalleys}
						<div class="jrdc-article__download-list">
							{foreach from=$primaryGalleys item=galley}
								{assign var="galleyPath" value=$article->getBestId()|to_array:$galley->getBestGalleyId()}
								{if $publication && $publication->getId() !== $article->getData('currentPublicationId')}
									{assign var="galleyPath" value=$article->getBestId()|to_array:"version":$publication->getId():$galley->getBestGalleyId()}
								{/if}
								<a class="btn jrdc-article__download-button" href="{url page="article" op="view" path=$galleyPath}">
									<span class="bi bi-download" aria-hidden="true"></span>
									{translate key="plugins.themes.sangulineModern.article.downloadButton" label=$galley->getLabel()|escape}
								</a>
							{/foreach}
						</div>
					{/if}
					{if $supplementaryGalleys}
						<ul class="jrdc-article__supplementary-list">
							{foreach from=$supplementaryGalleys item=galley}
								{assign var="suppPath" value=$article->getBestId()|to_array:$galley->getBestGalleyId()}
								{if $publication && $publication->getId() !== $article->getData('currentPublicationId')}
									{assign var="suppPath" value=$article->getBestId()|to_array:"version":$publication->getId():$galley->getBestGalleyId()}
								{/if}
								<li>
									<a class="jrdc-article__supplementary-link" href="{url page="article" op="view" path=$suppPath}">
										<span class="bi bi-file-earmark-pdf" aria-hidden="true"></span>
										{translate key="plugins.themes.sangulineModern.article.loaButton" label=$galley->getLabel()|escape}
									</a>
								</li>
							{/foreach}
						</ul>
					{/if}
				</div>
			</div>

			{* ---------- Usage statistics ---------- *}
			{if $activeTheme && $activeTheme->getOption('displayStats') != 'none' && $activeTheme->supportsUsageStats()}
				<section class="card jrdc-article__card jrdc-article__downloads-chart">
					<div class="card-header jrdc-article__card-header">
						<h2 class="jrdc-article__side-title">{translate key="plugins.themes.sanguline.displayStats.downloads"}</h2>
					</div>
					<div class="card-body">
						<div class="value">
							<canvas class="usageStatsGraph" data-object-type="Submission" data-object-id="{$article->getId()|escape}"></canvas>
							<div class="usageStatsUnavailable" data-object-type="Submission" data-object-id="{$article->getId()|escape}">
								{translate key="plugins.themes.sanguline.displayStats.noStats"}
							</div>
						</div>
					</div>
				</section>
			{/if}

			{* ---------- Share ---------- *}
			{capture assign="articlePath"}{url page="article" op="view" path=$article->getBestId()}{/capture}
			{assign var="articleUrl" value=$articlePath}
			{assign var="shareTitle" value=$publication->getLocalizedTitle()|strip_unsafe_html|escape:'url'}
			{assign var="shareUrl" value=$articleUrl|escape:'url'}
			<div class="card jrdc-article__card jrdc-article__share">
				<div class="card-header jrdc-article__card-header">
					<h2 class="jrdc-article__side-title">{translate key="plugins.themes.sangulineModern.article.shareTitle"}</h2>
				</div>
				<div class="card-body">
					<div class="jrdc-article__share-grid">
						<a class="jrdc-article__share-btn jrdc-article__share-btn--wa" href="https://wa.me/?text={$shareTitle}%20{$shareUrl}" target="_blank" rel="noopener" title="{translate key="plugins.themes.sangulineModern.article.shareWhatsapp"}" aria-label="{translate key="plugins.themes.sangulineModern.article.shareWhatsapp"}">
							<span class="bi bi-whatsapp" aria-hidden="true"></span>
							<span class="jrdc-article__share-label">WA</span>
						</a>
						<a class="jrdc-article__share-btn jrdc-article__share-btn--x" href="https://twitter.com/intent/tweet?text={$shareTitle}&url={$shareUrl}" target="_blank" rel="noopener" title="{translate key="plugins.themes.sangulineModern.article.shareX"}" aria-label="{translate key="plugins.themes.sangulineModern.article.shareX"}">
							<span class="bi bi-twitter-x" aria-hidden="true"></span>
							<span class="jrdc-article__share-label">X</span>
						</a>
						<a class="jrdc-article__share-btn jrdc-article__share-btn--fb" href="https://www.facebook.com/sharer/sharer.php?u={$shareUrl}" target="_blank" rel="noopener" title="{translate key="plugins.themes.sangulineModern.article.shareFacebook"}" aria-label="{translate key="plugins.themes.sangulineModern.article.shareFacebook"}">
							<span class="bi bi-facebook" aria-hidden="true"></span>
							<span class="jrdc-article__share-label">FB</span>
						</a>
						<a class="jrdc-article__share-btn jrdc-article__share-btn--in" href="https://www.linkedin.com/sharing/share-offsite/?url={$shareUrl}" target="_blank" rel="noopener" title="{translate key="plugins.themes.sangulineModern.article.shareLinkedIn"}" aria-label="{translate key="plugins.themes.sangulineModern.article.shareLinkedIn"}">
							<span class="bi bi-linkedin" aria-hidden="true"></span>
							<span class="jrdc-article__share-label">In</span>
						</a>
					</div>
					<button type="button" class="jrdc-doi-copy jrdc-article__copy-link" data-doi="{$articleUrl|escape}" aria-label="{translate key="plugins.themes.sangulineModern.article.copyLink"}">
						<span class="bi bi-link-45deg" aria-hidden="true"></span>
						{translate key="plugins.themes.sangulineModern.article.copyLink"}
					</button>
				</div>
			</div>

			{* ---------- License ---------- *}
			{if $currentContext->getLocalizedData('licenseTerms') || $publication->getData('licenseUrl')}
				<div class="card jrdc-article__card jrdc-article__license">
					<div class="card-header jrdc-article__card-header">
						<h2 class="jrdc-article__side-title">{translate key="plugins.themes.sangulineModern.article.licenseTitle"}</h2>
					</div>
					<div class="card-body jrdc-article__license-body">
						{if $publication->getData('licenseUrl') && $ccLicenseBadge}{$ccLicenseBadge}{/if}
						{if $currentContext->getLocalizedData('licenseTerms')}
							<p class="jrdc-article__license-terms">{$currentContext->getLocalizedData('licenseTerms')|strip_unsafe_html}</p>
						{else}
							<p class="jrdc-article__license-terms">
								{translate key="submission.license"}
								{if $publication->getData('licenseUrl')}
									<a href="{$publication->getData('licenseUrl')|escape}">{$publication->getData('licenseUrl')|escape}</a>
								{/if}
							</p>
						{/if}
					</div>
				</div>
			{/if}

			{* Versions *}
			{if count($article->getPublishedPublications()) > 1}
				<div class="item versions">
					<h3 class="label">
						{translate key="submission.versions"}
					</h3>
					<ul class="value list-unstyled">
						{foreach from=array_reverse($article->getPublishedPublications()) item=iPublication}
							{capture assign="name"}{translate key="submission.versionIdentity" datePublished=$iPublication->getData('datePublished')|date_format:$dateFormatShort version=$iPublication->getData('version')}{/capture}
							<li>
								{if $iPublication->getId() === $publication->getId()}
									{$name}
								{elseif $iPublication->getId() === $currentPublication->getId()}
									<a href="{url page="article" op="view" path=$article->getBestId()}">{$name}</a>
								{else}
									<a href="{url page="article" op="view" path=$article->getBestId()|to_array:"version":$iPublication->getId()}">{$name}</a>
								{/if}
							</li>
						{/foreach}
					</ul>
				</div>
			{/if}

			{* Categories *}
			{if $categories}
				<div class="item categories">
					<h3 class="label">
						{translate key="category.category"}
					</h3>
					<div class="value">
						<ul class="categories list-unstyled">
							{foreach from=$categories item=category}
								<li><a href="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()|escape}">{$category->getLocalizedTitle()|escape}</a></li>
							{/foreach}
						</ul>
					</div>
				</div>
			{/if}

			{* Non-DOI PubIds *}
			{if $currentJournal}
				{foreach from=$pubIdPlugins item=pubIdPlugin}
					{if $pubIdPlugin->getPubIdType() == 'doi'}
						{continue}
					{/if}
					{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
					{if $pubId}
						{assign var="resolvedPubIdUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
						<section class="card jrdc-article__card jrdc-article__pubid">
							<div class="card-header jrdc-article__card-header">
								<h2 class="jrdc-article__section-title">{$pubIdPlugin->getPubIdDisplayType()|escape}</h2>
							</div>
							<div class="card-body">
								<div class="value">
									{if $resolvedPubIdUrl}
										<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}" href="{$resolvedPubIdUrl}">{$resolvedPubIdUrl}</a>
									{else}
										{$pubId|escape}
									{/if}
								</div>
							</div>
						</section>
					{/if}
				{/foreach}
			{/if}

			{call_hook name="Templates::Article::Details"}
		</div><!-- .jrdc-article__sidebar -->

	</div><!-- .jrdc-article__row -->

</article><!-- .obj_article_details -->
