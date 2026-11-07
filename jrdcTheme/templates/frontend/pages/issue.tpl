{**
 * templates/frontend/pages/issue.tpl
 * Halaman daftar artikel dalam satu edisi
 *}
{include file="frontend/components/header.tpl"}

<style>
    :root {
        --primary-color: {$activeTheme->getOption('primaryColor')|escape};
    }
</style>

<div class="container mx-auto px-4 py-8 max-w-6xl">
    <nav class="breadcrumbs">
        <a href="{url page="index"}">Beranda</a>
        <span>/</span>
        <a href="{url page="issue" op="archive"}">Arsip</a>
        <span>/</span>
        <span class="current">Vol. {$issue->getVolume()} No. {$issue->getNumber()} ({$issue->getYear()})</span>
    </nav>

    <div class="issue-banner">
        {if $issue->getLocalizedCoverImageUrl()}
            <img src="{$issue->getLocalizedCoverImageUrl()|escape}" alt="Cover" class="issue-cover">
        {/if}
        <div class="issue-info">
            <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 0.5rem;">
                <span class="badge-edisi">Edisi</span>
                {if $issue->getDatePublished()}
                    <span style="font-size: 0.85rem; color: #64748b;">Diterbitkan: {$issue->getDatePublished()|date_format:$dateFormatShort}</span>
                {/if}
            </div>
            <h1>{$issue->getIssueIdentification()|escape}</h1>
            {if $issue->getLocalizedDescription()}
                <div class="issue-desc">{$issue->getLocalizedDescription()|nl2br}</div>
            {/if}
        </div>
    </div>

    <div id="articles">
        {assign var="currentSection" value=""}
        {foreach from=$publishedSubmissions item=article}
            {assign var="sectionTitle" value=$article->getSectionTitle()}
            {if $sectionTitle != $currentSection}
                {if $currentSection != ""}</div>{/if}
                <div class="section-header"><h2>{$sectionTitle|escape}</h2></div>
                <div class="section-content">
                {assign var="currentSection" value=$sectionTitle}
            {/if}
            <div class="article-item">
                <h3><a href="{url page="article" op="view" path=$article->getBestArticleId()}">{$article->getLocalizedTitle()|escape}</a></h3>
                <div class="article-authors">{$article->getAuthorString()|escape}</div>
                <div class="article-footer">
                    <div style="font-size: 0.8rem; color: #64748b;"></div>
                    <div style="display: flex; gap: 0.5rem;">
                        <a href="{url page="article" op="view" path=$article->getBestArticleId()}" class="btn btn-outline" style="padding: 0.3rem 0.8rem; font-size: 0.8rem;">Abstrak</a>
                        {foreach from=$article->getGalleys() item=galley}
                            {if $galley->isPdfGalley()}
                                <a href="{url page="article" op="view" path=$article->getBestArticleId()|to_array:$galley->getBestGalleyId()}" class="btn btn-primary" style="padding: 0.3rem 0.8rem; font-size: 0.8rem;">PDF</a>
                            {/if}
                        {/foreach}
                    </div>
                </div>
            </div>
        {/foreach}
        {if $currentSection != ""}</div>{/if}
        {if !$publishedSubmissions}<p>Belum ada artikel.</p>{/if}
    </div>
</div>

{include file="frontend/components/footer.tpl"}
