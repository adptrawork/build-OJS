{* The official OJS Homepage Image is reused. Upload/change it at Website > Appearance. *}
<section class="adptra-hero{if !$activeTheme->getOption('showHomepageImage') || !$homepageImage} adptra-hero--text-only{/if}" aria-labelledby="adptra-hero-title">
    <div class="adptra-hero__inner">
        <div class="adptra-hero__copy">
            <p class="adptra-hero__eyebrow">
                {if $activeTheme->getOption('heroEyebrow')}
                    {$activeTheme->getOption('heroEyebrow')|escape}
                {else}
                    {translate key="plugins.themes.adptra.home.eyebrow"}
                {/if}
            </p>
            <h1 id="adptra-hero-title">
                {if $activeTheme->getOption('heroTitle')}
                    {$activeTheme->getOption('heroTitle')|escape}
                {else}
                    {$currentJournal->getLocalizedName()|escape}
                {/if}
            </h1>
            {if $activeTheme->getOption('heroSubtitle')}
                <p class="adptra-hero__description">{$activeTheme->getOption('heroSubtitle')|escape|nl2br}</p>
            {/if}
        </div>
        {if $activeTheme->getOption('showHomepageImage') && $homepageImage}
            <div class="adptra-hero__image">
                <img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}"
                    {if $homepageImage.altText}
                        alt="{$homepageImage.altText|escape}"
                    {else}
                        alt="{translate key="plugins.themes.adptra.home.bannerImageAlt"}"
                    {/if}
                    loading="eager">
            </div>
        {/if}
    </div>
    <div class="adptra-hero__rule" aria-hidden="true"></div>
</section>
