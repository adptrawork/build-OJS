{**
 * @file plugins/themes/akdisi/templates/frontend/pages/indexJournal.tpl
 *
 * Override theme AKDISI. Layout beranda mengikuti PRD §7 (S-HOME-01..13).
 * Setiap section dipecah menjadi komponen terpisah agar mudah dipelajari.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="page_index_journal akdisi-home">

	{* S-HOME-02/03/04: hero section *}
	{include file="frontend/components/hero.tpl"}

	{* S-HOME-12: strip statistik *}
	{include file="frontend/components/statsStrip.tpl"}

	{* S-HOME-05: tentang jurnal *}
	{include file="frontend/components/aboutJournal.tpl"}

	{* S-HOME-06: strip pengindeks *}
	{include file="frontend/components/indexers.tpl"}

	{* S-HOME-07: artikel terbaru per section *}
	{include file="frontend/components/latestBySection.tpl"}

	{* S-HOME-08: current issue TOC *}
	{include file="frontend/components/currentIssue.tpl"}

	{* S-HOME-13: publication workflow timeline *}
	{include file="frontend/components/publicationTimeline.tpl"}

	{* S-HOME-09/10/11: sidebar *}
	{include file="frontend/components/sidebar.tpl"}

</div>

{include file="frontend/components/footer.tpl"}
