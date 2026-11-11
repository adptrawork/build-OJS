{**
 * SangulineModern child theme - article summary override (parent: Sanguline)
 *
 * Article card matching the prototype issue page (issue.html): DOI/pages
 * ids row above the title, authors, and a single footer row with stats on
 * the left and the Abstrak / PDF actions on the right. The card title links
 * to the article, so no separate "Detail Naskah" button is rendered. Keeps
 * core/parent class names (.obj_article_summary, .title, .authors,
 * .galleys_links, .abstract_toggle) and preserves the author/galley/DOI
 * stats logic and JS hooks.
 *
 * @uses $article Article The article
 * @uses $authorUserGroups Traversible The set of author user groups
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $showDatePublished bool Show the date this article was published?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $heading string HTML heading element, default: h2
 *}
{assign var=publication value=$article->getCurrentPublication()}
{assign var=articlePath value=$article->getBestId()}
{if !$heading}
	{assign var="heading" value="h2"}
{/if}

{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

{assign var=articleAbstract value=$publication->getLocalizedData('abstract')}
{assign var=submissionPages value=$publication->getData('pages')}
{assign var=submissionDatePublished value=$publication->getData('datePublished')}

{* DOI resolving URL *}
{assign var="doiUrl" value=""}
{assign var="doiText" value=""}
{if $currentJournal}
	{foreach from=$pubIdPlugins item=pubIdPlugin}
		{if $pubIdPlugin->getPubIdType() == 'doi'}
			{assign var="pubId" value=$article->getStoredPubId('doi')}
			{if $pubId}
				{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
				{assign var="doiText" value=$pubId|escape}
			{/if}
			{break}
		{/if}
	{/foreach}
{/if}

<article class="obj_article_summary jrdc-article-card">
	{if $publication->getLocalizedData('coverImage')}
		<div class="cover jrdc-article-card__cover">
			<a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if} class="file">
				{assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
				<img
					src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
					alt="{$coverImage.altText|escape|default:''}"
					loading="lazy"
				>
			</a>
		</div>
	{/if}

	<div class="jrdc-article-card__body">
		{* DOI + pages row above the title (prototype: ids row) *}
		{if $doiUrl || $submissionPages}
			<div class="jrdc-article-card__ids">
				{if $doiUrl}
					<span class="doi jrdc-doi">
						<a href="{$doiUrl}" target="_blank" rel="noopener noreferrer">DOI: {$doiText}</a>
					</span>
				{/if}
				{if $submissionPages}
					<span class="pages">Hal. {$submissionPages|escape}</span>
				{/if}
			</div>
		{/if}

		<{$heading} class="title jrdc-article-card__title">
			<a id="article-{$article->getId()}" {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
				{if $currentContext}
					{$publication->getLocalizedTitle()|strip_unsafe_html}
					{assign var="localizedSubtitle" value=$publication->getLocalizedData('subtitle')|strip_unsafe_html}
					{if $localizedSubtitle}
						<span class="subtitle jrdc-article-card__subtitle">{$localizedSubtitle}</span>
					{/if}
				{else}
					{$article->getLocalizedTitle()|strip_unsafe_html}
					<span class="subtitle jrdc-article-card__subtitle">
						{$journal->getLocalizedName()|escape}
					</span>
				{/if}
			</a>
		</{$heading}>

		{* Authors with tooltip/popover on hover *}
		{if $showAuthor}
			<div class="authors jrdc-article-card__authors">
				{assign var="authors" value=$publication->getData('authors')}
				{foreach from=$authors item=author name=authorLoop}
					{assign var="affiliation" value=$author->getLocalizedData('affiliation')}
					{assign var="country" value=$author->getCountryLocalized()}
					{if $affiliation || $country}
						<span class="author_item has_tooltip jrdc-author">
							<span class="author_name">{$author->getFullName()|escape}</span>
							<span class="author_tooltip jrdc-author__tooltip" role="tooltip">
								{if $affiliation}
									<span class="tooltip_row">
										{$affiliation|escape}
									</span>
								{/if}
								{if $country}
									<span class="tooltip_row">
										{$country|escape}
									</span>
								{/if}
							</span>
						</span>
					{else}
						<span class="author_item jrdc-author">
							<span class="author_name">{$author->getFullName()|escape}</span>
						</span>
					{/if}
					{if !$smarty.foreach.authorLoop.last}<span class="author_separator">, </span>{/if}
				{/foreach}
			</div>
		{/if}

		{* Footer row: stats left, Abstrak/PDF right (prototype issue.html) *}
		<div class="article_actions jrdc-article-card__footer">
			<div class="jrdc-article-card__stats">
				{assign var="abstractViews" value=$article->getViews()}
				{assign var="totalDownloads" value=0}
				{foreach from=$article->getGalleys() item=statsGalley}
					{assign var="totalDownloads" value=$totalDownloads+$statsGalley->getViews()}
				{/foreach}
				<span class="stat_item views jrdc-stat">
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
					<span class="stat_value">{$abstractViews|default:0|number_format}</span>
					<span class="stat_label">{translate key="plugins.themes.sanguline.article.views"}</span>
				</span>
				<span class="stat_item downloads jrdc-stat">
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
					<span class="stat_value">{$totalDownloads|default:0|number_format}</span>
					<span class="stat_label">{translate key="plugins.themes.sanguline.article.downloads"}</span>
				</span>
				{if $showDatePublished && $submissionDatePublished}
					<span class="stat_item published jrdc-stat">
						<span class="stat_value">{$submissionDatePublished|date_format:$dateFormatShort}</span>
					</span>
				{/if}
			</div>

			<div class="jrdc-article-card__cta">
				{if $articleAbstract}
					<button type="button" class="abstract_toggle jrdc-chip-quiet" aria-expanded="false" aria-controls="abstract-{$article->getId()}" data-toggle-target="abstract-{$article->getId()}">
						<span class="toggle_label">Abstrak</span>
					</button>
				{/if}

				{if !$hideGalleys}
					<ul class="galleys_links jrdc-article-card__galleys list-unstyled">
						{foreach from=$article->getGalleys() item=galley}
							{if $primaryGenreIds}
								{assign var="file" value=$galley->getFile()}
								{if !$galley->getRemoteUrl() && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
									{continue}
								{/if}
							{/if}
							<li>
								{assign var="hasArticleAccess" value=$hasAccess}
								{if $currentContext->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == $smarty.const.ARTICLE_ACCESS_OPEN}
									{assign var="hasArticleAccess" value=1}
								{/if}
								{assign var="id" value="article-{$article->getId()}-galley-{$galley->getId()}"}
								{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley id=$id labelledBy="{$id} article-{$article->getId()}" hasAccess=$hasArticleAccess purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
							</li>
						{/foreach}
					</ul>
				{/if}
			</div>
		</div>

		{* Abstract content (toggled by .abstract_toggle, see js/jrdc.js) *}
		{if $articleAbstract}
			<div class="abstract_content jrdc-article-card__abstract" id="abstract-{$article->getId()}" hidden>
				{$articleAbstract|strip_unsafe_html}
			</div>
		{/if}

		{call_hook name="Templates::Issue::Issue::Article"}
	</div>
</article>
