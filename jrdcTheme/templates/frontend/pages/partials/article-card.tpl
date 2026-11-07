{**
 * templates/frontend/pages/partials/article-card.tpl
 *}
<div class="article-card">
    <h3>
        <a href="{url page="article" op="view" path=$article->getBestArticleId()}">
            {$article->getLocalizedTitle()|escape}
        </a>
    </h3>
    <div class="article-meta">
        <span>{$article->getAuthorString()|escape}</span> <br>
        <span>{$article->getDatePublished()|date_format:$dateFormatShort}</span>
    </div>

    {if $article->getLocalizedAbstract()}
        <p class="article-abstract">
            {$article->getLocalizedAbstract()|strip_tags|truncate:150}
        </p>
    {/if}

    <div style="margin-top: 1rem;">
        {if $article->getPubId('doi')}
            <span class="badge badge-doi">DOI: {$article->getPubId('doi')|escape}</span>
        {/if}
        {if $article->getAccessStatus() == 1}
            <span class="badge badge-open-access">Open Access</span>
        {/if}
    </div>
</div>
