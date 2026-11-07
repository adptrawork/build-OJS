{**
 * templates/frontend/components/header.tpl
 *}
{strip}
	{assign var="currentPage" value=$requestedPage|default:"index"}
{/strip}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}" class="jrdc-html">
<head>
	<meta charset="{$defaultCharset|escape}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>
		{$pageTitleTranslated|strip_tags}
		{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
			| {$currentContext->getLocalizedName()}
		{/if}
	</title>

	{load_header context="frontend"}
	{load_stylesheet context="frontend"}
	{load_script context="frontend"}

	<script>
		(function(){
			try {
				var m = localStorage.getItem('jrdc-theme-mode');
				if (m === 'dark' || (!m && window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
					document.documentElement.classList.add('dark');
				}
			} catch(e) {}
		})();
	</script>
</head>
<body class="jrdc-body">

	<a class="jrdc-skip-link" href="#jrdc-main">{translate key="navigation.skip.main"}</a>

	<header class="jrdc-header">
		<div class="jrdc-container jrdc-header-inner">
			<a class="jrdc-brand" href="{url page="index"}">
				<div class="jrdc-brand-logo-box">
					<svg viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
						<defs>
							<linearGradient id="navHeaderBlue" x1="0%" y1="0%" x2="100%" y2="100%">
								<stop offset="0%" stop-color="#0F284E"></stop>
								<stop offset="100%" stop-color="#0A192F"></stop>
							</linearGradient>
							<linearGradient id="navHeaderGold" x1="0%" y1="0%" x2="100%" y2="100%">
								<stop offset="0%" stop-color="#F6D365"></stop>
								<stop offset="100%" stop-color="#D4AF37"></stop>
							</linearGradient>
						</defs>
						<rect x="4" y="4" width="56" height="56" rx="12" fill="url(#navHeaderBlue)" stroke="url(#navHeaderGold)" stroke-width="2"></rect>
						<path d="M18 42C23 39.5 28.5 39.8 32 42.5C35.5 39.8 41 39.5 46 42V26C41 23.5 35.5 23.8 32 26.5C28.5 23.8 23 23.5 18 26V42Z" fill="none" stroke="#FFFFFF" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" opacity="0.9"></path>
						<line x1="32" y1="26.5" x2="32" y2="42.5" stroke="#FFFFFF" stroke-width="1.8" stroke-linecap="round" opacity="0.9"></line>
						<path d="M20 35L27 29L33 32L43 20" fill="none" stroke="url(#navHeaderGold)" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"></path>
						<path d="M38 20H43V25" fill="none" stroke="url(#navHeaderGold)" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"></path>
						<circle cx="32" cy="17" r="1.8" fill="url(#navHeaderGold)"></circle>
					</svg>
				</div>
				<div class="jrdc-brand-text">
					<span class="jrdc-brand-title">Jurnal Ratu Dirgantara</span>
					<span class="jrdc-brand-subtitle">Cendekiawan</span>
				</div>
			</a>

			<nav class="jrdc-nav desktop-only">
				<a href="{url page="index"}" class="jrdc-nav-link {if $currentPage == 'index'}active{/if}">Beranda</a>
				<a href="{url page="issue" op="archive"}" class="jrdc-nav-link {if $currentPage == 'issue' && $requestedOp == 'archive'}active{/if}">Arsip</a>

				<div class="jrdc-dropdown">
					<button class="jrdc-nav-link jrdc-dropdown-btn">
						Tentang
						<svg class="jrdc-dropdown-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7"></path></svg>
					</button>
					<div class="jrdc-dropdown-menu">
						<a href="{url page="about"}">Tentang Jurnal</a>
						<a href="{url page="about" op="editorialTeam"}">Dewan Redaksi</a>
						<a href="{url page="about"}">Kebijakan Etika</a>
						<a href="{url page="about" op="contact"}">Kontak</a>
					</div>
				</div>

				<a href="{url page="announcement"}" class="jrdc-nav-link {if $currentPage == 'announcement'}active{/if}">Pengumuman</a>
			</nav>

			<div class="jrdc-header-actions">
				<form class="jrdc-search desktop-only" action="{url page="search" op="search"}" method="post">
					{csrf}
					<input type="text" name="query" placeholder="Cari artikel..." value="{$searchQuery|escape}">
					<button type="submit">
						<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"></circle><path stroke-linecap="round" stroke-linejoin="round" d="m21 21-4.35-4.35"></path></svg>
					</button>
				</form>

				{if $isUserLoggedIn}
					<a class="jrdc-btn-dark" href="{url page="submissions"}">Dashboard</a>
				{else}
					<a class="jrdc-btn-dark" href="{url page="login"}">Masuk</a>
				{/if}

				<button class="jrdc-btn-icon desktop-only" onclick="document.documentElement.classList.toggle('dark')">
					<svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path></svg>
				</button>

				<button class="jrdc-mobile-toggle mobile-only" id="jrdc-mobile-btn">
					<svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M4 6h16M4 12h16M4 18h16"></path></svg>
				</button>
			</div>
		</div>
	</header>

	<div id="jrdc-mobile-nav" class="jrdc-mobile-nav">
		<a href="{url page="index"}">Beranda</a>
		<a href="{url page="issue" op="archive"}">Arsip</a>
		<a href="{url page="about"}">Tentang Jurnal</a>
		<a href="{url page="about" op="editorialTeam"}">Dewan Redaksi</a>
		<a href="{url page="announcement"}">Pengumuman</a>
	</div>

	<main id="jrdc-main" class="jrdc-main">
