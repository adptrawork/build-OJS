{**
 * templates/frontend/pages/indexJournal.tpl
 * JRDC Theme — Journal homepage
 * Uses default OJS data (currentIssue, announcements, journal description, etc.)
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentContext->getLocalizedName()}

{assign var="sidebarPos" value=$activeTheme->getOption('sidebarPosition')|default:'right'}
{assign var="showHeroCover" value=$activeTheme->getOption('showHeroCover')|default:'1'}
{assign var="showJournalDesc" value=$activeTheme->getOption('showJournalDescription')|default:'1'}
{assign var="showAnnouncements" value=$activeTheme->getOption('showAnnouncementsOnHomepage')|default:'1'}
{assign var="showCurrentArticles" value=$activeTheme->getOption('showCurrentIssueArticles')|default:'1'}
{assign var="annCount" value=$activeTheme->getOption('announcementsHomepageCount')|default:3}
{assign var="heroEyebrow" value=$activeTheme->getOption('heroEyebrow')}

<main id="jrdc-main" class="jrdc-main">
	{* ========== HERO ========== *}
	<section class="jrdc-hero">
		<div class="jrdc-container">
			<div class="jrdc-hero-banner">
				<div class="jrdc-hero-grid">
					<div>
						{if $heroEyebrow}
							<div class="jrdc-hero-eyebrow">{$heroEyebrow|escape}</div>
						{/if}
						<h1 class="jrdc-hero-title">
							{$currentContext->getLocalizedName()|escape}
						</h1>
						{if $currentContext->getLocalizedDescription()}
							<p class="jrdc-hero-desc">
								{$currentContext->getLocalizedDescription()|strip_tags|truncate:280}
							</p>
						{/if}

						<dl class="jrdc-hero-meta">
							{if $currentContext->getData('publishingMode') || $currentIssue}
								<div>
									<dt>TERBITAN</dt>
									<dd>
										{if $currentIssue}
											{$currentIssue->getIssueIdentification()|escape}
										{else}
											—
										{/if}
									</dd>
								</div>
							{/if}
							{if $currentContext->getData('publisherInstitution')}
								<div>
									<dt>PUBLISHER</dt>
									<dd>{$currentContext->getData('publisherInstitution')|escape}</dd>
								</div>
							{/if}
						</dl>
					</div>

					{if $showHeroCover == '1' && $currentIssue}
						<div class="jrdc-hero-cover">
							{if $currentIssue->getLocalizedCoverImageUrl()}
								<a href="{url page="issue" op="view" path=$currentIssue->getBestIssueId()}">
									<img src="{$currentIssue->getLocalizedCoverImageUrl()|escape}" alt="{$currentIssue->getLocalizedCoverImageAltText()|escape|default:$currentIssue->getIssueIdentification()|escape}">
								</a>
							{else}
								{* CSS-drawn fallback cover (prototype parity) *}
								<div class="jrdc-cover" aria-hidden="true">
									<svg viewBox="0 0 64 64" width="96" height="96" fill="none" xmlns="http://www.w3.org/2000/svg">
										<rect x="4" y="4" width="56" height="56" rx="12" fill="#0F284E" stroke="#D4AF37" stroke-width="2"/>
										<path d="M18 42C23 39.5 28.5 39.8 32 42.5C35.5 39.8 41 39.5 46 42V26C41 23.5 35.5 23.8 32 26.5C28.5 23.8 23 23.5 18 26V42Z" fill="none" stroke="#FFFFFF" stroke-width="1.8"/>
										<line x1="32" y1="26.5" x2="32" y2="42.5" stroke="#FFFFFF" stroke-width="1.8"/>
									</svg>
									<span>{$currentContext->getLocalizedName()|escape|truncate:24}</span>
								</div>
							{/if}
						</div>
					{/if}
				</div>
			</div>
		</div>
	</section>

	{* ========== MAIN CONTENT ========== *}
	<div class="jrdc-container" style="margin-top:2.5rem;">
		<div class="jrdc-grid jrdc-grid-12 jrdc-layout--sidebar-{$sidebarPos|escape}">
			<div class="jrdc-main-col jrdc-col-8 space-y-8" style="display:grid;gap:2rem;">

				{* Journal Description / About *}
				{if $showJournalDesc == '1' && $currentContext->getLocalizedDescription()}
					<section class="jrdc-card">
						<h2 class="jrdc-card-title">{translate key="about.aboutContext"}</h2>
						<div class="jrdc-prose">
							{$currentContext->getLocalizedDescription()}
						</div>

						{* Quick info cards from custom blocks or static *}
						<div class="jrdc-info-grid" style="grid-template-columns: repeat(3, 1fr);">
							<a href="{url page="about" op="editorialTeam"}" class="jrdc-info-card">
								<h3>Dewan Editor</h3>
								<p>Tim editor dan reviewer jurnal.</p>
							</a>
							<a href="{url page="about" op="submissions"}" class="jrdc-info-card">
								<h3>Panduan Penulis</h3>
								<p>Pedoman penulisan dan pengiriman naskah.</p>
							</a>
							<a href="{url page="about"}" class="jrdc-info-card">
								<h3>Tentang Jurnal</h3>
								<p>Profil dan informasi jurnal.</p>
							</a>
						</div>
					</section>
				{/if}

				{* Announcements *}
				{if $showAnnouncements == '1' && $numAnnouncementsHomepage && $announcements|@count}
					<section class="jrdc-card">
						<h2 class="jrdc-card-title">{translate key="announcement.announcements"}</h2>
						<ul class="jrdc-announce-list">
							{foreach name=ann from=$announcements item=announcement}
								{if $smarty.foreach.ann.iteration > $annCount}{break}{/if}
								<li class="jrdc-announce-item">
									<div class="jrdc-date-badge">
										<strong>{$announcement->getDatePosted()|date_format:"%d"}</strong>
										<small>{$announcement->getDatePosted()|date_format:"%b"}</small>
									</div>
									<div>
										<h3 class="jrdc-announce-title">
											<a href="{url page="announcement" op="view" path=$announcement->getId()}">
												{$announcement->getLocalizedTitle()|escape}
											</a>
										</h3>
										{if $announcement->getLocalizedDescriptionShort()}
											<p class="jrdc-announce-excerpt">{$announcement->getLocalizedDescriptionShort()|strip_tags|truncate:160}</p>
										{/if}
									</div>
								</li>
							{/foreach}
						</ul>
						{if $announcements|@count > $annCount}
							<p style="margin-top:1.25rem;margin-bottom:0;">
								<a href="{url page="announcement"}" class="jrdc-btn jrdc-btn-primary">{translate key="common.more"}</a>
							</p>
						{/if}
					</section>
				{/if}

				{* Current Issue Articles *}
				{if $showCurrentArticles == '1' && $currentIssue}
					<section class="jrdc-card">
						<div style="display:flex;justify-content:space-between;align-items:baseline;flex-wrap:wrap;gap:0.75rem;margin-bottom:1.5rem;padding-bottom:1rem;border-bottom:1px solid var(--jrdc-slate-100);">
							<h2 class="jrdc-card-title" style="margin:0;padding:0;border:0;">
								{translate key="journal.currentIssue"}
							</h2>
							<a href="{url page="issue" op="view" path=$currentIssue->getBestIssueId()}" style="font-size:0.875rem;font-weight:600;">
								{$currentIssue->getIssueIdentification()|escape} →
							</a>
						</div>

						{foreach from=$publishedSubmissions item=section}
							{if $section.articles}
								{if $section.title}
									<div class="jrdc-section-label">{$section.title|escape}</div>
								{/if}
								<ul class="jrdc-article-list">
									{foreach from=$section.articles item=article}
										{include file="frontend/objects/article_summary.tpl" article=$article hideGalleys=false}
									{/foreach}
								</ul>
							{/if}
						{/foreach}

						{if !$publishedSubmissions}
							<div class="jrdc-empty" style="border:2px dashed var(--jrdc-slate-300);border-radius:0.75rem;padding:2rem;text-align:center;color:var(--jrdc-slate-500);">
								<p>Belum ada artikel</p>
							</div>
						{/if}
					</section>
				{/if}

				{* Additional Homepage Content (from Website Settings) *}
				{if $additionalHomeContent}
					<section class="jrdc-card">
						<div class="jrdc-prose">
							{$additionalHomeContent}
						</div>
					</section>
				{/if}

			</div>{* /.jrdc-main-col *}

			{* Sidebar *}
			{if $sidebarPos != 'none'}
				<aside class="jrdc-side-col jrdc-col-4" role="complementary">
					{if $currentIssue && $currentIssue->getLocalizedCoverImageUrl() && $showHeroCover != '1'}
						<div class="jrdc-side-card">
							<a href="{url page="issue" op="view" path=$currentIssue->getBestIssueId()}">
								<img src="{$currentIssue->getLocalizedCoverImageUrl()|escape}" alt="{$currentIssue->getLocalizedCoverImageAltText()|escape}" style="border-radius:0.75rem;width:100%;">
							</a>
							<p style="margin:0.75rem 0 0;font-size:0.8125rem;text-align:center;">
								<a href="{url page="issue" op="view" path=$currentIssue->getBestIssueId()}">{$currentIssue->getIssueIdentification()|escape}</a>
							</p>
						</div>
					{/if}

					{* Standard OJS sidebar blocks *}
					{call_hook name="Templates::Common::Sidebar"}

					{* Prototype sidebar: Kata Kunci Populer *}
					<div class="jrdc-side-card">
						<h2>Kata Kunci Populer <span style="font-size:0.625rem;font-weight:500;opacity:0.6;">Tren</span></h2>
						<div style="display:flex;flex-wrap:wrap;gap:0.375rem;padding-top:0.25rem;">
							<a href="{url page="search" op="search"}?query=manajemen" style="display:inline-flex;align-items:center;gap:0.375rem;padding:0.25rem 0.625rem;border-radius:9999px;font-size:0.75rem;background:var(--jrdc-slate-50);border:1px solid var(--jrdc-slate-200);color:var(--jrdc-slate-700);text-decoration:none;">Manajemen Keuangan <span style="font-size:0.625rem;padding:0.125rem 0.375rem;border-radius:9999px;background:var(--jrdc-slate-200);color:var(--jrdc-slate-600);font-weight:600;">14</span></a>
							<a href="{url page="search" op="search"}?query=umkm" style="display:inline-flex;align-items:center;gap:0.375rem;padding:0.25rem 0.625rem;border-radius:9999px;font-size:0.75rem;background:var(--jrdc-slate-50);border:1px solid var(--jrdc-slate-200);color:var(--jrdc-slate-700);text-decoration:none;">UMKM <span style="font-size:0.625rem;padding:0.125rem 0.375rem;border-radius:9999px;background:var(--jrdc-slate-200);color:var(--jrdc-slate-600);font-weight:600;">12</span></a>
							<a href="{url page="search" op="search"}?query=banking" style="display:inline-flex;align-items:center;gap:0.375rem;padding:0.25rem 0.625rem;border-radius:9999px;font-size:0.75rem;background:var(--jrdc-slate-50);border:1px solid var(--jrdc-slate-200);color:var(--jrdc-slate-700);text-decoration:none;">Digital Banking <span style="font-size:0.625rem;padding:0.125rem 0.375rem;border-radius:9999px;background:var(--jrdc-slate-200);color:var(--jrdc-slate-600);font-weight:600;">9</span></a>
							<a href="{url page="search" op="search"}?query=fiskal" style="display:inline-flex;align-items:center;gap:0.375rem;padding:0.25rem 0.625rem;border-radius:9999px;font-size:0.75rem;background:var(--jrdc-slate-50);border:1px solid var(--jrdc-slate-200);color:var(--jrdc-slate-700);text-decoration:none;">Kebijakan Fiskal <span style="font-size:0.625rem;padding:0.125rem 0.375rem;border-radius:9999px;background:var(--jrdc-slate-200);color:var(--jrdc-slate-600);font-weight:600;">8</span></a>
						</div>
					</div>

					{* Prototype sidebar: Pengindeksan *}
					<div class="jrdc-side-card">
						<h2>Pengindeksan</h2>
						<div style="display:flex;flex-direction:column;gap:0.5rem;">
							<a href="https://www.crossref.org" style="display:flex;align-items:center;gap:0.75rem;padding:0.5rem;border:1px solid var(--jrdc-slate-200);border-radius:0.5rem;text-decoration:none;color:var(--jrdc-slate-800);">
								<span style="width:2rem;height:2rem;display:flex;align-items:center;justify-content:center;border:1px solid var(--jrdc-slate-200);border-radius:0.25rem;background:#fff;font-weight:700;font-size:0.625rem;color:#F5A623;">CR</span>
								<span style="display:flex;flex-direction:column;"><span style="font-size:0.75rem;font-weight:600;">Crossref</span><span style="font-size:0.625rem;color:var(--jrdc-slate-500);">Digital Object Identifier</span></span>
							</a>
							<a href="https://scholar.google.com" style="display:flex;align-items:center;gap:0.75rem;padding:0.5rem;border:1px solid var(--jrdc-slate-200);border-radius:0.5rem;text-decoration:none;color:var(--jrdc-slate-800);">
								<span style="width:2rem;height:2rem;display:flex;align-items:center;justify-content:center;border:1px solid var(--jrdc-slate-200);border-radius:0.25rem;background:#fff;font-weight:700;font-size:0.625rem;color:#4285F4;">GS</span>
								<span style="display:flex;flex-direction:column;"><span style="font-size:0.75rem;font-weight:600;">Google Scholar</span><span style="font-size:0.625rem;color:var(--jrdc-slate-500);">Academic Search Engine</span></span>
							</a>
							<a href="https://garuda.kemdikbud.go.id" style="display:flex;align-items:center;gap:0.75rem;padding:0.5rem;border:1px solid var(--jrdc-slate-200);border-radius:0.5rem;text-decoration:none;color:var(--jrdc-slate-800);">
								<span style="width:2rem;height:2rem;display:flex;align-items:center;justify-content:center;border:1px solid var(--jrdc-slate-200);border-radius:0.25rem;background:#fff;font-weight:700;font-size:0.625rem;color:#C2410C;">GR</span>
								<span style="display:flex;flex-direction:column;"><span style="font-size:0.75rem;font-weight:600;">Garuda</span><span style="font-size:0.625rem;color:var(--jrdc-slate-500);">Garba Rujukan Digital</span></span>
							</a>
							<a href="https://sinta.kemdikbud.go.id" style="display:flex;align-items:center;gap:0.75rem;padding:0.5rem;border:1px solid var(--jrdc-slate-200);border-radius:0.5rem;text-decoration:none;color:var(--jrdc-slate-800);">
								<span style="width:2rem;height:2rem;display:flex;align-items:center;justify-content:center;border:1px solid var(--jrdc-slate-200);border-radius:0.25rem;background:#fff;font-weight:700;font-size:0.625rem;color:#0284C7;">SI</span>
								<span style="display:flex;flex-direction:column;"><span style="font-size:0.75rem;font-weight:600;">SINTA</span><span style="font-size:0.625rem;color:var(--jrdc-slate-500);">Science and Technology Index</span></span>
							</a>
							<a href="https://doaj.org" style="display:flex;align-items:center;gap:0.75rem;padding:0.5rem;border:1px solid var(--jrdc-slate-200);border-radius:0.5rem;text-decoration:none;color:var(--jrdc-slate-800);">
								<span style="width:2rem;height:2rem;display:flex;align-items:center;justify-content:center;border:1px solid var(--jrdc-slate-200);border-radius:0.25rem;background:#fff;font-weight:700;font-size:0.625rem;color:#F97316;">DJ</span>
								<span style="display:flex;flex-direction:column;"><span style="font-size:0.75rem;font-weight:600;">DOAJ</span><span style="font-size:0.625rem;color:var(--jrdc-slate-500);">Directory of Open Access Journals</span></span>
							</a>
						</div>
					</div>

					{* Prototype sidebar: Arsip *}
					<div class="jrdc-side-card">
						<h2>Arsip <span style="font-size:0.625rem;font-weight:500;opacity:0.6;">Terbitan</span></h2>
						<div style="display:flex;flex-direction:column;gap:0.25rem;">
							<a href="{url page="issue" op="archive"}" style="display:flex;align-items:center;justify-content:space-between;padding:0.5rem;border-radius:0.5rem;text-decoration:none;color:var(--jrdc-slate-800);">
								<span style="display:flex;align-items:center;gap:0.625rem;"><svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg><span style="font-size:0.8125rem;font-weight:600;">2026</span></span>
								<span style="font-size:0.625rem;padding:0.125rem 0.375rem;border-radius:9999px;background:var(--jrdc-slate-100);color:var(--jrdc-slate-500);font-weight:500;">1 Edisi</span>
							</a>
						</div>
					</div>
					{* Prototype sidebar: Untuk Penulis *}
					<div class="jrdc-side-card">
						<h2>Untuk Penulis</h2>
						<ul style="list-style:none;margin:0;padding:0;font-size:0.75rem;">
							<li><a href="{url page="about" op="submissions"}" style="display:flex;align-items:center;gap:0.625rem;padding:0.5rem 0;color:var(--jrdc-slate-600);text-decoration:none;"><span style="color:var(--jrdc-slate-400);">›</span>Pedoman Penulis</a></li>
							<li><a href="{url page="about"}" style="display:flex;align-items:center;gap:0.625rem;padding:0.5rem 0;color:var(--jrdc-slate-600);text-decoration:none;"><span style="color:var(--jrdc-slate-400);">›</span>Proses Telaah Sejawat</a></li>
							<li><a href="{url page="about"}" style="display:flex;align-items:center;gap:0.625rem;padding:0.5rem 0;color:var(--jrdc-slate-600);text-decoration:none;"><span style="color:var(--jrdc-slate-400);">›</span>Etika Publikasi</a></li>
							<li><a href="{url page="about"}" style="display:flex;align-items:center;gap:0.625rem;padding:0.5rem 0;color:var(--jrdc-slate-600);text-decoration:none;"><span style="color:var(--jrdc-slate-400);">›</span>Hak Cipta &amp; Lisensi</a></li>
							<li><a href="{url page="about"}" style="display:flex;align-items:center;gap:0.625rem;padding:0.5rem 0;color:var(--jrdc-slate-600);text-decoration:none;"><span style="color:var(--jrdc-slate-400);">›</span>Pernyataan Akses Terbuka</a></li>
							<li><a href="{url page="about" op="submissions"}" style="display:flex;align-items:center;gap:0.625rem;padding:0.5rem 0;color:var(--jrdc-slate-600);text-decoration:none;"><span style="color:var(--jrdc-slate-400);">›</span>Kirim Naskah</a></li>
						</ul>
					</div>

					{* Prototype sidebar: Templat *}
					<div class="jrdc-side-card">
						<h2>Templat</h2>
						<ul style="list-style:none;margin:0;padding:0;font-size:0.75rem;">
							<li><a href="{url page="about" op="submissions"}" style="display:flex;align-items:center;gap:0.625rem;padding:0.5rem 0;color:var(--jrdc-slate-600);text-decoration:none;"><span style="color:var(--jrdc-slate-400);">›</span>Templat Naskah</a></li>
							<li><a href="{url page="about" op="submissions"}" style="display:flex;align-items:center;gap:0.625rem;padding:0.5rem 0;color:var(--jrdc-slate-600);text-decoration:none;"><span style="color:var(--jrdc-slate-400);">›</span>Formulir Laporan Revisi</a></li>
							<li><a href="{url page="about" op="submissions"}" style="display:flex;align-items:center;gap:0.625rem;padding:0.5rem 0;color:var(--jrdc-slate-600);text-decoration:none;"><span style="color:var(--jrdc-slate-400);">›</span>Pernyataan Orisinalitas</a></li>
						</ul>
					</div>

					{* Prototype sidebar: Rekomendasi Tools *}
					<div class="jrdc-side-card">
						<h2>Rekomendasi Tools <span style="font-size:0.625rem;font-weight:500;opacity:0.6;">Riset &amp; Naskah</span></h2>
						<p style="font-size:0.6875rem;color:var(--jrdc-slate-500);margin:0 0 0.75rem;">Perangkat pendukung penulisan, sitasi, dan pengecekan naskah ilmiah:</p>
						<div style="display:flex;flex-direction:column;gap:0.5rem;">
							<a href="https://www.mendeley.com" style="display:flex;align-items:center;justify-content:space-between;padding:0.5rem;border:1px solid var(--jrdc-slate-200);border-radius:0.5rem;text-decoration:none;color:var(--jrdc-slate-800);">
								<span style="display:flex;align-items:center;gap:0.625rem;"><span style="width:2rem;height:2rem;border-radius:0.5rem;background:rgba(220,38,38,0.1);color:#dc2626;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:0.75rem;">M</span><span style="display:flex;flex-direction:column;"><span style="font-size:0.75rem;font-weight:600;">Mendeley</span><span style="font-size:0.625rem;color:var(--jrdc-slate-500);">Reference Manager &amp; Sitasi</span></span></span>
								<svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path></svg>
							</a>
							<a href="https://www.zotero.org" style="display:flex;align-items:center;justify-content:space-between;padding:0.5rem;border:1px solid var(--jrdc-slate-200);border-radius:0.5rem;text-decoration:none;color:var(--jrdc-slate-800);">
								<span style="display:flex;align-items:center;gap:0.625rem;"><span style="width:2rem;height:2rem;border-radius:0.5rem;background:rgba(220,38,38,0.1);color:#dc2626;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:0.75rem;">Z</span><span style="display:flex;flex-direction:column;"><span style="font-size:0.75rem;font-weight:600;">Zotero</span><span style="font-size:0.625rem;color:var(--jrdc-slate-500);">Manajemen Sitasi Terbuka</span></span></span>
								<svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path></svg>
							</a>
							<a href="https://www.turnitin.com" style="display:flex;align-items:center;justify-content:space-between;padding:0.5rem;border:1px solid var(--jrdc-slate-200);border-radius:0.5rem;text-decoration:none;color:var(--jrdc-slate-800);">
								<span style="display:flex;align-items:center;gap:0.625rem;"><span style="width:2rem;height:2rem;border-radius:0.5rem;background:rgba(234,88,12,0.1);color:#ea580c;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:0.75rem;">T</span><span style="display:flex;flex-direction:column;"><span style="font-size:0.75rem;font-weight:600;">Turnitin</span><span style="font-size:0.625rem;color:var(--jrdc-slate-500);">Cek Kemiripan &amp; Plagiarisme</span></span></span>
								<svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path></svg>
							</a>
						</div>
					</div>

					{* Prototype sidebar: Statistik Artikel *}
					<div class="jrdc-side-card">
						<h2>Statistik Artikel <span style="font-size:0.625rem;font-weight:500;opacity:0.6;">12 Bulan</span></h2>
						<div style="display:grid;grid-template-columns:1fr 1fr;gap:0.625rem;margin-bottom:0.75rem;">
							<div style="padding:0.625rem;border-radius:0.5rem;background:var(--jrdc-slate-50);border:1px solid var(--jrdc-slate-100);text-align:center;">
								<span style="display:block;font-size:0.625rem;font-weight:600;color:var(--jrdc-slate-500);text-transform:uppercase;letter-spacing:0.05em;">Total Views</span>
								<span style="font-size:1.125rem;font-weight:700;color:var(--jrdc-slate-900);">18,420</span>
							</div>
							<div style="padding:0.625rem;border-radius:0.5rem;background:var(--jrdc-slate-50);border:1px solid var(--jrdc-slate-100);text-align:center;">
								<span style="display:block;font-size:0.625rem;font-weight:600;color:var(--jrdc-slate-500);text-transform:uppercase;letter-spacing:0.05em;">Downloads</span>
								<span style="font-size:1.125rem;font-weight:700;color:var(--jrdc-primary);">6,180</span>
							</div>
						</div>
						<div style="height:5rem;display:flex;align-items:flex-end;justify-content:space-between;gap:0.25rem;padding-top:0.5rem;border-bottom:1px solid var(--jrdc-slate-100);">
							<div style="flex:1;height:40%;background:var(--jrdc-slate-900);border-radius:2px 2px 0 0;opacity:0.8;"></div>
							<div style="flex:1;height:48%;background:var(--jrdc-slate-900);border-radius:2px 2px 0 0;opacity:0.8;"></div>
							<div style="flex:1;height:55%;background:var(--jrdc-slate-900);border-radius:2px 2px 0 0;opacity:0.8;"></div>
							<div style="flex:1;height:62%;background:var(--jrdc-slate-900);border-radius:2px 2px 0 0;opacity:0.8;"></div>
							<div style="flex:1;height:50%;background:var(--jrdc-slate-900);border-radius:2px 2px 0 0;opacity:0.8;"></div>
							<div style="flex:1;height:70%;background:var(--jrdc-slate-900);border-radius:2px 2px 0 0;opacity:0.8;"></div>
						</div>
					</div>
				</aside>
			{/if}
		</div>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
