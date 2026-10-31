{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/articleCard.tpl
 *
 * @uses $article object
 *}
<article class="jilp-article-card h-100">
	<div class="jilp-article-header">
		<div class="jilp-article-icon shadow-sm"><i class="bi bi-journal-text"></i></div>
		<span class="jilp-article-category">{$article->section|default:"Research Article"|escape}</span>
	</div>

	<h3 class="jilp-article-title">
		<a href="{url page="article" op="view" path=$article->id}">{$article->title|escape}</a>
	</h3>

	<div class="jilp-article-authors">
		<i class="bi bi-person-fill me-1"></i>
		{$article->authors|escape|default:"Unknown author"}
	</div>

	<div class="jilp-article-badges">
		{if $article->issueTitle}
			<span class="badge bg-primary-subtle text-primary border border-primary-subtle">{$article->issueTitle|escape}</span>
		{/if}
		{if $article->doi}
			<a class="badge bg-secondary-subtle text-secondary border border-secondary-subtle text-decoration-none" href="https://doi.org/{$article->doi|escape}" target="_blank" rel="noopener">DOI</a>
		{/if}
	</div>

	{if $article->abstract}
		<p class="jilp-article-abstract">{$article->abstract|strip_tags|truncate:180|escape}</p>
	{/if}

	<div class="jilp-article-footer">
		<span class="jilp-article-meta">
			{if $article->date}<i class="bi bi-calendar3 me-1"></i>{$article->date|date_format:$dateFormatShort}{/if}
			{if $article->pages}<span class="ms-2">pp. {$article->pages|escape}</span>{/if}
		</span>
		<a class="jilp-pdf-link" href="{url page="article" op="view" path=$article->id}">
			<i class="bi bi-file-earmark-pdf me-1"></i> PDF
		</a>
	</div>
</article>
