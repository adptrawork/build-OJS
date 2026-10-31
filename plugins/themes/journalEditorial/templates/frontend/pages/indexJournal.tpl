{**
 * @file plugins/themes/journalEditorial/templates/frontend/pages/indexJournal.tpl
 *
 * Homepage Jurnal Editorial (Stitch-inspired). Struktur modular.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="page_index_journal je-home">

	{* Hero / Journal Introduction *}
	{include file="frontend/components/homepage/hero.tpl"}

	{* Statistics strip *}
	{include file="frontend/components/homepage/statistics.tpl"}

	{* Latest Research Articles *}
	{include file="frontend/components/homepage/latestArticles.tpl"}

	{* Transparent Editorial & Publication Flow *}
	{include file="frontend/components/homepage/publicationFlow.tpl"}

	{* Current Issue *}
	{include file="frontend/components/homepage/currentIssue.tpl"}

	{* Announcements *}
	{include file="frontend/components/homepage/announcements.tpl"}

	{* Journal Identity & Specifications *}
	{include file="frontend/components/homepage/journalIdentity.tpl"}

	{* Indexing & Abstracting *}
	{include file="frontend/components/homepage/indexing.tpl"}

	{* For Authors / CTA *}
	{include file="frontend/components/homepage/authorResources.tpl"}

</div>

{include file="frontend/components/footer.tpl"}
