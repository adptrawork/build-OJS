{**
 * templates/frontend/pages/article.tpl
 *}
{include file="frontend/components/header.tpl"}

<style>
    :root {
        --primary-color: {$activeTheme->getOption('primaryColor')|escape};
    }
</style>

<div class="container mx-auto px-4 py-8 max-w-4xl" style="max-width: 800px; margin: 0 auto; padding: 2rem 1rem;">
    <article style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 0.75rem; padding: 2rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
        <h1 style="font-family: var(--font-serif); font-size: 2rem; font-weight: 700; color: #0f172a; margin-top: 0;">
            {$article->getLocalizedTitle()|escape}
        </h1>

        <div style="margin-top: 1rem; color: #475569; font-size: 0.95rem;">
            <strong>{$article->getAuthorString()|escape}</strong>
        </div>

        <div style="margin-top: 1.5rem; display: flex; flex-wrap: wrap; gap: 1rem; align-items: center; font-size: 0.875rem; padding-bottom: 1rem; border-bottom: 1px solid #e2e8f0;">
            <span style="color: #64748b;">Diterbitkan: {$article->getDatePublished()|date_format:$dateFormatLong}</span>
            {if $article->getPubId('doi')}
                <span class="badge badge-doi">DOI: {$article->getPubId('doi')|escape}</span>
            {/if}
        </div>

        {if $article->getLocalizedAbstract()}
            <div style="margin-top: 2rem;">
                <h2 style="font-family: var(--font-serif); font-size: 1.25rem; font-weight: 600; color: #1e293b; margin-bottom: 1rem;">Abstrak</h2>
                <p style="line-height: 1.7; color: #334155;">{$article->getLocalizedAbstract()|nl2br}</p>
            </div>
        {/if}

        {if $galleys}
            <div style="margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid #e2e8f0;">
                <h2 style="font-family: var(--font-serif); font-size: 1.25rem; font-weight: 600; color: #1e293b; margin-bottom: 1rem;">Unduh</h2>
                <div style="display: flex; flex-wrap: wrap; gap: 0.75rem;">
                    {foreach from=$galleys item=galley}
                        <a href="{url page="article" op="view" path=$article->getBestArticleId()|to_array:$galley->getBestGalleyId()}" class="btn btn-primary">
                            Unduh {$galley->getGalleyLabel()|escape}
                        </a>
                    {/foreach}
                </div>
            </div>
        {/if}
    </article>
</div>

{include file="frontend/components/footer.tpl"}
