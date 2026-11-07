{**
 * templates/frontend/pages/announcement.tpl
 * Halaman Detail Pengumuman
 *}
{include file="frontend/components/header.tpl"}

<main class="container announcement-page">

    <!-- Breadcrumbs -->
    <nav class="breadcrumbs">
        <a href="{url page="index"}">Beranda</a>
        <span>/</span>
        <a href="{url page="announcement"}">Pengumuman</a>
        <span>/</span>
        <span class="current">Detail Pengumuman</span>
    </nav>

    <div class="announcement-detail-wrapper">
        <div class="content-card">

            <!-- Header Pengumuman -->
            <div class="announcement-detail-header">
                <div class="announcement-meta">
                    {if $announcement->getAnnouncementTypeName()}
                        <span class="announcement-badge">{$announcement->getAnnouncementTypeName()|escape}</span>
                    {else}
                        <span class="announcement-badge badge-default">Informasi</span>
                    {/if}

                    <span class="announcement-date">
                        Diposting pada: {$announcement->getDatePosted()|date_format:"%d %B %Y"}
                    </span>
                </div>

                <h1 class="announcement-detail-title">
                    {$announcement->getLocalizedTitle()|escape}
                </h1>
            </div>

            <hr class="detail-divider">

            <!-- Isi Pengumuman -->
            <div class="announcement-content-body">
                {if $announcement->getLocalizedDescription()}
                    {$announcement->getLocalizedDescription()}
                {else}
                    <p class="text-muted"><em>Isi pengumuman belum tersedia.</em></p>
                {/if}
            </div>

            <!-- Footer / Navigasi Kembali -->
            <div class="announcement-detail-footer">
                <a href="{url page="announcement"}" class="btn btn-outline">
                    &larr; Kembali ke Daftar Pengumuman
                </a>

                <div class="announcement-share">
                    <span class="share-label">Bagikan:</span>
                    <a href="https://wa.me/?text={$announcement->getLocalizedTitle()|escape:'url'}%20{url page="announcement" op="view" path=$announcement->getId()}" target="_blank" class="share-link">WA</a>
                    <a href="https://twitter.com/intent/tweet?text={$announcement->getLocalizedTitle()|escape:'url'}&url={url page="announcement" op="view" path=$announcement->getId()}" target="_blank" class="share-link">X</a>
                    <a href="https://www.facebook.com/sharer/sharer.php?u={url page="announcement" op="view" path=$announcement->getId()}" target="_blank" class="share-link">FB</a>
                </div>
            </div>

        </div>
    </div>
</main>

{include file="frontend/components/footer.tpl"}
