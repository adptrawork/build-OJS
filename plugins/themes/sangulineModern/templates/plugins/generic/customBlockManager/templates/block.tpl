{**
 * SangulineModern theme override of
 * plugins/generic/customBlockManager/templates/block.tpl
 * (parent: Custom Block Manager plugin)
 *
 * Same output as the parent, plus:
 *   [baseUrl] in custom block content is replaced with the current site's
 *   base URL ($baseUrl — domain + path resolved at request time from
 *   configuration.inc.php). This keeps every custom block's internal links
 *   portable when the site is migrated between domains/hosts without
 *   touching the stored HTML.
 *
 * Usage in a custom block's content:
 *   <a href="[baseUrl]/index.php/jrdc/about">Sejarah Jurnal</a>
 * renders as:
 *   <a href="https://<host>/index.php/jrdc/about">Sejarah Jurnal</a>
 *}
{assign var="customBlockContent" value=$customBlockContent|replace:'[baseUrl]':$baseUrl}
<div class="pkp_block block_custom" id="{$customBlockId|escape}">
	<h2 class="title{if !$showName} pkp_screen_reader{/if}">{$customBlockTitle}</h2>
	<div class="content">
		{$customBlockContent}
	</div>
</div>
