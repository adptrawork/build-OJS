<section class="adptra-announcements" aria-labelledby="adptra-announcements-title">
    <div class="adptra-section-heading adptra-section-heading--row">
        <div>
            <span class="adptra-kicker">{translate key="plugins.themes.adptra.home.latestNotice"}</span>
            <h2 id="adptra-announcements-title">{translate key="announcement.announcements"}</h2>
        </div>
        <a class="adptra-text-link" href="{url page="announcement" op="announcements"}">
            {translate key="common.viewAll"}
            <span aria-hidden="true">&#8594;</span>
        </a>
    </div>
    <div class="adptra-announcements__list">
        {foreach name=adptraAnnouncements from=$announcements item=announcement}
            {if $smarty.foreach.adptraAnnouncements.iteration > $numAnnouncementsHomepage}
                {break}
            {/if}
            <article class="adptra-announcement">
                <p class="adptra-announcement__date">{$announcement->getDatePosted()|date_format:$dateFormatShort}</p>
                <h3>
                    <a href="{url page="announcement" op="view" path=$announcement->getId()}">
                        {$announcement->getLocalizedTitle()|escape}
                    </a>
                </h3>
            </article>
        {/foreach}
    </div>
</section>
