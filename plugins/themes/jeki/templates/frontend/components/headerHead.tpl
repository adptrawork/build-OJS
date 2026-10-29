{**
 * Override theme JEKI: head dengan canonical, OG, dan JSON-LD.
 * Slot SEO mengikuti PRD §7.
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

	{* Canonical *}
	<link rel="canonical" href="{$baseUrl}{$smarty.server.REQUEST_URI|escape|regex_replace:"/\?.*$/":""}">

	{* Open Graph *}
	<meta property="og:site_name" content="{$currentContext->getLocalizedName()|escape}">
	<meta property="og:title" content="{$pageTitleTranslated|strip_tags|escape}">
	<meta property="og:type" content="{if $publication}article{else}website{/if}">
	<meta property="og:url" content="{$baseUrl}{$smarty.server.REQUEST_URI|escape|regex_replace:"/\?.*$/":""}">

	{* JSON-LD *}
	{if $publication}
	<script type="application/ld+json">
	{literal}{"@context":"https://schema.org","@type":"ScholarlyArticle","headline":{/literal}{$publication->getLocalizedTitle()|json_encode}{literal},"datePublished":{/literal}{$publication->getData('datePublished')|json_encode}{literal}}{/literal}
	</script>
	{elseif $currentContext}
	<script type="application/ld+json">
	{literal}{"@context":"https://schema.org","@type":"Periodical","name":{/literal}{$currentContext->getLocalizedName()|json_encode}{literal}}{/literal}
	</script>
	{/if}

	{load_header context="frontend"}
	{load_stylesheet context="frontend"}
</head>
