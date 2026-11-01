{**
 * @file plugins/themes/journalEditorial/templates/frontend/pages/indexJournal.tpl
 *
 * JILP-inspired homepage. Full-width, Bootstrap 5 based.
 *}
{assign var="isFullWidth" value=true}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="page_index_journal jilp-home" id="main-content">

	{include file="frontend/components/homepage/hero.tpl"}
	{include file="frontend/components/homepage/currentIssue.tpl"}
	{include file="frontend/components/homepage/statistics.tpl"}
	{include file="frontend/components/homepage/editorPicks.tpl"}
	{include file="frontend/components/homepage/tabs.tpl"}
	{include file="frontend/components/homepage/indexing.tpl"}
	{include file="frontend/components/homepage/authorResources.tpl"}
	{include file="frontend/components/homepage/whyPublish.tpl"}

	{if $additionalHomeContent}
		<section class="container py-4 mb-5">
			<div class="jilp-additional-content">
				{$additionalHomeContent}
			</div>
		</section>
	{/if}

</div>

{include file="frontend/components/footer.tpl"}
