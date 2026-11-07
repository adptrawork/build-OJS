{**
 * templates/frontend/components/header.tpl
 * Prototype (Bootstrap-based) theme — Site header
 * Maps prototype header (logo + nav + search + dark-mode toggle) to OJS 3.3 header.
 * Bootstrap 5 grid/utilities + custom CSS for exact prototype parity.
 *}
{strip}
	{* Determine active page for nav highlighting *}
	{assign var="currentPage" value=$requestedPage|default:"index"}
{/strip}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}" class="{if $activeTheme->getOption('enableDarkMode') != '0'}jrdc-has-darkmode{/if}">
<head>
	<meta charset="{$defaultCharset|escape}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>
		{$pageTitleTranslated|strip_tags}
		{* Add journal name *}
		{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
			| {$currentContext->getLocalizedName()}
		{/if}
	</title>

	{load_header context="frontend"}
	{load_stylesheet context="frontend"}
	{load_script context="frontend"}

	{* Early dark-mode to prevent flash *}
	<script>
		(function(){ldelim}
			try {ldelim}
				var m = localStorage.getItem('jrdc-theme-mode');
				if (m === 'dark' || (!m && window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches)) {ldelim}
					document.documentElement.classList.add('dark');
				{rdelim}
			{rdelim} catch(e) {ldelim}{rdelim}
		{rdelim})();
	</script>
</head>
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"} jrdc-body">

	<a class="jrdc-skip-link" href="#jrdc-main">{translate key="navigation.skip.main"}</a>

	<header class="jrdc-header" role="banner">
		<div class="jrdc-container">
			<div class="jrdc-header-inner">
				{* Brand *}
				<a class="jrdc-brand" href="{url page="index"}">
					{if $displayPageHeaderLogo}
						<span class="jrdc-brand-logo">
							<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" {if $displayPageHeaderLogo.altText}alt="{$displayPageHeaderLogo.altText|escape}"{else}alt="{$currentContext->getLocalizedName()|escape}"{/if}>
						</span>
					{elseif $displayPageHeaderTitle}
						<span class="jrdc-brand-logo" aria-hidden="true">
							<svg viewBox="0 0 64 64" width="36" height="36" fill="none" xmlns="http://www.w3.org/2000/svg">
								<rect x="4" y="4" width="56" height="56" rx="12" fill="#0F284E" stroke="#D4AF37" stroke-width="2"/>
								<path d="M18 42C23 39.5 28.5 39.8 32 42.5C35.5 39.8 41 39.5 46 42V26C41 23.5 35.5 23.8 32 26.5C28.5 23.8 23 23.5 18 26V42Z" fill="none" stroke="#FFFFFF" stroke-width="1.8"/>
								<line x1="32" y1="26.5" x2="32" y2="42.5" stroke="#FFFFFF" stroke-width="1.8"/>
							</svg>
						</span>
					{/if}
					<span class="jrdc-brand-text">
						<span class="jrdc-brand-title">
							{if $displayPageHeaderTitle && !$displayPageHeaderTitle && is_string($displayPageHeaderTitle)}
								{$displayPageHeaderTitle|escape}
							{elseif $currentContext}
								{$currentContext->getLocalizedName()|escape}
							{else}
								{$siteTitle|escape}
							{/if}
						</span>
						{if $currentContext}
							<span class="jrdc-brand-subtitle">{$currentContext->getData('publisherInstitution')|escape|default:""}</span>
						{/if}
					</span>
				</a>

				{* Desktop Navigation *}
				<nav class="jrdc-nav" aria-label="{translate key="common.navigation.site"}">
					{load_menu name="primary" id="jrdcPrimaryNav" ulClass="" liClass=""}
				</nav>

				{* Actions *}
				<div class="jrdc-header-actions">
					{* Search *}
					<form class="jrdc-search" action="{url page="search" op="search"}" method="post" role="search">
						{csrf}
						<input type="text" name="query" value="{$searchQuery|escape}" placeholder="{translate key="common.search"}..." aria-label="{translate key="common.search"}">
						<button type="submit" aria-label="{translate key="common.search"}">
							<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>
						</button>
					</form>

					{* Login / User *}
					{if $isUserLoggedIn}
						<a class="jrdc-btn jrdc-btn-dark" href="{url page="submissions"}">{translate key="navigation.dashboard"}</a>
					{else}
						<a class="jrdc-btn jrdc-btn-dark" href="{url page="login"}">{translate key="user.login"}</a>
					{/if}

					{* Dark mode *}
					{if $activeTheme->getOption('enableDarkMode') != '0'}
						<button type="button" class="jrdc-btn jrdc-btn-icon" data-jrdc-theme-toggle title="Toggle dark mode" aria-label="Toggle dark mode">
							<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
								<path d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>
							</svg>
						</button>
					{/if}

					{* Mobile toggle *}
					<button type="button" class="jrdc-nav-toggle" data-jrdc-nav-toggle aria-expanded="false" aria-controls="jrdcMobileNav" aria-label="{translate key="common.menu"}">
						<svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
							<path d="M4 6h16M4 12h16M4 18h16"/>
						</svg>
					</button>
				</div>
			</div>

			{* Mobile Navigation *}
			<nav id="jrdcMobileNav" class="jrdc-mobile-nav" data-jrdc-mobile-nav aria-label="{translate key="common.navigation.site"}">
				{load_menu name="primary" id="jrdcMobilePrimary" ulClass="" liClass=""}
			</nav>
		</div>
	</header>
