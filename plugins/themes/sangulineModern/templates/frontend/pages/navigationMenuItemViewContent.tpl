{**
 * Theme override of frontend/pages/navigationMenuItemViewContent.tpl
 * (SangulineModern)
 *
 * Core template places the breadcrumb outside the .page card, while the
 * about/contact/privacy/editorialTeam pages place it inside. Move it in
 * for consistency. Also drops the unused $isPreview variable handling.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$title}

<div class="page">
	{include file="frontend/components/breadcrumbs.tpl" currentTitle=$title}
	<h1 class="page_title">{$title|escape}</h1>
	{$content}
</div>

{include file="frontend/components/footer.tpl"}
