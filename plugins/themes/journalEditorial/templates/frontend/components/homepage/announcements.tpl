{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/announcements.tpl
 *}
{if $announcements && $announcements->count() > 0}
<section class="je-section" aria-labelledby="je-news-title" style="background: var(--je-surface-container-low);">
	<div class="je-container">
		<div class="je-section__header">
			<div>
				<h2 id="je-news-title" class="je-section__title">News &amp; Announcements</h2>
			</div>
		</div>
		<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:var(--je-space-lg);">
			{foreach from=$announcements item=announcement}
			<div class="je-announcement">
				<h3 class="je-announcement__title">{$announcement->getLocalizedData('title')|escape}</h3>
				{if $announcement->datePosted}
					<div class="je-announcement__date">{$announcement->datePosted|date_format:"%Y-%m-%d"}</div>
				{/if}
				<div class="je-announcement__desc">{$announcement->getLocalizedData('descriptionShort')|strip_unsafe_html}</div>
			</div>
			{/foreach}
		</div>
	</div>
</section>
{/if}
