{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/footer.tpl
 *
 * Clean, modern-css.com inspired footer.
 *}
		</div><!-- pkp_structure_main -->

		{* Sidebars *}
		{if empty($isFullWidth)}
			{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
			{if $sidebarCode}
				<div class="pkp_structure_sidebar left" role="complementary">
					{$sidebarCode}
				</div>
			{/if}
		{/if}
	</div><!-- pkp_structure_content -->

	<div class="pkp_structure_footer_wrapper jilp-footer" role="contentinfo">
		<a id="pkp_content_footer"></a>
		<footer class="container">
			<div class="jilp-footer-grid">
				<div class="jilp-footer-brand">
					{if $displayPageHeaderLogo}
						<a class="jilp-footer-logo" href="{url page="index"}">
							<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" alt="{$displayPageHeaderLogo.altText|escape|default:$applicationName}" />
						</a>
					{/if}
					<a class="jilp-footer-name" href="{url page="index"}">
						{$currentJournal->getLocalizedName()|escape}
					</a>
					<p class="jilp-footer-desc">
						{translate key="plugins.themes.journalEditorial.footer.jrdcDesc"}
					</p>
					<div class="jilp-footer-issns">
						{if $currentJournal->getData('issn')}
							<span class="jilp-footer-issn">
								<span class="jilp-footer-issn-label">ISSN</span>
								<span class="jilp-footer-issn-value">{$currentJournal->getData('issn')|escape}</span>
							</span>
						{/if}
						{if $currentJournal->getData('onlineIssn')}
							<span class="jilp-footer-issn">
								<span class="jilp-footer-issn-label">e-ISSN</span>
								<span class="jilp-footer-issn-value">{$currentJournal->getData('onlineIssn')|escape}</span>
							</span>
						{/if}
					</div>
				</div>

				<div class="jilp-footer-col">
					<h4 class="jilp-footer-title">{translate key="plugins.themes.journalEditorial.footer.quickLinks"}</h4>
					<ul class="jilp-footer-links">
						<li><a href="{url page="about" op="editorialTeam"}">{translate key="plugins.themes.journalEditorial.footer.editorialTeam"}</a></li>
						<li><a href="{url page="announcement"}">{translate key="plugins.themes.journalEditorial.footer.announcements"}</a></li>
						<li><a href="{url page="issue" op="current"}">{translate key="plugins.themes.journalEditorial.footer.currentIssue"}</a></li>
						<li><a href="{url page="issue" op="archive"}">{translate key="plugins.themes.journalEditorial.footer.archives"}</a></li>
					</ul>
				</div>

				<div class="jilp-footer-col">
					<h4 class="jilp-footer-title">{translate key="plugins.themes.journalEditorial.footer.about"}</h4>
					<ul class="jilp-footer-links">
						<li><a href="{url page="about"}">{translate key="plugins.themes.journalEditorial.footer.aboutJournal"}</a></li>
						<li><a href="{url page="focus-and-scope"}">{translate key="plugins.themes.journalEditorial.footer.focusScope"}</a></li>
						<li><a href="{url page="about" op="editorialTeam"}">{translate key="plugins.themes.journalEditorial.footer.editorialTeam"}</a></li>
						<li><a href="{url page="indexing"}">{translate key="plugins.themes.journalEditorial.footer.indexing"}</a></li>
						<li><a href="{url page="about" op="privacy"}">{translate key="plugins.themes.journalEditorial.footer.privacy"}</a></li>
						<li><a href="{url page="contact-us"}">{translate key="plugins.themes.journalEditorial.footer.contact"}</a></li>
					</ul>
				</div>

				<div class="jilp-footer-col">
					<h4 class="jilp-footer-title">{translate key="plugins.themes.journalEditorial.footer.forAuthors"}</h4>
					<ul class="jilp-footer-links">
						<li><a href="{url page="author-guidelines"}">{translate key="plugins.themes.journalEditorial.footer.guidelines"}</a></li>
						<li><a href="{url page="author-fees"}">{translate key="plugins.themes.journalEditorial.footer.fees"}</a></li>
						<li><a href="{url page="submission" op="submit"}">{translate key="plugins.themes.journalEditorial.footer.submit"}</a></li>
						<li><a href="{url page="publication-ethics"}">{translate key="plugins.themes.journalEditorial.footer.ethics"}</a></li>
						<li><a href="{url page="open-access-statement"}">{translate key="plugins.themes.journalEditorial.footer.openAccess"}</a></li>
					</ul>
				</div>
			</div>

			<div class="jilp-footer-bottom">
				<p class="jilp-footer-copyright">
					&copy; {$smarty.now|date_format:"Y"} {$currentJournal->getLocalizedName()|escape}. {translate key="plugins.themes.journalEditorial.footer.rights"}
				</p>
				<p class="jilp-footer-credit">
					{translate key="plugins.themes.journalEditorial.footer.theme"} <span>Journal Editorial</span> &bull; Open Journal Systems
				</p>
			</div>
		</footer>
	</div><!-- pkp_structure_footer_wrapper -->

</div><!-- pkp_structure_page -->

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
