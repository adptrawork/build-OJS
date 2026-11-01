{**
 * templates/content.tpl
 *
 * Display Static Page content — styled to match journalEditorial theme.
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$title}

<div class="page page_static" data-slot="S-PAGE">
	<div class="pkp_structure_content">
		<div class="pkp_structure_main jilp-inner" role="main">
			<a id="pkp_content_main"></a>
			<div class="jilp-prose jilp-static-content">
				{$content}
			</div>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
