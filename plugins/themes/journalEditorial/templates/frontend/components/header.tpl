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
			{capture assign="homeUrl"}
				{url page="index" router=PKP\core\PKPApplication::ROUTE_PAGE}
			{/capture}

			<a class="navbar-brand d-flex align-items-center gap-2" href="{$homeUrl}">
				{if $displayPageHeaderLogo}
					<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" alt="{$displayPageHeaderLogo.altText|escape|default:$applicationName}" style="max-height:48px;width:auto;" />
				{else}
					<span class="fw-bold">{$displayPageHeaderTitle|escape}</span>
				{/if}
			</a>

			<div class="jilp-mobile-toggles d-lg-none">
				<button class="jilp-theme-toggle" type="button" title="Toggle Dark/Light Mode" aria-label="Toggle Dark/Light Mode">
					<i class="bi bi-moon-stars-fill jilp-theme-toggle-icon"></i>
				</button>
				<button class="navbar-toggler border-0 shadow-none p-0" type="button" data-bs-toggle="collapse" data-bs-target="#jilpNavMenu" aria-controls="jilpNavMenu" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
			</div>

			<div class="collapse navbar-collapse" id="jilpNavMenu">
				{capture assign="primaryMenu"}
					{load_menu name="primary" id="navigationPrimary" ulClass="navbar-nav mx-auto mb-2 mb-lg-0 pkp_nav_list jilp-nav"}
				{/capture}
				{$primaryMenu}

				<div class="d-flex align-items-center gap-3 ms-auto mt-3 mt-lg-0">
					{if $currentContext && $requestedPage !== 'search'}
						<form action="{url page="search" op="search"}" method="get" class="jilp-search-container" role="search">
							<input type="text" name="query" class="form-control jilp-search-input shadow-sm" placeholder="{translate key="common.search"|escape}" aria-label="{translate key="common.search"|escape}" />
							<button class="jilp-search-btn shadow-sm" type="submit" title="{translate key="common.search"|escape}">
								<i class="bi bi-search"></i>
							</button>
						</form>
					{/if}

					<button class="jilp-theme-toggle d-none d-lg-flex" type="button" title="Toggle Dark/Light Mode" aria-label="Toggle Dark/Light Mode">
						<i class="bi bi-moon-stars-fill jilp-theme-toggle-icon"></i>
					</button>

					{if $isUserLoggedIn}
						{load_menu name="user" id="navigationUser" ulClass="navbar-nav jilp-user-nav"}
					{else}
						<div class="d-flex gap-2">
							<a class="btn jilp-btn-login" href="{url page="login"}">
								<i class="bi bi-box-arrow-in-right me-1"></i> {translate key="user.login"}
							</a>
							<a class="btn jilp-btn-register" href="{url page="user" op="register"}">
								<i class="bi bi-person-plus me-1"></i> {translate key="user.register"}
							</a>
						</div>
					{/if}
				</div>
			</div>
		</div>
	</header>

	{* Wrapper for page content and sidebars *}
	{if $isFullWidth}
		{assign var=hasSidebar value=0}
	{/if}
	<div class="pkp_structure_content{if $hasSidebar} has_sidebar{/if}">
		<div class="pkp_structure_main" role="main">
			<a id="pkp_content_main"></a>
