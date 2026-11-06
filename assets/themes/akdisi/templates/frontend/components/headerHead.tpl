{**
 * @file plugins/themes/akdisi/templates/frontend/components/headerHead.tpl
 *
 * Override theme JRDC untuk <head>:
 *   - canonical URL
 *   - Open Graph + Twitter Card
 *   - JSON-LD diinject lewat AkdisiSeoPlugin::addHeader
 *   - menghilangkan generator OJS
 *}
<head>
	<meta charset="{$defaultCharset|escape}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>
		{$pageTitleTranslated|strip_tags}
		{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
			| {$currentContext->getLocalizedName()}
		{/if}
	</title>

	{* Canonical — satu URL utama per halaman *}
	<link rel="canonical" href="{$akdisiCanonicalUrl|default:$baseUrl|escape}">

	{* Open Graph *}
	<meta property="og:site_name" content="{$currentContext->getLocalizedName()|escape}">
	<meta property="og:locale" content="{$akdisiLocale|default:$currentLocale|escape}">
	<meta property="og:type" content="{if $akdisiCurrentPublication}article{else}website{/if}">
	<meta property="og:url" content="{$akdisiCanonicalUrl|default:$baseUrl|escape}">
	<meta property="og:title" content="{$pageTitleTranslated|strip_tags|escape}">
	{if $currentContext && $currentContext->getLocalizedDescription()}
		<meta property="og:description" content="{$currentContext->getLocalizedDescription()|strip_tags|truncate:300|escape}">
	{/if}
	{if $akdisiCurrentPublication}
		{assign var="_ogTitle" value=$akdisiCurrentPublication->getLocalizedTitle()}
		<meta property="og:title" content="{$_ogTitle|strip_tags|escape}">
		{assign var="_abstract" value=$akdisiCurrentPublication->getLocalizedData('abstract')}
		{if $_abstract}
			<meta property="og:description" content="{$_abstract|strip_tags|truncate:300|escape}">
		{/if}
	{/if}

	{* Twitter Card *}
	<meta name="twitter:card" content="summary">
	<meta name="twitter:title" content="{$pageTitleTranslated|strip_tags|escape}">

	{* Semua header lain (favicon, alternate, JSON-LD dari plugin, dsb). *}
	{* Generator OJS dihapus via regex untuk tidak memaparkan versi runtime. *}
	{capture name="akdisiHeaders"}{load_header context="frontend"}{/capture}
	{$smarty.capture.akdisiHeaders|regex_replace:'/<meta name="generator"[^>]*>\s*/i':''}
	{load_stylesheet context="frontend"}
</head>
