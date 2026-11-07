{**
 * templates/frontend/pages/issueArchive.tpl
 * Halaman Arsip Terbitan
 *}
{include file="frontend/components/header.tpl"}

<style>
    :root {
        --primary-color: {$activeTheme->getOption('primaryColor')|escape|default:'#c2410c'};
    }
</style>

<main class="container archive-page">

    <!-- Breadcrumbs -->
    <nav class="breadcrumbs">
        <a href="{url page="index"}">Beranda</a>
        <span>/</span>
        <span class="current">Arsip Terbitan</span>
    </nav>

    <!-- Page Title Header -->
    <div class="archive-header">
        <div class="archive-header-content">
            <div class="eyebrow">REPOSITORI ARSIP</div>
            <h1>Arsip Terbitan Jurnal</h1>
            <p>Telusuri seluruh edisi dan volume {$currentJournal->getLocalizedName()|escape} yang telah diterbitkan. Setiap terbitan memuat artikel ilmiah yang telah melalui proses telaah sejawat secara ketat.</p>
        </div>
    </div>

    <!-- Filter by Year Buttons -->
    <div id="year-filters" class="year-filters">
        <span class="filter-label">Filter Tahun:</span>
        <button data-year="all" class="year-btn active">Semua Tahun</button>

        {assign var="years" value=[]}
        {foreach from=$issues item=issue}
            {assign var="year" value=$issue->getYear()}
            {if !in_array($year, $years)}
                {assign var="years" value=$years|@array_merge:[$year]}
                <button data-year="{$year}" class="year-btn">{$year}</button>
            {/if}
        {/foreach}
    </div>

    <!-- Archive Grid by Volume/Issue -->
    <div class="archive-groups">
        {if $issues}
            {assign var="currentYear" value=""}

            {foreach from=$issues item=issue name=issueLoop}
                {assign var="issueYear" value=$issue->getYear()}

                {if $issueYear != $currentYear}
                    {if $currentYear != ""}
                            </div>
                        </div>
                    {/if}

                    <div class="year-group" data-year="{$issueYear}">
                        <div class="year-header">
                            <h2>Tahun {$issueYear}</h2>
                            <div class="year-line"></div>
                        </div>
                        <div class="issues-grid">

                    {assign var="currentYear" value=$issueYear}
                {/if}

                <div class="issue-card">
                    <div class="issue-card-body">
                        <div class="issue-card-top">
                            <div class="issue-card-cover">
                                {if $issue->getLocalizedCoverImageUrl()}
                                    <img src="{$issue->getLocalizedCoverImageUrl()|escape}" alt="Cover {$issue->getIssueIdentification()|escape}">
                                {else}
                                    <div class="cover-placeholder">JRDC</div>
                                {/if}
                            </div>
                            <div class="issue-card-info">
                                <h3>
                                    <a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
                                        {$issue->getIssueIdentification()|escape}
                                    </a>
                                </h3>
                                <span class="meta-date">Diterbitkan: {$issue->getDatePublished()|date_format:"%d %B %Y"}</span>
                                <span class="meta-count">Edisi {$issue->getYear()}</span>
                            </div>
                        </div>

                        {if $issue->getLocalizedDescription()}
                            <p class="issue-desc">
                                {$issue->getLocalizedDescription()|strip_tags|truncate:100}
                            </p>
                        {/if}
                    </div>

                    <div class="issue-card-footer">
                        <span class="meta-issn">
                            {if $currentJournal->getData('onlineIssn')}
                                ISSN: {$currentJournal->getData('onlineIssn')|escape}
                            {else}
                                Jurnal JRDC
                            {/if}
                        </span>
                        <a href="{url page="issue" op="view" path=$issue->getBestIssueId()}" class="btn btn-dark btn-sm">Lihat Edisi</a>
                    </div>
                </div>

            {/foreach}

            {if $currentYear != ""}
                    </div>
                </div>
            {/if}
        {else}
            <div class="empty-state">
                <p>Belum ada arsip terbitan yang tersedia saat ini.</p>
            </div>
        {/if}
    </div>
</main>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const buttons = document.querySelectorAll('.year-btn');
    const groups = document.querySelectorAll('.year-group');
    buttons.forEach(btn => {
        btn.addEventListener('click', function () {
            const year = this.getAttribute('data-year');
            buttons.forEach(b => b.classList.remove('active'));
            this.classList.add('active');
            groups.forEach(group => {
                if (year === 'all' || group.getAttribute('data-year') === year) {
                    group.style.display = 'block';
                } else {
                    group.style.display = 'none';
                }
            });
        });
    });
});
</script>

{include file="frontend/components/footer.tpl"}
