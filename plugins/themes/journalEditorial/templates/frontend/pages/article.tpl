{**
 * Override theme AKDISI. Slot S-ART-01..10 mengikuti PRD §4.2.
 * Markup inti diwarisi dari default (article_details.tpl); slot ditandai
 * lewat atribut data-slot pada pembungkus utama.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$article->getCurrentPublication()->getLocalizedFullTitle(null, 'html')|strip_unsafe_html}

<div class="page page_article" data-slot="S-ART-01">
	{if $section}
		{include file="frontend/components/breadcrumbs_article.tpl" currentTitle=$section->getLocalizedTitle()}
	{else}
		{include file="frontend/components/breadcrumbs_article.tpl" currentTitleKey="common.publication"}
	{/if}

	<div data-slot="S-ART-02">
		{include file="frontend/objects/article_details.tpl"}
	</div>

	{call_hook name="Templates::Article::Footer::PageFooter"}

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
