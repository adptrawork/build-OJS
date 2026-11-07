{**
 * Adptra journal homepage override for OJS 3.3.
 * Data comes from the OJS journal/context, homepage image, announcements,
 * current issue and published issue table of contents. No demo records exist.
 * The OJS default logo, account navigation and menus remain in the core header.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<main id="pkp_content_main" class="page page_index_journal adptra-home{if !$activeTheme->getOption('showHero')} adptra-home--no-hero{/if}">
    {call_hook name="Templates::Index::journal"}

    {if $activeTheme->getOption('showHero')}
        {include file="frontend/components/adptra/hero.tpl"}
    {/if}

    <div class="adptra-container">
        {if $activeTheme->getOption('showSearch')}
            {include file="frontend/components/adptra/search.tpl"}
        {/if}

        {if $activeTheme->getOption('showEditorialLink')}
            {include file="frontend/components/adptra/editorialLink.tpl"}
        {/if}

        {if $activeTheme->getOption('showJournalDescription') && $currentContext->getLocalizedData('description')}
            <section class="adptra-about" aria-labelledby="adptra-about-title">
                <div class="adptra-section-heading">
                    <span class="adptra-kicker">{translate key="plugins.themes.adptra.home.openAccess"}</span>
                    <h2 id="adptra-about-title">{translate key="plugins.themes.adptra.home.about"}</h2>
                </div>
                <div class="adptra-prose">
                    {$currentContext->getLocalizedData('description')}
                </div>
            </section>
        {/if}

        {if $activeTheme->getOption('showAnnouncements') && $numAnnouncementsHomepage && $announcements|@count}
            {include file="frontend/components/adptra/announcements.tpl"}
        {/if}

        {if $activeTheme->getOption('showCurrentIssue')}
            {include file="frontend/components/adptra/currentIssue.tpl"}
        {/if}

        {if $activeTheme->getOption('showAdditionalHomeContent') && $additionalHomeContent}
            <section class="adptra-additional-content" aria-label="{translate key="plugins.themes.adptra.home.about"}">
                {$additionalHomeContent}
            </section>
        {/if}
    </div>
</main>

{include file="frontend/components/footer.tpl"}
