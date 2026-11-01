{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/article_pdf_embed.tpl
 *
 * Embed the first PDF galley directly on the article page.
 * @uses $article Submission
 * @uses $publication Publication
 * @uses $primaryGalleys array
 *}
{assign var="pdfGalley" value=null}
{assign var="pdfRemote" value=false}
{if $primaryGalleys}
	{foreach from=$primaryGalleys item=galley}
		{if !$pdfGalley && ($galley->isPdfGalley() || $galley->getRemoteUrl())}
			{assign var="pdfGalley" value=$galley}
			{if !$galley->isPdfGalley() && $galley->getRemoteUrl()}
				{assign var="pdfRemote" value=true}
			{/if}
		{/if}
	{/foreach}
{/if}
{if $pdfGalley}
	{if $pdfRemote}
		{assign var="pdfUrl" value=$pdfGalley->getRemoteUrl()}
	{elseif $publication && $publication->getId() !== $article->getData('currentPublicationId')}
		{assign var="pdfPath" value=$article->getBestId()|to_array:"version":$publication->getId():$pdfGalley->getBestGalleyId()}
		{capture assign="pdfUrl"}{url page="article" op="view" path=$pdfPath}{/capture}
	{else}
		{assign var="parentId" value=$publication->getData('urlPath')|default:$article->getId()}
		{assign var="pdfPath" value=$parentId|to_array:$pdfGalley->getBestGalleyId()}
		{capture assign="pdfUrl"}{url page="article" op="view" path=$pdfPath}{/capture}
	{/if}
	<section class="jilp-pdf-section" data-slot="S-ART-PDF">
		<h2 class="jilp-pdf-title">{translate key="plugins.themes.journalEditorial.pdf.title"}</h2>
		<iframe class="jilp-pdf-embed" src="{$pdfUrl|escape}" title="{translate key="plugins.themes.journalEditorial.pdf.title"}">
			<p>{translate key="plugins.themes.journalEditorial.pdf.noEmbed"} <a href="{$pdfUrl|escape}">{translate key="plugins.themes.journalEditorial.pdf.download"}</a></p>
		</iframe>
	</section>
{/if}
