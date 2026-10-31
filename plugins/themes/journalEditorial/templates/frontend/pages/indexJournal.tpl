{**
 * @file plugins/themes/journalEditorial/templates/frontend/pages/indexJournal.tpl
 *
 * Homepage Jurnal Editorial (JILP-inspired). Struktur modular.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="page_index_journal je-home">

	{* Hero / Journal Introduction *}
	{include file="frontend/components/homepage/hero.tpl"}

	{* Statistics strip *}
	{include file="frontend/components/homepage/statistics.tpl"}

	{* Editor's Pick *}
	{include file="frontend/components/homepage/editorPicks.tpl"}

	{* Latest Articles *}
	{include file="frontend/components/homepage/latestArticles.tpl"}

	{* Current Issue + Archive *}
	{include file="frontend/components/homepage/currentIssue.tpl"}

	{* Announcements / News *}
	{include file="frontend/components/homepage/announcements.tpl"}

	{* Journal Identity & Specifications *}
	{include file="frontend/components/homepage/journalIdentity.tpl"}

	{* Indexing & Abstracting *}
	{include file="frontend/components/homepage/indexing.tpl"}

	{* For Authors / CTA *}
	{include file="frontend/components/homepage/authorResources.tpl"}

	{* Why Publish Here *}
	{include file="frontend/components/homepage/whyPublish.tpl"}

</div>

{include file="frontend/components/footer.tpl"}
