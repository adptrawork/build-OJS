{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/header.tpl
 *
 * Bootstrap 5 header replicating the JILP / Zenith layout.
 *}
{strip}
	{assign var="showingLogo" value=true}
	{if !$displayPageHeaderLogo}
		{assign var="showingLogo" value=false}
	{/if}
	{assign var="jilpPage" value=$requestedPage|default:"index"}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

<div class="pkp_structure_page">

	<header class="pkp_structure_head navbar navbar-expand-lg navbar-light py-3" id="headerNavigationContainer" role="banner">
		{include file="frontend/components/skipLinks.tpl"}

		<div class="container-fluid px-4 px-xl-5">
			{capture assign="homeUrl"}{strip}{url page="index"}{/strip}{/capture}

			<a class="navbar-brand d-flex align-items-center gap-2" href="{$homeUrl}">
				{if $displayPageHeaderLogo}
					<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" alt="{$displayPageHeaderLogo.altText|escape|default:$applicationName}" style="max-height:48px;width:auto;" />
				{else}
					<span class="fw-bold">{$displayPageHeaderTitle|escape}</span>
				{/if}
			</a>

			<div class="jilp-mobile-toggles d-lg-none">
				<button class="jilp-theme-toggle" type="button" title="{translate key="plugins.themes.journalEditorial.toggleTheme"}" aria-label="{translate key="plugins.themes.journalEditorial.toggleTheme"}">
					<i class="bi bi-moon-stars-fill jilp-theme-toggle-icon" aria-hidden="true"></i>
				</button>
				<button class="navbar-toggler border-0 shadow-none p-0" type="button" data-bs-toggle="collapse" data-bs-target="#jilpNavMenu" aria-controls="jilpNavMenu" aria-expanded="false" aria-label="{translate key="plugins.themes.journalEditorial.toggleNav"}">
					<span class="navbar-toggler-icon"></span>
				</button>
			</div>

			<div class="collapse navbar-collapse" id="jilpNavMenu">
				{capture assign="primaryMenu"}
					{load_menu name="primary" id="navigationPrimary" ulClass="navbar-nav mx-auto mb-2 mb-lg-0 pkp_nav_list jilp-nav"}
				{/capture}
				{$primaryMenu}

				<div class="d-flex align-items-center gap-3 ms-auto mt-3 mt-lg-0">
					{if $currentContext && $jilpPage !== 'search'}
						<form action="{url page="search" op="search"}" method="get" class="jilp-search-container" role="search">
							<input type="text" name="query" class="form-control jilp-search-input shadow-sm" placeholder="{translate key="common.search"|escape}" aria-label="{translate key="common.search"|escape}" />
							<button class="jilp-search-btn shadow-sm" type="submit" title="{translate key="common.search"|escape}">
								<i class="bi bi-search" aria-hidden="true"></i>
							</button>
						</form>
					{/if}

					<button class="jilp-theme-toggle d-none d-lg-flex" type="button" title="Toggle Dark/Light Mode" aria-label="Toggle Dark/Light Mode">
						<i class="bi bi-moon-stars-fill jilp-theme-toggle-icon" aria-hidden="true"></i>
					</button>

					{if $isUserLoggedIn}
						{load_menu name="user" id="navigationUser" ulClass="navbar-nav jilp-user-nav"}
					{else}
						<div class="d-flex gap-2">
							<a class="btn jilp-btn-login" href="{url page="login"}">
								<i class="bi bi-box-arrow-in-right me-1" aria-hidden="true"></i> {translate key="user.login"}
							</a>
							<a class="btn jilp-btn-register" href="{url page="user" op="register"}">
								<i class="bi bi-person-plus me-1" aria-hidden="true"></i> {translate key="user.register"}
							</a>
						</div>
					{/if}
				</div>
			</div>
		</div>
	</header>

	{* JILP/Zenith-style inner page banner: breadcrumb + page title.
	   Rendered from the header so every core page (archive, about, search,
	   auth, announcement, …) gets it without template overrides. Article
	   pages show the breadcrumb only; their title lives in article_details. *}
	{capture assign="jilpBannerCrumb"}
		{if $jilpPage == 'article'}{translate key="article.article"}{elseif $jilpPage == 'issue' && $issue}{$issue->getIssueIdentification()|escape}{else}{$pageTitleTranslated|strip_unsafe_html}{/if}
	{/capture}
	{assign var="jilpHasBanner" value=false}
	{if $jilpPage == 'article' || $jilpPage == 'issue' || ($pageTitleTranslated && $jilpPage != 'index')}
		{assign var="jilpHasBanner" value=true}
	{/if}
	{if $jilpHasBanner}
		<section class="jilp-inner-banner">
			<div class="container">
				<nav aria-label="{translate key="navigation.breadcrumbLabel"}">
					<ol class="jilp-breadcrumb">
						<li>
							<a href="{$homeUrl}"><i class="bi bi-house-door-fill" aria-hidden="true"></i> {translate key="common.homepageNavigationLabel"}</a>
						</li>
						{if $jilpPage == 'issue' || $jilpPage == 'article'}
							<li>
								<a href="{url page="issue" op="archive"}">{translate key="navigation.archives"}</a>
							</li>
						{/if}
						{if $jilpPage == 'article' && $issue}
							<li>
								<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">{$issue->getIssueIdentification()|escape}</a>
							</li>
						{/if}
						<li class="active" aria-current="page">{$jilpBannerCrumb|trim}</li>
					</ol>
				</nav>
				{if $jilpPage != 'article' && !($jilpPage == 'issue' && $requestedOp == 'view')}
					<h1 class="jilp-inner-banner-title">{$jilpBannerCrumb|trim}</h1>
				{/if}
			</div>
		</section>
	{/if}

	{* Wrapper for page content and sidebars *}
	{if $isFullWidth}
		{assign var=hasSidebar value=0}
	{/if}
	<div class="pkp_structure_content{if $hasSidebar} has_sidebar{/if}">
		<div class="pkp_structure_main{if $jilpHasBanner} jilp-inner{/if}" role="main">
			<a id="pkp_content_main"></a>
