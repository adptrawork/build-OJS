{**
 * templates/frontend/pages/indexJournal.tpl
 * Halaman utama jurnal JRDC
 *}
{include file="frontend/components/header.tpl"}

<style>
    :root {
        --primary-color: {$activeTheme->getOption('primaryColor')|escape|default:'#c2410c'};
        --hero-color: {$activeTheme->getOption('heroColor')|escape|default:'#0b2038'};
    }
</style>

<!-- HERO SECTION -->
<section class="jrdc-hero">
    <div class="jrdc-container">
        <div class="jrdc-hero-banner">
            <div class="jrdc-hero-grid">
                <div>
                    {assign var="heroEyebrow" value=$activeTheme->getOption('heroEyebrow')}
                    {if $heroEyebrow}
                        <div class="jrdc-hero-eyebrow">{$heroEyebrow|escape}</div>
                    {/if}
                    <h1 class="jrdc-hero-title">
                        {$currentJournal->getLocalizedName()|escape}
                    </h1>
                    {if $currentJournal->getLocalizedDescription()}
                        <p class="jrdc-hero-desc">
                            {$currentJournal->getLocalizedDescription()|strip_tags|truncate:280}
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

                {assign var="showHeroCover" value=$activeTheme->getOption('showHeroCover')|default:'1'}
                {if $showHeroCover == '1' && $currentIssue}
                    <div class="jrdc-hero-cover">
                        {if $currentIssue->getLocalizedCoverImageUrl()}
                            <a href="{url page="issue" op="view" path=$currentIssue->getBestIssueId()}">
                                <img src="{$currentIssue->getLocalizedCoverImageUrl()|escape}" alt="{$currentIssue->getLocalizedCoverImageAltText()|escape|default:$currentIssue->getIssueIdentification()|escape}">
                            </a>
                        {else}
                            <div class="jrdc-cover" aria-hidden="true">
                                <svg viewBox="0 0 64 64" width="96" height="96" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <rect x="4" y="4" width="56" height="56" rx="12" fill="#0F284E" stroke="#D4AF37" stroke-width="2"/>
                                    <path d="M18 42C23 39.5 28.5 39.8 32 42.5C35.5 39.8 41 39.5 46 42V26C41 23.5 35.5 23.8 32 26.5C28.5 23.8 23 23.5 18 26V42Z" fill="none" stroke="#FFFFFF" stroke-width="1.8"/>
                                    <line x1="32" y1="26.5" x2="32" y2="42.5" stroke="#FFFFFF" stroke-width="1.8"/>
                                </svg>
                                <span>{$currentJournal->getLocalizedName()|escape|truncate:24}</span>
                            </div>
                        {/if}
                    </div>
                {/if}
            </div>
        </div>
    </div>
</section>

<!-- MAIN CONTENT & SIDEBAR -->
<div class="container main-layout">

    <!-- KOLOM KIRI (UTAMA) -->
    <div class="main-col">

        <!-- Tentang Jurnal -->
        <section class="card">
            <h2 class="card-title">Tentang Jurnal Ini</h2>
            <p class="text-muted mb-4">Jurnal Ekonomi dan Bisnis JRDC merupakan wadah diseminasi riset ilmiah bidang ekonomi dan bisnis.</p>

            <div class="info-grid">
                <a href="{url page="about" op="editorialTeam"}" class="info-box">
                    <h3>Dewan Editor</h3>
                    <p>Dewan Editor</p>
                </a>
                <a href="{url page="about" op="submissions"}" class="info-box">
                    <h3>Panduan Penulis</h3>
                    <p>Panduan Penulis</p>
                </a>
                <a href="{url page="about"}" class="info-box">
                    <h3>Tentang Jurnal Ini</h3>
                    <p>Kontak &amp; Kebijakan</p>
                </a>
            </div>
        </section>

        <!-- Informasi / Pengumuman -->
        <section class="card">
            <h2 class="card-title">Informasi</h2>
            {if $announcements}
                {foreach from=$announcements item=announcement name=announcementLoop}
                    {if $smarty.foreach.announcementLoop.index < 2}
                        <div class="announcement-item">
                            <div class="date-badge">
                                <span class="date-day">{$announcement->getDatePosted()|date_format:"%d"}</span>
                                <span class="date-month">{$announcement->getDatePosted()|date_format:"%b"}</span>
                            </div>
                            <div class="announcement-content">
                                <h3><a href="{url page="announcement" op="view" path=$announcement->getId()}">{$announcement->getLocalizedTitle()|escape}</a></h3>
                                <p>{$announcement->getLocalizedDescriptionShort()|strip_tags|truncate:150}</p>
                            </div>
                        </div>
                    {/if}
                {/foreach}
            {else}
                <div class="announcement-item">
                    <div class="date-badge"><span class="date-day">15</span><span class="date-month">MEI</span></div>
                    <div class="announcement-content">
                        <h3><a href="#">Pengumuman Terbaru Jurnal JRDC</a></h3>
                        <p>Informasi penting bagi penulis dan pembaca.</p>
                    </div>
                </div>
            {/if}
        </section>

        <!-- Terbitan Terkini -->
        <section class="card">
            <div class="card-header-flex">
                <h2 class="card-title" style="border:none; margin:0; padding:0;">Terbitan Terkini</h2>
                {if $currentIssue}
                    <a href="{url page="issue" op="view" path=$currentIssue->getBestIssueId()}" class="link-primary">
                        Vol {$currentIssue->getVolume()} No {$currentIssue->getNumber()} ({$currentIssue->getYear()}) &rarr;
                    </a>
                {/if}
            </div>

            <div class="latest-issue-list">
                {if $currentIssue && $publishedSubmissions}
                    {foreach from=$publishedSubmissions item=section}
                        {if $section.articles}
                            {foreach from=$section.articles item=article}
                                <div class="article-list-item">
                                    <h3><a href="{url page="article" op="view" path=$article->getBestArticleId()}">{$article->getLocalizedTitle()|escape}</a></h3>
                                    <div class="article-meta">
                                        <span class="authors">{$article->getAuthorString()|escape}</span>
                                    </div>
                                </div>
                            {/foreach}
                        {/if}
                    {/foreach}
                {else}
                    <div class="empty-state">
                        <p>Belum ada artikel yang diterbitkan pada edisi ini.</p>
                    </div>
                {/if}
            </div>
        </section>

        <!-- Card Yayasan (Bawah) -->
        <section class="card">
            <p class="text-muted mb-0"><strong>{$currentJournal->getData('publisherInstitution')|escape|default:'Yayasan Ratu Dirgantara Cendekiawan (JRDC)'}</strong> adalah lembaga yang berkomitmen pada pengembangan ilmu pengetahuan di bidang ekonomi dan bisnis. Jurnal ini terbit dua kali setahun (April dan Oktober) dan bersifat open access.</p>
        </section>

    </div>

    <!-- KOLOM KANAN (SIDEBAR) -->
    <aside class="side-col">

        <a href="{url page="submission" op="wizard"}" class="btn-submit">Kirim Naskah</a>

        <div class="side-card">
            <h2>Bahasa</h2>
            <ul class="list-clean">
                <li><a href="#">Bahasa Indonesia</a></li>
                <li><a href="#">English</a></li>
            </ul>
        </div>

        <div class="side-card">
            <h2>Kata Kunci Populer <span class="side-label">Tren</span></h2>
            <div class="keywords-wrap">
                <a href="#" class="keyword-pill">Manajemen Keuangan <span>14</span></a>
                <a href="#" class="keyword-pill">UMKM <span>12</span></a>
                <a href="#" class="keyword-pill">Digital Banking <span>9</span></a>
                <a href="#" class="keyword-pill">Kebijakan Fiskal <span>8</span></a>
            </div>
        </div>

        <div class="side-card">
            <h2>Pengindeksan</h2>
            <ul class="list-indexer">
                <li><div class="indexer-icon" style="color:#F5A623;">CR</div><div class="indexer-text"><strong>Crossref</strong><span>Digital Object Identifier</span></div></li>
                <li><div class="indexer-icon" style="color:#4285F4;">GS</div><div class="indexer-text"><strong>Google Scholar</strong><span>Academic Search Engine</span></div></li>
                <li><div class="indexer-icon" style="color:#B91C1C;">GR</div><div class="indexer-text"><strong>Garuda</strong><span>Garba Rujukan Digital</span></div></li>
                <li><div class="indexer-icon" style="color:#0284C7;">SI</div><div class="indexer-text"><strong>SINTA</strong><span>Science and Technology Index</span></div></li>
                <li><div class="indexer-icon" style="color:#F97316;">DO</div><div class="indexer-text"><strong>DOAJ</strong><span>Directory of Open Access Journals</span></div></li>
            </ul>
        </div>

        <div class="side-card">
            <h2>Arsip Terbitan</h2>
            <div class="archive-item">
                <span class="archive-year">2026</span>
                <span class="archive-count">1 Edisi</span>
            </div>
        </div>

        <div class="side-card">
            <h2>Untuk Penulis</h2>
            <ul class="list-clean">
                <li><a href="{url page="about" op="submissions"}">Pedoman Penulis</a></li>
                <li><a href="{url page="about"}">Proses Telaah Sejawat</a></li>
                <li><a href="{url page="about"}">Etika Publikasi</a></li>
                <li><a href="{url page="about"}">Hak Cipta &amp; Lisensi</a></li>
                <li><a href="{url page="about"}">Pernyataan Akses Terbuka</a></li>
                <li><a href="{url page="about" op="submissions"}">Kirim Naskah</a></li>
            </ul>
        </div>

        <div class="side-card">
            <h2>Templat</h2>
            <ul class="list-clean">
                <li><a href="{url page="about" op="submissions"}">Templat Naskah</a></li>
                <li><a href="{url page="about" op="submissions"}">Formulir Laporan Revisi</a></li>
                <li><a href="{url page="about" op="submissions"}">Pernyataan Orisinalitas</a></li>
            </ul>
        </div>

        <div class="side-card">
            <h2>Rekomendasi Tools <span class="side-label">Riset &amp; Naskah</span></h2>
            <ul class="list-indexer">
                <li><div class="indexer-icon" style="background:#fee2e2;color:#dc2626;">M</div><div class="indexer-text"><strong>Mendeley</strong><span>Reference Manager &amp; Sitasi</span></div></li>
                <li><div class="indexer-icon" style="background:#fef3c7;color:#d97706;">Z</div><div class="indexer-text"><strong>Zotero</strong><span>Manajemen Sitasi Terbuka</span></div></li>
                <li><div class="indexer-icon" style="background:#ffedd5;color:#ea580c;">T</div><div class="indexer-text"><strong>Turnitin</strong><span>Cek Kemiripan &amp; Plagiarisme</span></div></li>
            </ul>
        </div>

        <div class="side-card">
            <h2>Statistik Artikel <span class="side-label">12 Bulan</span></h2>
            <div class="stats-grid">
                <div class="stat-box">
                    <span class="stat-label">TOTAL VIEWS</span>
                    <span class="stat-value">18,420</span>
                </div>
                <div class="stat-box">
                    <span class="stat-label">DOWNLOADS</span>
                    <span class="stat-value text-primary">6,180</span>
                </div>
            </div>
            <div class="chart-bars">
                <div style="height: 40%"></div>
                <div style="height: 55%"></div>
                <div style="height: 45%"></div>
                <div style="height: 70%"></div>
                <div style="height: 65%"></div>
                <div style="height: 85%"></div>
                <div style="height: 95%"></div>
            </div>
        </div>

    </aside>
</div>

{include file="frontend/components/footer.tpl"}
