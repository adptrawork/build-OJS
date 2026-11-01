{**
 * Override theme AKDISI. Slot S-ART-01..10 mengikuti PRD §4.2.
 * Markup inti diwarisi dari default (article_details.tpl); slot ditandai
 * lewat atribut data-slot pada pembungkus utama.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$article->getCurrentPublication()->getLocalizedFullTitle(null, 'html')|strip_unsafe_html}

<div class="page page_article" data-slot="S-ART-01">
	<div data-slot="S-ART-02">
		{include file="frontend/objects/article_details.tpl"}
	</div>

	<div data-slot="S-ART-PDF">
		{include file="frontend/components/article_pdf_embed.tpl"}
	</div>

	{call_hook name="Templates::Article::Footer::PageFooter"}

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
