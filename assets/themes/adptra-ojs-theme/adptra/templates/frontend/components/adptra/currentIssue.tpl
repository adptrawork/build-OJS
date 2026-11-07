<section class="adptra-current-issue" aria-labelledby="adptra-current-issue-title">
    {if $issue}
        <div class="adptra-section-heading adptra-section-heading--row">
            <div>
                <span class="adptra-kicker">{translate key="plugins.themes.adptra.home.currentIssue"}</span>
                <h2 id="adptra-current-issue-title">{$issue->getIssueIdentification()|strip_unsafe_html}</h2>
            </div>
            <a class="adptra-text-link" href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
                {translate key="plugins.themes.adptra.home.archive"}
                <span aria-hidden="true">&#8594;</span>
            </a>
        </div>
        {* The OJS core TOC prints only published content assigned to this issue. *}
        <div class="adptra-issue-toc">
            {include file="frontend/objects/issue_toc.tpl" heading="h3"}
        </div>
    {else}
        <div class="adptra-empty-state">
            <h2 id="adptra-current-issue-title">{translate key="plugins.themes.adptra.home.currentIssue"}</h2>
            <p>{translate key="plugins.themes.adptra.home.noIssue"}</p>
        </div>
    {/if}
</section>
