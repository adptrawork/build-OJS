{**
 * templates/frontend/pages/issue.tpl
 * Halaman daftar artikel dalam satu edisi (Vol. X No. Y)
 *}
{include file="frontend/components/header.tpl"}

<style>
    :root {
        --primary-color: {$activeTheme->getOption('primaryColor')|escape|default:'#c2410c'};
    }
</style>

<div class="container issue-page-container">

    <!-- Breadcrumbs -->
    <nav class="breadcrumbs">
        <a href="{url page="index"}">Beranda</a>
        <span>/</span>
        <a href="{url page="issue" op="archive"}">Arsip</a>
        <span>/</span>
        <span class="current">Vol. {$issue->getVolume()} No. {$issue->getNumber()} ({$issue->getYear()})</span>
    </nav>

    <!-- Issue Header Banner -->
    <div class="issue-banner">
        <div class="issue-cover-wrapper">
            {if $issue->getLocalizedCoverImageUrl()}
                <img src="{$issue->getLocalizedCoverImageUrl()|escape}" alt="Cover {$issue->getIssueIdentification()|escape}" class="issue-cover">
            {else}
                <div class="issue-cover-placeholder">
                    <span>JRDC</span>
                </div>
            {/if}
        </div>

        <div class="issue-info">
            <div class="issue-meta-top">
                <span class="badge-edisi">Edisi</span>
                {if $issue->getDatePublished()}
                    <span class="meta-text">Diterbitkan: {$issue->getDatePublished()|date_format:$dateFormatShort}</span>
                {/if}

            </div>

            <h1 class="issue-title">{$issue->getIssueIdentification()|escape}</h1>

            {if $issue->getLocalizedDescription()}
                <div class="issue-desc">
                    {$issue->getLocalizedDescription()|nl2br}
                </div>
            {/if}

            <div class="issue-actions">
                <a href="#articles-list" class="btn btn-dark">
                    Daftar Isi
                </a>
            </div>
        </div>
    </div>

    <!-- Articles Table of Contents -->
    <div id="articles-list" class="articles-container">

        {if $publishedSubmissions}
            {foreach from=$publishedSubmissions item=section}
                {if $section.articles}
                    <div class="card-section">
                        <div class="section-header">
                            <h2 class="section-title">{$section.title|escape|default:'Artikel'}</h2>
                            <span class="section-count">{count($section.articles)} Artikel</span>
                        </div>
                        <div class="section-article-list">
                            {foreach from=$section.articles item=article}
                                <div class="article-item">
                                    <div class="article-item-meta">
                                        {assign var="artPub" value=$article->getCurrentPublication()}
                                        {if $artPub && $artPub->getStoredPubId('doi')}
                                            <span class="article-doi">DOI: {$artPub->getStoredPubId('doi')|escape}</span>
                                        {else}
                                            <span></span>
                                        {/if}
                                        {if $article->getPages()}
                                            <span class="article-pages">Hal. {$article->getPages()|escape}</span>
                                        {/if}
                                    </div>

                                    <h3 class="article-title">
                                        <a href="{url page="article" op="view" path=$article->getBestArticleId()}">
                                            {$article->getLocalizedTitle()|escape}
                                        </a>
                                    </h3>

                                    <div class="article-authors">
                                        {$article->getAuthorString()|escape}
                                    </div>

                                    <div class="article-item-footer">
                                        <div class="article-stats"></div>
                                        <div class="article-actions">
                                            <a href="{url page="article" op="view" path=$article->getBestArticleId()}" class="btn btn-outline btn-sm">Abstrak</a>
                                            {foreach from=$article->getGalleys() item=galley}
                                                {if $galley->isPdfGalley()}
                                                    <a href="{url page="article" op="view" path=$article->getBestArticleId()|to_array:$galley->getBestGalleyId()}" class="btn btn-primary btn-sm">
                                                        PDF
                                                    </a>
                                                {/if}
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                {/if}
            {/foreach}
        {else}
            <div class="empty-state">
                <p>Belum ada artikel yang diterbitkan pada edisi ini.</p>
            </div>
        {/if}
    </div>
</div>

{include file="frontend/components/footer.tpl"}
