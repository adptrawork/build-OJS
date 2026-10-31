{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/footer.tpl
 * Footer ringkas dengan identitas jurnal.
 *}
	</div><!-- pkp_structure_main -->

	{* Sidebars bawaan OJS *}
	{if empty($isFullWidth)}
		{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
		{if $sidebarCode}
			<div class="pkp_structure_sidebar left" role="complementary">
				{$sidebarCode}
			</div>
		{/if}
	{/if}
</div><!-- pkp_structure_content -->

<div class="pkp_structure_footer_wrapper je-footer" role="contentinfo">
	<a id="pkp_content_footer"></a>
	<div class="pkp_structure_footer je-container">
		{if $pageFooter}
			<div class="pkp_footer_content">
				{$pageFooter}
			</div>
		{/if}
		<p>&copy; {$smarty.now|date_format:"%Y"} {$currentJournal->getLocalizedName()|escape}. All rights reserved.</p>
		{if $currentJournal->getData('issn')}
			<p>ISSN: {$currentJournal->getData('issn')|escape}</p>
		{/if}
	</div>
</div>

</div><!-- pkp_structure_page -->

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
