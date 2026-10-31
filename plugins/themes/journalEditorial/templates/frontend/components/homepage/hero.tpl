{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/hero.tpl
 *}
<section class="je-hero" aria-labelledby="je-hero-title">
	<div class="je-container">
		<div class="je-hero__inner">
			<div>
				<h1 id="je-hero-title" class="je-hero__title">{$currentJournal->getLocalizedName()|escape}</h1>
				{if $currentJournal->getLocalizedDescription()}
					<p class="je-hero__desc">{$currentJournal->getLocalizedDescription()|strip_tags|truncate:300|escape}</p>
				{/if}
				<div class="je-hero__actions">
					<a href="{url page="submission" op="submit"}" class="je-btn je-btn--primary">Submit Manuscript</a>
					{if $issue}
						<a href="{url page="issue" op="view" path=$issue->getId()}" class="je-btn je-btn--outline">Current Issue</a>
					{/if}
				</div>
			</div>
			{if $homepageImage}
				<div>
					<img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImage.altText|escape}" style="max-width:100%;border-radius:var(--je-radius);">
				</div>
			{/if}
		</div>
	</div>
</section>
