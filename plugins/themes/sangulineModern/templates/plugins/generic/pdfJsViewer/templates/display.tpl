{**
 * SangulineModern theme override of plugins/generic/pdfJsViewer/templates/display.tpl
 * (parent: pdfJsViewer)
 *
 * Compact chrome-free viewer: the PDF fills the whole page; the surrounding
 * article page already provides return/download/chrome. The plugin's jQuery
 * iframe src bootstrap is kept verbatim (the embedded viewer depends on it).
 *}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>{translate key="article.pageTitle" title=$title|escape}</title>

	{load_header context="frontend" headers=$headers}
	{load_stylesheet context="frontend" stylesheets=$stylesheets}
	{load_script context="frontend" scripts=$scripts}
</head>
<body class="pkp_page_{$requestedPage|escape} pkp_op_{$requestedOp|escape}">

	<script type="text/javascript">
		// Creating iframe's src in JS instead of Smarty so that EZProxy-using sites can find our domain in $pdfUrl and do their rewrites on it.
		$(document).ready(function() {ldelim}
			var urlBase = "{$pluginUrl}/pdf.js/web/viewer.html?file=";
			var pdfUrl = {$pdfUrl|json_encode:JSON_UNESCAPED_SLASHES};
			$("#pdfCanvasContainer > iframe").attr("src", urlBase + encodeURIComponent(pdfUrl));
		{rdelim});
	</script>

	<div id="pdfCanvasContainer" class="galley_view{if !$isLatestPublication} galley_view_with_notice{/if}">
		{if !$isLatestPublication}
			<div class="galley_view_notice">
				<div class="galley_view_notice_message" role="alert">
					{$datePublished}
				</div>
			</div>
		{/if}
		<iframe src="" width="100%" height="100%" style="min-height: 500px;" title="{$galleyTitle|escape}" allow="fullscreen" webkitallowfullscreen="webkitallowfullscreen"></iframe>
	</div>
	{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
