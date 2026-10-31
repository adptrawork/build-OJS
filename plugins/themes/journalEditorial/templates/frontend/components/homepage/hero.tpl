{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/hero.tpl
 *}
<section class="je-hero" aria-labelledby="je-hero-title">
	<div class="je-container">
		<div class="je-hero__inner">
			<div>
				<div class="je-hero__badge">
					<span class="material-symbols-outlined">verified</span>
					<span>{if $issue}Volume {$issue->getVolume()|default:'1'}, Number {$issue->getNumber()|default:'1'}, {$issue->getYear()|default:'2024'} &bull; {/if}Open Access &bull; Peer-Reviewed Journal</span>
				</div>
				<h1 id="je-hero-title" class="je-hero__title">{$currentJournal->getLocalizedName()|escape}</h1>
				{if $currentJournal->getLocalizedDescription()}
					<p class="je-hero__desc">{$currentJournal->getLocalizedDescription()|strip_tags|truncate:300|escape}</p>
				{/if}
				<div class="je-hero__actions">
					<a href="{url page="submission" op="submit"}" class="je-btn je-btn--primary">
						<span class="material-symbols-outlined">upload_file</span>
						Submit Manuscript
					</a>
					{if $issue}
						<a href="{url page="issue" op="view" path=$issue->getId()}" class="je-btn je-btn--outline">
							<span class="material-symbols-outlined">auto_stories</span>
							View Current Issue
						</a>
					{/if}
				</div>
			</div>
			{if $issue && $issue->getLocalizedCoverImageUrl()}
				<div class="je-cover-card">
					<span class="je-cover-badge">
						<span class="material-symbols-outlined" style="font-size:14px;">stars</span>
						Current Issue
					</span>
					<a href="{url page="issue" op="view" path=$issue->getId()}">
						<img src="{$issue->getLocalizedCoverImageUrl()}" alt="{$issue->getIssueIdentification()|escape}">
					</a>
				</div>
			{elseif $homepageImage}
				<div class="je-cover-card">
					<img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImage.altText|escape}">
				</div>
			{/if}
		</div>
	</div>
</section>
