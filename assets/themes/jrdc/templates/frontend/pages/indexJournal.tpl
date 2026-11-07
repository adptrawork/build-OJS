{**
 * templates/frontend/pages/indexJournal.tpl
 * JRDC Theme — Journal homepage
 * Uses default OJS data (currentIssue, announcements, journal description, etc.)
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentContext->getLocalizedName()}

{assign var="sidebarPos" value=$activeTheme->getOption('sidebarPosition')|default:'right'}
{assign var="showHeroCover" value=$activeTheme->getOption('showHeroCover')|default:'1'}
{assign var="showJournalDesc" value=$activeTheme->getOption('showJournalDescription')|default:'1'}
{assign var="showAnnouncements" value=$activeTheme->getOption('showAnnouncementsOnHomepage')|default:'1'}
{assign var="showCurrentArticles" value=$activeTheme->getOption('showCurrentIssueArticles')|default:'1'}
{assign var="annCount" value=$activeTheme->getOption('announcementsHomepageCount')|default:3}
{assign var="heroEyebrow" value=$activeTheme->getOption('heroEyebrow')}

<main id="jrdc-main" class="jrdc-main">
	{* ========== HERO ========== *}
	<section class="jrdc-hero">
		<div class="jrdc-container">
			<div class="jrdc-hero-banner">
				<div class="jrdc-hero-grid">
					<div>
						{if $heroEyebrow}
							<div class="jrdc-hero-eyebrow">{$heroEyebrow|escape}</div>
						{/if}
						<h1 class="jrdc-hero-title">
							{$currentContext->getLocalizedName()|escape}
						</h1>
						{if $currentContext->getLocalizedDescription()}
							<p class="jrdc-hero-desc">
								{$currentContext->getLocalizedDescription()|strip_tags|truncate:280}
							</p>
						{/if}

						<dl class="jrdc-hero-meta">
							{if $currentContext->getData('publishingMode') || $currentIssue}
								<div>
									<dt>{translate key="issue.issues"}</dt>
									<dd>
										{if $currentIssue}
											{$currentIssue->getIssueIdentification()|escape}
										{else}
											—
										{/if}
									</dd>
								</div>
							{/if}
							{if $currentContext->getData('publisherInstitution')}
								<div>
									<dt>{translate key="context.context"} / Publisher</dt>
									<dd>{$currentContext->getData('publisherInstitution')|escape}</dd>
								</div>
							{/if}
						</dl>
					</div>

					{if $showHeroCover == '1' && $currentIssue && $currentIssue->getLocalizedCoverImageUrl()}
						<div class="jrdc-hero-cover">
							<a href="{url page="issue" op="view" path=$currentIssue->getBestIssueId()}">
								<img src="{$currentIssue->getLocalizedCoverImageUrl()|escape}" alt="{$currentIssue->getLocalizedCoverImageAltText()|escape|default:$currentIssue->getIssueIdentification()|escape}">
							</a>
						</div>
					{/if}
				</div>
			</div>
		</div>
	</section>

	{* ========== MAIN CONTENT ========== *}
	<div class="jrdc-container" style="margin-top:2.5rem;">
		<div class="jrdc-grid jrdc-grid-12 jrdc-layout--sidebar-{$sidebarPos|escape}">
			<div class="jrdc-main-col jrdc-col-8 space-y-8" style="display:grid;gap:2rem;">

				{* Journal Description / About *}
				{if $showJournalDesc == '1' && $currentContext->getLocalizedDescription()}
					<section class="jrdc-card">
						<h2 class="jrdc-card-title">{translate key="about.aboutContext"}</h2>
						<div class="jrdc-prose">
							{$currentContext->getLocalizedDescription()}
						</div>

						{* Quick info cards from custom blocks or static *}
						<div class="jrdc-info-grid">
							{if $currentContext->getLocalizedData('focusScopeDesc')}
								<div class="jrdc-info-card">
									<h3>{translate key="about.focusAndScope"}</h3>
									<p>{$currentContext->getLocalizedData('focusScopeDesc')|strip_tags|truncate:120}</p>
								</div>
							{/if}
							<a href="{url page="about" op="editorialTeam"}" class="jrdc-info-card">
								<h3>{translate key="about.editorialTeam"}</h3>
								<p>{translate key="about.editorialTeam"}</p>
							</a>
							<a href="{url page="about" op="submissions"}" class="jrdc-info-card">
								<h3>{translate key="about.authorGuidelines"}</h3>
								<p>{translate key="about.authorGuidelines"}</p>
							</a>
							<a href="{url page="about"}" class="jrdc-info-card">
								<h3>{translate key="about.aboutContext"}</h3>
								<p>{translate key="about.contact"}</p>
							</a>
						</div>
					</section>
				{/if}

				{* Announcements *}
				{if $showAnnouncements == '1' && $numAnnouncementsHomepage && $announcements|@count}
					<section class="jrdc-card">
						<h2 class="jrdc-card-title">{translate key="announcement.announcements"}</h2>
						<ul class="jrdc-announce-list">
							{foreach name=ann from=$announcements item=announcement}
								{if $smarty.foreach.ann.iteration > $annCount}{break}{/if}
								<li class="jrdc-announce-item">
									<div class="jrdc-date-badge">
										<strong>{$announcement->getDatePosted()|date_format:"%d"}</strong>
										<small>{$announcement->getDatePosted()|date_format:"%b"}</small>
									</div>
									<div>
										<h3 class="jrdc-announce-title">
											<a href="{url page="announcement" op="view" path=$announcement->getId()}">
												{$announcement->getLocalizedTitle()|escape}
											</a>
										</h3>
										{if $announcement->getLocalizedDescriptionShort()}
											<p class="jrdc-announce-excerpt">{$announcement->getLocalizedDescriptionShort()|strip_tags|truncate:160}</p>
										{/if}
									</div>
								</li>
							{/foreach}
						</ul>
						{if $announcements|@count > $annCount}
							<p style="margin-top:1.25rem;margin-bottom:0;">
								<a href="{url page="announcement"}" class="jrdc-btn jrdc-btn-primary">{translate key="common.more"}</a>
							</p>
						{/if}
					</section>
				{/if}

				{* Current Issue Articles *}
				{if $showCurrentArticles == '1' && $currentIssue}
					<section class="jrdc-card">
						<div style="display:flex;justify-content:space-between;align-items:baseline;flex-wrap:wrap;gap:0.75rem;margin-bottom:1.5rem;padding-bottom:1rem;border-bottom:1px solid var(--jrdc-slate-100);">
							<h2 class="jrdc-card-title" style="margin:0;padding:0;border:0;">
								{translate key="journal.currentIssue"}
							</h2>
							<a href="{url page="issue" op="view" path=$currentIssue->getBestIssueId()}" style="font-size:0.875rem;font-weight:600;">
								{$currentIssue->getIssueIdentification()|escape} →
							</a>
						</div>

						{foreach from=$publishedSubmissions item=section}
							{if $section.articles}
								{if $section.title}
									<div class="jrdc-section-label">{$section.title|escape}</div>
								{/if}
								<ul class="jrdc-article-list">
									{foreach from=$section.articles item=article}
										{include file="frontend/objects/article_summary.tpl" article=$article hideGalleys=false}
									{/foreach}
								</ul>
							{/if}
						{/foreach}

						{if !$publishedSubmissions}
							<div class="jrdc-empty">
								<p>{translate key="issue.noArticles"}</p>
							</div>
						{/if}
					</section>
				{/if}

				{* Additional Homepage Content (from Website Settings) *}
				{if $additionalHomeContent}
					<section class="jrdc-card">
						<div class="jrdc-prose">
							{$additionalHomeContent}
						</div>
					</section>
				{/if}

			</div>{* /.jrdc-main-col *}

			{* Sidebar *}
			{if $sidebarPos != 'none'}
				<aside class="jrdc-side-col jrdc-col-4" role="complementary">
					{if $currentIssue && $currentIssue->getLocalizedCoverImageUrl() && $showHeroCover != '1'}
						<div class="jrdc-side-card">
							<a href="{url page="issue" op="view" path=$currentIssue->getBestIssueId()}">
								<img src="{$currentIssue->getLocalizedCoverImageUrl()|escape}" alt="{$currentIssue->getLocalizedCoverImageAltText()|escape}" style="border-radius:0.75rem;width:100%;">
							</a>
							<p style="margin:0.75rem 0 0;font-size:0.8125rem;text-align:center;">
								<a href="{url page="issue" op="view" path=$currentIssue->getBestIssueId()}">{$currentIssue->getIssueIdentification()|escape}</a>
							</p>
						</div>
					{/if}

					{* Standard OJS sidebar blocks *}
					{call_hook name="Templates::Common::Sidebar"}
				</aside>
			{/if}
		</div>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
