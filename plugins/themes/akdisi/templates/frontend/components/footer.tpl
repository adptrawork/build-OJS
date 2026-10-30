{**
 * @file plugins/themes/akdisi/templates/frontend/components/footer.tpl
 *
 * Footer theme AKDISI. Menambahkan back-to-top dan wrapper slot S-HOME-14.
 * Struktur inti diwarisi dari theme default.
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

<div class="pkp_structure_footer_wrapper akdisi-footer" role="contentinfo" data-slot="S-HOME-14">
	<a id="pkp_content_footer"></a>

	<div class="pkp_structure_footer">
		{if $pageFooter}
			<div class="pkp_footer_content">
				{$pageFooter}
			</div>
		{/if}
	</div>

	{include file="frontend/components/floatingActions.tpl"}
</div>

</div><!-- pkp_structure_page -->

{load_script context="frontend"}
</body>
</html>
