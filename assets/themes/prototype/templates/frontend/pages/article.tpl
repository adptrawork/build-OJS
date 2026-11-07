{**
 * templates/frontend/pages/article.tpl
 * Halaman detail artikel
 *}
{include file="frontend/components/header.tpl"}

<style>
    :root {
        --primary-color: {$activeTheme->getOption('primaryColor')|escape|default:'#c2410c'};
    }
</style>

<div class="container article-page">

    <!-- Breadcrumbs -->
    <nav class="breadcrumbs">
        <a href="{url page="index"}">Beranda</a>
        <span>/</span>
        <a href="{url page="issue" op="archive"}">Arsip</a>
        <span>/</span>
        {if $issue}
            <a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">Vol. {$issue->getVolume()} No. {$issue->getNumber()} ({$issue->getYear()})</a>
        {/if}
        <span>/</span>
        <span class="current">Detail Artikel</span>
    </nav>

    <div class="article-layout">

        <!-- KOLOM KIRI (KONTEN UTAMA) -->
        <div class="article-main">

            <!-- Header & Metadata Artikel -->
            <section class="card">
                <div class="article-badges">
                    <span class="badge badge-section">{$section->getLocalizedTitle()|escape|default:'Artikel Penelitian'}</span>
                    <span class="badge badge-oa">Akses Terbuka</span>
                    <span class="badge badge-peer">Telaah Sejawat Double-Blind</span>
                </div>

                <h1 class="article-title">{$article->getLocalizedTitle()|escape}</h1>

                <div class="article-authors-full">
                    <div class="author-names">
                        {foreach from=$article->getAuthors() item=author name=authorsLoop}
                            <span>{$author->getFullName()|escape}{if !$author@last}, {/if}</span>
                        {/foreach}
                    </div>
                    <div class="author-affiliations">
                        {foreach from=$article->getAuthors() item=author}
                            {if $author->getLocalizedAffiliation()}
                                <p>{$author->getLocalizedAffiliation()|escape}</p>
                            {/if}
                        {/foreach}
                    </div>
                </div>

                <!-- Grid DOI & Tanggal -->
                <div class="article-meta-grid">
                    {assign var="artPub" value=$article->getCurrentPublication()}
                    {if $artPub && $artPub->getStoredPubId('doi')}
                        <div>
                            <span class="meta-label">DOI</span>
                            <a href="https://doi.org/{$artPub->getStoredPubId('doi')|escape}" target="_blank">{$artPub->getStoredPubId('doi')|escape}</a>
                        </div>
                    {/if}
                    {if $article->getDateSubmitted()}
                        <div>
                            <span class="meta-label">DITERIMA</span>
                            <span class="meta-value">{$article->getDateSubmitted()|date_format:"%d %B %Y"}</span>
                        </div>
                    {/if}
                    {if $article->getDatePublished()}
                        <div>
                            <span class="meta-label">TERBIT</span>
                            <span class="meta-value">{$article->getDatePublished()|date_format:"%d %B %Y"}</span>
                        </div>
                    {/if}
                </div>

                <!-- Abstrak -->
                {if $article->getLocalizedAbstract()}
                    <div class="article-abstract-section">
                        <h2 class="section-title">Abstrak</h2>
                        <div class="abstract-text">
                            {$article->getLocalizedAbstract()|nl2br}
                        </div>

                        {assign var="kw" value=$article->getLocalizedData('keywords')}
                        {if $kw && is_array($kw)}
                            <div class="article-keywords">
                                <span class="keywords-label">Keywords:</span>
                                <div class="keywords-list">
                                    {foreach from=$kw item=keyword}
                                        <span class="keyword-tag">{$keyword|escape}</span>
                                    {/foreach}
                                </div>
                            </div>
                        {/if}
                    </div>
                {/if}

                {assign var="jel" value=$article->getLocalizedData('jel')}
                {if $jel}
                    <div class="article-jel">
                        <strong>JEL Classification:</strong> {$jel|escape}
                    </div>
                {/if}
            </section>

            <!-- Bagian Unduh / Pratinjau PDF -->
            {if $galleys}
                <section class="card">
                    <div class="pdf-header">
                        <div>
                            <h2 class="section-title">Unduh Naskah Lengkap</h2>
                            <p class="pdf-desc">Tersedia dalam format dokumen PDF resmi jurnal</p>
                        </div>
                        {foreach from=$galleys item=galley name=galleyLoop}
                            {if $galley@first}
                                <a href="{url page="article" op="view" path=$article->getBestArticleId()|to_array:$galley->getBestGalleyId()}" class="btn btn-primary" target="_blank">
                                    Unduh PDF Resmi
                                </a>
                            {/if}
                        {/foreach}
                    </div>
                    <div class="pdf-viewer">
                        {foreach from=$galleys item=galley name=viewerLoop}
                            {if $galley@first}
                                <iframe src="{url page="article" op="view" path=$article->getBestArticleId()|to_array:$galley->getBestGalleyId()}" title="PDF Document Viewer"></iframe>
                            {/if}
                        {/foreach}
                    </div>
                </section>
            {/if}

            <!-- Daftar Pustaka -->
            <section class="card">
                <h2 class="section-title">Daftar Pustaka</h2>
                <div class="references-placeholder">
                    <p>Daftar pustaka tersedia di dalam naskah PDF lengkap.</p>
                </div>
            </section>

        </div>

        <!-- KOLOM KANAN (SIDEBAR) -->
        <div class="article-sidebar">

            {if $issue}
                <div class="side-card">
                    <div class="issue-mini-header">
                        <div class="issue-mini-cover">
                            {if $issue->getLocalizedCoverImageUrl()}
                                <img src="{$issue->getLocalizedCoverImageUrl()|escape}" alt="Cover">
                            {/if}
                        </div>
                        <div class="issue-mini-info">
                            <span class="side-label">EDISI TERBITAN</span>
                            <h3>Vol. {$issue->getVolume()} No. {$issue->getNumber()} ({$issue->getYear()})</h3>
                            <p>{$currentJournal->getLocalizedName()|escape}</p>
                        </div>
                    </div>
                    <a href="{url page="issue" op="view" path=$issue->getBestIssueId()}" class="btn btn-block btn-light">
                        <span>Lihat Semua Artikel Edisi Ini</span>
                    </a>
                </div>
            {/if}

            <!-- Statistik Naskah -->
            <div class="side-card">
                <h3 class="side-title">Statistik Naskah</h3>
                <div class="stats-grid-mini">
                    <div class="stat-box-mini">
                        <span class="stat-value-mini">2,145</span>
                        <span class="stat-label-mini">Total Dilihat</span>
                    </div>
                    <div class="stat-box-mini">
                        <span class="stat-value-mini text-primary">1,420</span>
                        <span class="stat-label-mini">Unduh PDF</span>
                    </div>
                </div>
            </div>

            <!-- Bagikan Artikel -->
            <div class="side-card">
                <h3 class="side-title">Bagikan Artikel</h3>
                <div class="share-buttons">
                    <a href="https://wa.me/?text={$article->getLocalizedTitle()|escape:'url'}%20{url page="article" op="view" path=$article->getBestArticleId()}" target="_blank" class="share-btn share-wa">WA</a>
                    <a href="https://twitter.com/intent/tweet?text={$article->getLocalizedTitle()|escape:'url'}&url={url page="article" op="view" path=$article->getBestArticleId()}" target="_blank" class="share-btn share-x">X</a>
                    <a href="https://www.facebook.com/sharer/sharer.php?u={url page="article" op="view" path=$article->getBestArticleId()}" target="_blank" class="share-btn share-fb">FB</a>
                    <a href="https://www.linkedin.com/sharing/share-offsite/?url={url page="article" op="view" path=$article->getBestArticleId()}" target="_blank" class="share-btn share-in">IN</a>
                </div>
            </div>

            <!-- Lisensi -->
            <div class="side-card">
                <h3 class="side-title">Lisensi &amp; Hak Cipta</h3>
                <div class="license-content">
                    <a href="https://creativecommons.org/licenses/by-sa/4.0/" target="_blank" class="license-badge">CC BY-SA 4.0</a>
                    <p>Ciptaan dilindungi di bawah Lisensi Internasional Creative Commons Attribution-ShareAlike 4.0. Penulis memegang hak cipta tanpa batasan.</p>
                </div>
            </div>

        </div>
    </div>
</div>

{include file="frontend/components/footer.tpl"}
