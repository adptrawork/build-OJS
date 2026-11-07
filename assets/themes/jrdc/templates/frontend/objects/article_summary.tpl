{**
 * templates/frontend/objects/article_summary.tpl
 * JRDC Theme — Article summary used in issue TOC & homepage
 *}
{assign var=articlePath value=$article->getBestId()}
{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

<li class="jrdc-article-item">
	{if $article->getLocalizedCoverImage()}
		{* Optional thumbnail *}
	{/if}

	{if $showAuthor}
		<div class="jrdc-article-authors">
			{$article->getAuthorString()|escape}
		</div>
	{/if}

	<h3 class="jrdc-article-title">
		<a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
			{$article->getLocalizedTitle()|strip_unsafe_html}
			{if $article->getLocalizedSubtitle()}
				<span class="subtitle">{$article->getLocalizedSubtitle()|escape}</span>
			{/if}
		</a>
	</h3>

	{if $article->getStoredPubId('doi')}
		<div class="jrdc-doi">
			<a href="{$article->getStoredPubId('doi')|escape}">https://doi.org/{$article->getStoredPubId('doi')|escape}</a>
		</div>
	{/if}

	<div class="jrdc-article-meta">
		{if !$hideGalleys}
			{foreach from=$article->getGalleys() item=galley}
				{if $primaryGenreIds}
					{assign var="file" value=$galley->getFile()}
					{if !$galley->getRemoteUrl() && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
						{continue}
					{/if}
				{/if}
				<a class="jrdc-galley-link" href="{url page="article" op="view" path=$articlePath|to_array:$galley->getBestGalleyId()}">
					{$galley->getGalleyLabel()|escape}
				</a>
			{/foreach}
		{/if}

		{if $article->getPages()}
			<span>{$article->getPages()|escape}</span>
		{/if}
	</div>
</li>
