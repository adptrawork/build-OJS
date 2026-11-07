{**
 * templates/frontend/pages/indexJournal.tpl
 * Halaman utama jurnal JRDC
 *}
{include file="frontend/components/header.tpl"}

<style>
    :root {
        --primary-color: {$activeTheme->getOption('primaryColor')|escape};
        --hero-color: {$activeTheme->getOption('heroColor')|escape};
    }
</style>

<div class="jrdc-hero">
    <div class="container mx-auto px-4">
        <h1>{$currentJournal->getLocalizedName()|escape}</h1>
        <p>{$currentJournal->getLocalizedDescription()|strip_tags|truncate:250}</p>
    </div>
</div>

<div class="container mx-auto px-4 py-8 max-w-6xl">
    <h2 class="text-2xl font-serif font-semibold text-slate-800 mb-4 border-b pb-2" style="font-family: var(--font-serif); margin-bottom: 1.5rem; border-bottom: 2px solid #e2e8f0; padding-bottom: 0.5rem;">
        Artikel Terbaru
    </h2>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1.5rem;">

        {if $currentIssue}
            {foreach from=$currentIssue->getPublishedSubmissions() item=article}
                {include file="frontend/pages/partials/article-card.tpl" article=$article}
            {/foreach}
        {elseif $latestSubmissions}
            {foreach from=$latestSubmissions item=submission}
                {if $submission->getData('status') == 3}
                    {include file="frontend/pages/partials/article-card.tpl" article=$submission}
                {/if}
            {/foreach}
        {else}
            <p class="text-muted">Belum ada artikel yang diterbitkan.</p>
        {/if}

    </div>
</div>

{include file="frontend/components/footer.tpl"}
