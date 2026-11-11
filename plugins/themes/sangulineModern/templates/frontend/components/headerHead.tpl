{**
 * templates/frontend/components/headerHead.tpl
 *
 * SangulineModern override: same head contract as OJS 3.3 core, plus an
 * inline anti-flash script so the saved dark mode applies before first paint,
 * plus SEO essentials (meta description, canonical, Open Graph, Twitter Card
 * and JSON-LD structured data) built from page context — no core files
 * touched, no plugins required.
 *}
<head>
	<meta charset="{$defaultCharset|escape}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="theme-color" content="#ffffff" media="(prefers-color-scheme: light)">
	<meta name="theme-color" content="#0b1220" media="(prefers-color-scheme: dark)">
	<title>
		{$pageTitleTranslated|strip_tags}
		{* Add the journal name to the end of page titles *}
		{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
			| {$currentContext->getLocalizedName()}
		{/if}
	</title>

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

	<script>
	(function () {
		try {
			if (localStorage.getItem('jrdc-theme') === 'dark') {
				document.documentElement.classList.add('dark');
				document.documentElement.setAttribute('data-bs-theme', 'dark');
			}
		} catch (e) { /* localStorage unavailable */ }
	})();
	</script>

	{load_header context="frontend"}
	{load_stylesheet context="frontend"}

	{* ================= SEO: description, canonical, OG/Twitter, JSON-LD ================= *}

	{* --- meta description (≤158 chars, single line) --- *}
	{if $publication && $publication->getLocalizedData('abstract')}
		{assign var="seoDescription" value=$publication->getLocalizedData('abstract')|strip_tags:true}
	{elseif $currentContext && $currentContext->getLocalizedData('description')}
		{assign var="seoDescription" value=$currentContext->getLocalizedData('description')|strip_tags:true}
	{elseif $currentContext}
		{assign var="seoDescription" value=$currentContext->getLocalizedData('name')}
	{else}
		{assign var="seoDescription" value=$siteTitle}
	{/if}
	{assign var="seoDescription" value=$seoDescription|replace:"\n":" "|replace:"\r":" "|regex_replace:'/\s{2,}/':' '|trim|truncate:158:''}
	<meta name="description" content="{$seoDescription|escape}">

	{* --- canonical URL (article/issue paths resolved; galley views canonicalize to the article) --- *}
	{capture assign="canonicalUrl"}{/capture}
	{if $requestedPage == 'article' && $article}
		{capture assign="canonicalUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
	{elseif $requestedPage == 'issue' && $issue}
		{capture assign="canonicalUrl"}{url page="issue" op="view" path=$issue->getBestIssueId()}{/capture}
	{elseif $requestedPage}
		{if $requestedOp && $requestedOp != 'index'}
			{capture assign="canonicalUrl"}{url page=$requestedPage op=$requestedOp}{/capture}
		{else}
			{capture assign="canonicalUrl"}{url page=$requestedPage}{/capture}
		{/if}
	{else}
		{capture assign="canonicalUrl"}{url page="index" router=$smarty.const.ROUTE_PAGE}{/capture}
	{/if}
	{assign var="canonicalUrl" value=$canonicalUrl|trim}
	<link rel="canonical" href="{$canonicalUrl|escape}">

	{* --- Open Graph + Twitter Card --- *}
	{assign var="ogImageUrl" value=$baseUrl|cat:"/public/journals/1/homepageImage_en_US.png"}
	<meta property="og:site_name" content="{$currentContext->getLocalizedData('name')|escape}">
	<meta property="og:type" content="{if $publication}article{else}website{/if}">
	<meta property="og:title" content="{$pageTitleTranslated|strip_tags|escape}">
	<meta property="og:description" content="{$seoDescription|escape}">
	<meta property="og:url" content="{$canonicalUrl|escape}">
	<meta property="og:image" content="{$ogImageUrl|escape}">
	<meta property="og:image:alt" content="{$currentContext->getLocalizedData('name')|escape}">
	<meta property="og:locale" content="{$currentLocale|replace:'_':'_'}">
	<meta name="twitter:card" content="summary_large_image">
	<meta name="twitter:title" content="{$pageTitleTranslated|strip_tags|escape}">
	<meta name="twitter:description" content="{$seoDescription|escape}">
	<meta name="twitter:image" content="{$ogImageUrl|escape}">

	{* --- JSON-LD: Organization + WebSite (sitewide) --- *}
	<script type="application/ld+json">{ldelim}"@context":"https://schema.org","@type":"Organization","name":"{$currentContext->getLocalizedData('name')|escape:'javascript'}","alternateName":"{$currentContext->getLocalizedData('acronym')|default:'JRDC'|escape:'javascript'}","url":"{$baseUrl}/index.php/jrdc/"{if $currentContext->getData('contactEmail')},"email":"{$currentContext->getData('contactEmail')|escape:'javascript'}"{/if}{rdelim}</script>
	<script type="application/ld+json">{ldelim}"@context":"https://schema.org","@type":"WebSite","name":"{$currentContext->getLocalizedData('name')|escape:'javascript'}","url":"{$baseUrl}/index.php/jrdc/","inLanguage":"{$currentLocale|replace:'_':'-'}","publisher":{ldelim}"@type":"Organization","name":"{$currentContext->getLocalizedData('name')|escape:'javascript'}"{rdelim}{rdelim}</script>

	{* --- JSON-LD: ScholarlyArticle (article pages only) --- *}
	{if $publication}
		{assign var="jsonLdTitle" value=$publication->getLocalizedTitle()|strip_unsafe_html|escape:'javascript'}
		{assign var="articleAuthors" value=$publication->getData('authors')}
		{assign var="articleDoi" value=$article->getStoredPubId('doi')}
		{assign var="articleKeywords" value=$publication->getLocalizedData('keywords')}
	<script type="application/ld+json">{ldelim}"@context":"https://schema.org","@type":"ScholarlyArticle","headline":"{$jsonLdTitle}","mainEntityOfPage":"{$canonicalUrl|escape:'javascript'}","datePublished":"{$publication->getData('datePublished')}","dateReceived":"{$article->getData('dateSubmitted')|date_format:"%Y-%m-%d"}","pagination":"{$publication->getLocalizedData('pages')|escape:'javascript'}",{if $articleKeywords}"keywords":{$articleKeywords|@json_encode},{/if}"isPartOf":{ldelim}"@type":"Periodical","name":"{$currentContext->getLocalizedData('name')|escape:'javascript'}","issn":"2049-3630"{rdelim},"publisher":{ldelim}"@type":"Organization","name":"Yayasan Ratu Dirgantara Cendekiawan"{rdelim},"author":[{foreach name=jsonAuthors from=$articleAuthors item=author}{ldelim}"@type":"Person","name":"{$author->getFullName()|escape:'javascript'}"{rdelim}{if $smarty.foreach.jsonAuthors.iteration < $articleAuthors|@count},{/if}{/foreach}]{if $articleDoi},"identifier":{ldelim}"@type":"PropertyValue","propertyID":"doi","value":"{$articleDoi|escape:'javascript'}"{rdelim}{/if}{rdelim}</script>
	{/if}
</head>
