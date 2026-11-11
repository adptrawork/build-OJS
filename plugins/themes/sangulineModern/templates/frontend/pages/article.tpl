{**
 * SangulineModern theme override of frontend/pages/article.tpl (parent: core)
 * Keeps everything identical to core; only the PageFooter template hook is
 * removed from the main column — the hook is re-emitted inside the sidebar by
 * object templates/frontend/objects/article_details.tpl (see the
 * .jrdc-article__sidebar block), so recommendBlocks render in the sidebar.
 *}
{**
 * templates/frontend/pages/article.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view an article with all of it's details.
 *
 * @uses $article Submission This article
 * @uses $publication Publication The publication being displayed
 * @uses $firstPublication Publication The first published version of this article
 * @uses $currentPublication Publication The most recently published version of this article
 * @uses $issue Issue The issue this article was published in.
 * @uses $section Section The journal section this article is assigned to
 * @uses $journal Journal The journal currently being viewed.
 * @uses $primaryGalleys array List of article galleys that are not supplementary or dependent
 * @uses $supplementaryGalleys array List of article galleys that are supplementary
 * @uses $keywords array List of keywords assigned to this article
 * @uses $pubIdPlugins Array of pubId plugins which this article may be assigned
 * @uses $licenseTerms string License terms.
 * @uses $licenseUrl string URL to license. Only assigned if license should be
 *   included with published submissions.
 * @uses $ccLicenseBadge string An image and text with details about the license
 *}
{assign var="isFullWidth" value=true}
{include file="frontend/components/header.tpl" pageTitleTranslated=$article->getLocalizedFullTitle()|escape suppressContentWrapper=true}

<div class="container-fluid jrdc-content">
		<div class="row g-4">
			<div class="col-12 pkp_structure_main jrdc-main" role="main">
				<a id="pkp_content_main"></a>

	{if $section}
		{include file="frontend/components/breadcrumbs_article.tpl" currentTitle=$section->getLocalizedTitle()}
	{else}
		{include file="frontend/components/breadcrumbs_article.tpl" currentTitleKey="common.publication"}
	{/if}

	{* Show article overview *}
	{include file="frontend/objects/article_details.tpl"}

{include file="frontend/components/footer.tpl"}
