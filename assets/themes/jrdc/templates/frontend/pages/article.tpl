{**
 * templates/frontend/pages/article.tpl
 * JRDC Theme — Article landing page (simplified override)
 * Falls back to default for most structure; adds JRDC styling wrappers.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$article->getLocalizedTitle()|strip_tags}

{assign var="sidebarPos" value=$activeTheme->getOption('sidebarPosition')|default:'right'}

<main id="jrdc-main" class="jrdc-main">
	<div class="jrdc-container">
		<div class="jrdc-grid jrdc-grid-12 jrdc-layout--sidebar-{$sidebarPos|escape}">
			<article class="jrdc-main-col jrdc-col-8" style="display:grid;gap:1.5rem;">
				<header class="jrdc-article-header jrdc-card">
					{if $section}
						<div class="jrdc-section-label" style="margin-top:0;">{$section->getLocalizedTitle()|escape}</div>
					{/if}

					<div style="display:flex;flex-wrap:wrap;gap:0.5rem;margin-bottom:0.75rem;">
						{if $article->getLicenseUrl()}
							<span class="jrdc-badge jrdc-badge-oa">Open Access</span>
						{/if}
						{if $currentContext->getData('peerReview')}
							<span class="jrdc-badge jrdc-badge-peer">Peer Reviewed</span>
						{/if}
					</div>

					<h1>{$article->getLocalizedTitle()|strip_unsafe_html}</h1>
					{if $article->getLocalizedSubtitle()}
						<p style="font-size:1.125rem;color:var(--jrdc-slate-600);margin:0 0 1rem;">{$article->getLocalizedSubtitle()|escape}</p>
					{/if}

					{if $article->getAuthors()}
						<div class="jrdc-article-authors" style="font-size:1rem;margin-bottom:1rem;">
							{foreach from=$article->getAuthors() item=author name=authors}
								{$author->getFullName()|escape}{if !$smarty.foreach.authors.last}; {/if}
							{/foreach}
						</div>
					{/if}

					{if $publication->getData('datePublished')}
						<p style="font-size:0.875rem;color:var(--jrdc-slate-500);margin:0;">
							{translate key="submissions.published"}: {$publication->getData('datePublished')|date_format:$dateFormatLong}
						</p>
					{/if}

					{if $publication->getStoredPubId('doi')}
						<p class="jrdc-doi" style="margin-top:0.5rem;">
							<strong>DOI:</strong>
							<a href="https://doi.org/{$publication->getStoredPubId('doi')|escape}">https://doi.org/{$publication->getStoredPubId('doi')|escape}</a>
						</p>
					{/if}

					{* Galleys *}
					{if $primaryGalleys || $supplementaryGalleys}
						<div style="margin-top:1.25rem;display:flex;flex-wrap:wrap;gap:0.5rem;">
							{foreach from=$primaryGalleys item=galley}
								{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley}
							{/foreach}
							{foreach from=$supplementaryGalleys item=galley}
								{include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley isSupplementary=true}
							{/foreach}
						</div>
					{/if}
				</header>

				{* Abstract *}
				{if $publication->getLocalizedData('abstract')}
					<section class="jrdc-card">
						<h2 class="jrdc-card-title">{translate key="article.abstract"}</h2>
						<div class="jrdc-prose">
							{$publication->getLocalizedData('abstract')|strip_unsafe_html}
						</div>
					</section>
				{/if}

				{* Keywords *}
				{if !empty($publication->getLocalizedData('keywords'))}
					<section class="jrdc-card">
						<h2 class="jrdc-card-title">{translate key="common.keywords"}</h2>
						<p style="margin:0;">
							{foreach name=keywords from=$publication->getLocalizedData('keywords') item=keyword}
								<span class="jrdc-badge jrdc-badge-peer" style="margin:0 0.25rem 0.25rem 0;">{$keyword|escape}</span>
							{/foreach}
						</p>
					</section>
				{/if}

				{* How to cite / References etc. are handled by default hooks or child templates *}
				{call_hook name="Templates::Article::Main"}
			</article>

			{if $sidebarPos != 'none'}
				<aside class="jrdc-side-col jrdc-col-4" role="complementary">
					{call_hook name="Templates::Article::Details"}
					{call_hook name="Templates::Common::Sidebar"}
				</aside>
			{/if}
		</div>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
