{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Override theme JEKI. Slot konten mengikuti PRD §7 (S-HOME-01..13).
 * Slot tanpa data tidak dirender (kecuali S-HOME-04 yang punya empty state).
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="page_index_journal jeki-home">

	{* S-HOME-01: bar atas — disembunyikan bila setting kosong *}
	{if $jekiTopbar}
		<div class="jeki-topbar" data-slot="S-HOME-01">{$jekiTopbar}</div>
	{/if}

	{* S-HOME-02/03: hero *}
	<header class="jeki-hero" data-slot="S-HOME-02">
		<div class="jeki-hero__text">
			<h1>{$currentContext->getLocalizedName()|escape}</h1>
			{if $jekiTagline}
				<p class="jeki-hero__tagline">{$jekiTagline|escape}</p>
			{/if}
			<div class="jeki-hero__cta" data-slot="S-HOME-03">
				<a class="jeki-btn jeki-btn--primary" href="{url page="submissions"}">{translate key="navigation.submissions"}</a>
				<a class="jeki-btn" href="{url page="about" op="submissions"}">{translate key="about.submissions"}</a>
			</div>
		</div>
		{* S-HOME-04: sampul issue terkini *}
		{if $issue}
			<div class="jeki-hero__issue" data-slot="S-HOME-04">
				{if $issue->getCoverImage()}
					<img src="{$publicFilesDir}/{$issue->getCoverImage()->uploadName|escape:"url"}" alt="{$issue->getIssueIdentification()|escape}" loading="lazy">
				{/if}
				<div class="jeki-hero__issue-meta">
					<span class="jeki-eyebrow">{translate key="journal.currentIssue"}</span>
					<span class="jeki-issue-id">{$issue->getIssueIdentification()|escape}</span>
				</div>
			</div>
		{else}
			<div class="jeki-hero__issue jeki-empty" data-slot="S-HOME-04">{translate key="issue.noIssues"}</div>
		{/if}
	</header>

	{* S-HOME-05: ringkasan "About the Journal" *}
	{if $journalDescription}
		<section class="jeki-about" data-slot="S-HOME-05">
			<h2>{translate key="about.aboutContext"}</h2>
			<div class="jeki-about__body">{$journalDescription|strip_tags|truncate:600}</div>
		</section>
	{/if}

	{* S-HOME-06: strip logo pengindeks — custom block, render kalau ada *}
	{if $jekiIndexers}
		<div class="jeki-indexers" data-slot="S-HOME-06">{$jekiIndexers}</div>
	{/if}

	{* S-HOME-07: artikel terbaru — diisi lewat hook ThemePlugin (lihat JekiThemePlugin) *}
	{if $jekiLatestArticles && $jekiLatestArticles|@count}
		<section class="jeki-latest" data-slot="S-HOME-07">
			<h2>{translate key="navigation.categories.browse"}</h2>
			<div class="jeki-latest__grid">
				{foreach from=$jekiLatestArticles item=a}
					<article class="jeki-card">
						<h3><a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="article" op="view" path=$a->id}">{$a->title|escape}</a></h3>
					</article>
				{/foreach}
			</div>
		</section>
	{/if}

	{* S-HOME-08: pengumuman *}
	{include file="frontend/objects/announcements_list.tpl" numAnnouncements=$numAnnouncementsHomepage}

	{* S-HOME-04 (lanjutan): TOC issue terkini *}
	{if $issue}
		<section class="jeki-current-issue" data-slot="S-HOME-04">
			{include file="frontend/objects/issue_toc.tpl" heading="h2"}
			<a href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}" class="jeki-read-more">{translate key="journal.viewAllIssues"}</a>
		</section>
	{/if}

	{* S-HOME-09/10/11: sidebar — disembunyikan bila kosong *}
	<aside class="jeki-sidebar">
		{if $jekiFocusScope}
			<section data-slot="S-HOME-09"><h3>Focus &amp; Scope</h3>{$jekiFocusScope}</section>
		{/if}
		{if $jekiEditorialTeam}
			<section data-slot="S-HOME-10"><h3>Editorial Team</h3>{$jekiEditorialTeam}</section>
		{/if}
		{if $jekiTemplateFile}
			<a data-slot="S-HOME-11" class="jeki-btn" href="{$jekiTemplateFile}">Article Template</a>
		{/if}
	</aside>

	{* S-HOME-12/13: footer ditangani footer.tpl; slot dicatat lewat data-slot di bawah *}
	<div class="jeki-footer-slots" data-slot="S-HOME-12"></div>
	<div class="jeki-footer-slots" data-slot="S-HOME-13"></div>

</div>

{include file="frontend/components/footer.tpl"}
