{**
 * Theme override of plugins/generic/staticPages/templates/content.tpl
 * (SangulineModern)
 *
 * Core plugin template renders static pages without a breadcrumb and with
 * an h2 heading, while every other content page (about, submissions,
 * editorialTeam, privacy, contact, custom nav menu pages) renders
 * "Beranda / Title" breadcrumbs + h1.page_title. This override matches
 * navigationMenuItemViewContent.tpl so all pages share the same chrome.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$title}

<div class="page">
	{include file="frontend/components/breadcrumbs.tpl" currentTitle=$title}
	<h1 class="page_title">{$title|escape}</h1>
	{$content}
</div>

{include file="frontend/components/footer.tpl"}
