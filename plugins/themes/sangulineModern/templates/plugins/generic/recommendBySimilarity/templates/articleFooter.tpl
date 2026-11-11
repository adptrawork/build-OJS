{**
 * SangulineModern theme override of
 * plugins/generic/recommendBySimilarity/templates/articleFooter.tpl
 * (parent: recommendBySimilarity)
 *
 * Item format changed to:
 *   {article title}
 *   {author list}
 *
 * Recommendation logic, plugin locale keys and pagination hook are kept
 * verbatim; the issue link is dropped (redundant with the article page).
 *}
<div id="articlesBySimilarityList">
	{assign var=recommendations value=$articlesBySimilarity->submissions}
	{if !$recommendations->wasEmpty()}
		<h3>
			<a name="articlesBySimilarity">{translate key="plugins.generic.recommendBySimilarity.heading"}</a>
		</h3>
		<ul>

			{iterate from="recommendations" item=submission}
				{assign var=publication value=$submission->getCurrentPublication()}

				<li>
					<a class="jrdc-similar__title" href="{url journal=$currentContext->getPath() page="article" op="view" path=$submission->getBestId()}">
						{$submission->getLocalizedTitle()|strip_unsafe_html}
					</a>
					<span class="jrdc-similar__author">
						{foreach from=$publication->getData('authors') item=author name=similarAuthors}
							{if $smarty.foreach.similarAuthors.iteration > 1}, {/if}{$author->getFullName()|escape}
						{/foreach}
					</span>
				</li>
			{/iterate}
		</ul>
		<p id="articlesBySimilarityPages">
			{page_links anchor="articlesBySimilarity" iterator=$recommendations name="articlesBySimilarity"}
		</p>
		<p id="articlesBySimilaritySearch">
			{capture assign="advancedSearchLink"}{strip}
				<a href="{url page="search" op="search" query=$articlesBySimilarity->query}">
					{translate key="plugins.generic.recommendBySimilarity.advancedSearch"}
				</a>
			{/strip}{/capture}
			{translate key="plugins.generic.recommendBySimilarity.advancedSearchIntro" advancedSearchLink=$advancedSearchLink}
		</p>
	{/if}
</div>
