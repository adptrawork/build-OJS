{**
 * templates/frontend/pages/announcements.tpl
 * Halaman Daftar Pengumuman
 *}
{include file="frontend/components/header.tpl"}

<style>
    :root {
        --primary-color: {$activeTheme->getOption('primaryColor')|escape|default:'#c2410c'};
    }
</style>

<div class="container announcements-page">

    <!-- Breadcrumbs -->
    <nav class="breadcrumbs">
        <a href="{url page="index"}">Beranda</a>
        <span>/</span>
        <span class="current">Pengumuman</span>
    </nav>

    <!-- Header Banner -->
    <div class="page-header-banner">
        <div class="page-header-content">
            <div class="eyebrow">INFORMASI RESMI REDAKSI</div>
            <h1>Pengumuman &amp; Call for Papers</h1>
            <p>Temukan informasi terbaru seputar jadwal penerbitan edisi mendatang, undangan pengiriman naskah (call for papers), pembaruan pedoman penulis, serta pengumuman penting lainnya dari Dewan Redaksi {$currentJournal->getLocalizedName()|escape}.</p>
        </div>
    </div>

    <!-- Announcements List -->
    <div class="announcements-list">
        {if $announcements}
            {foreach from=$announcements item=announcement name=announcementLoop}
                <div class="announcement-card">

                    <div class="announcement-card-header">
                        {if $announcement->getAnnouncementTypeName()}
                            <span class="announcement-badge">{$announcement->getAnnouncementTypeName()|escape}</span>
                        {else}
                            <span class="announcement-badge badge-default">Informasi</span>
                        {/if}

                        <span class="announcement-date">
                            {$announcement->getDatePosted()|date_format:"%d %B %Y"}
                        </span>
                    </div>

                    <h2 class="announcement-title">
                        <a href="{url page="announcement" op="view" path=$announcement->getId()}">
                            {$announcement->getLocalizedTitle()|escape}
                        </a>
                    </h2>

                    <div class="announcement-body">
                        {$announcement->getLocalizedDescription()|strip_tags|truncate:300}
                    </div>

                    <div class="announcement-card-footer">
                        <span class="announcement-author">Oleh: Dewan Redaksi</span>
                        <a href="{url page="announcement" op="view" path=$announcement->getId()}" class="btn btn-dark btn-sm">
                            Baca Selengkapnya &rarr;
                        </a>
                    </div>

                </div>
            {/foreach}
        {else}
            <div class="empty-state">
                <p>Belum ada pengumuman terbaru saat ini.</p>
            </div>
        {/if}
    </div>

</div>

{include file="frontend/components/footer.tpl"}
