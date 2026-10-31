{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/announcements.tpl
 *}
{if $announcements && $announcements->count() > 0}
<section class="je-section" aria-labelledby="je-news-title">
	<div class="je-container">
		<h2 id="je-news-title" class="je-section__title">News &amp; Announcements</h2>
		{foreach from=$announcements item=announcement}
		<div class="je-announcement">
			<h3 class="je-announcement__title">{$announcement->getLocalizedTitle()|escape}</h3>
			{if $announcement->getDatePosted()}
				<div class="je-announcement__date">{$announcement->getDatePosted()|date_format:"%Y-%m-%d"}</div>
			{/if}
			<div style="margin-top:var(--je-space-2);">{$announcement->getLocalizedDescription()|strip_unsafe_html}</div>
		</div>
		{/foreach}
	</div>
</section>
{/if}
