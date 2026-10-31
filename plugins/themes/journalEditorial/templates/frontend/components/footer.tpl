{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/footer.tpl
 *
 * Bootstrap 5 footer replicating the JILP / Zenith layout.
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
		<footer class="container-fluid px-3 px-sm-4 px-lg-5" style="max-width:1440px;">
			<div class="row gx-4 gx-xl-5 gy-4 justify-content-between">
				<div class="col-12 col-lg-3 mb-4 mb-lg-0">
					<div class="text-center mb-2">
						<a class="d-inline-block" href="{url page="index"}">
							{if $displayPageHeaderLogo}
								<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" alt="{$displayPageHeaderLogo.altText|escape|default:$applicationName}" style="max-height:65px;max-width:100%;object-fit:contain;" />
							{else}
								<span class="text-white fw-bold fs-5">{$currentJournal->getLocalizedName()|escape}</span>
							{/if}
						</a>
					</div>
					<div class="text-center mb-3">
						<a class="text-white text-decoration-none" href="{url page="index"}">
							<h3 class="h5 text-white fw-bold mb-0 lh-base" style="font-size:1.15rem;letter-spacing:-.2px;">
								{$currentJournal->getLocalizedName()|escape}
							</h3>
						</a>
					</div>
					<div class="text-white-50 small mb-3 fst-italic jilp-footer-desc">
						{$currentJournal->getLocalizedDescription()|strip_tags|truncate:240|escape}
						<a class="jilp-footer-readmore" href="{url page="about"}">Read More &raquo;</a>
					</div>
					<div class="d-flex flex-wrap justify-content-center gap-2 mb-3">
						{if $currentJournal->getData('issn')}
							<div class="jilp-footer-issn shadow-sm">
								<div class="jilp-footer-issn-label">ISSN</div>
								<div class="jilp-footer-issn-value">{$currentJournal->getData('issn')|escape}</div>
							</div>
						{/if}
						{if $currentJournal->getData('onlineIssn')}
							<div class="jilp-footer-issn shadow-sm">
								<div class="jilp-footer-issn-label">e-ISSN</div>
								<div class="jilp-footer-issn-value">{$currentJournal->getData('onlineIssn')|escape}</div>
							</div>
						{/if}
					</div>
				</div>

				<div class="col-6 col-md-4 col-lg-2 mb-4 mb-lg-0">
					<h4 class="jilp-footer-title">Quick Links</h4>
					<ul class="jilp-footer-links list-unstyled">
						<li><a href="{url page="about" op="editorialTeam"}">Editorial Team</a></li>
						<li><a href="{url page="announcement"}">Announcements</a></li>
						<li><a href="{url page="issue" op="current"}">Current Issue</a></li>
						<li><a href="{url page="issue" op="archive"}">Archives</a></li>
					</ul>
				</div>

				<div class="col-6 col-md-4 col-lg-2 mb-4 mb-lg-0">
					<h4 class="jilp-footer-title">About</h4>
					<ul class="jilp-footer-links list-unstyled">
						<li><a href="{url page="about"}">About the Journal</a></li>
						<li><a href="{url page="about" op="editorialTeam"}">Editorial Team</a></li>
						<li><a href="{url page="about" op="privacy"}">Privacy Statement</a></li>
						<li><a href="{url page="about" op="contact"}">Contact</a></li>
					</ul>
				</div>

				<div class="col-12 col-md-4 col-lg-2 mb-4 mb-lg-0">
					<h4 class="jilp-footer-title">For Authors</h4>
					<ul class="jilp-footer-links list-unstyled">
						<li><a href="{url page="about" op="submissions"}">Author Guidelines</a></li>
						<li><a href="{url page="submission" op="submit"}">Submit Manuscript</a></li>
						<li><a href="{url page="about" op="submissions"}">Publication Ethics</a></li>
						<li><a href="{url page="about"}">Open Access</a></li>
					</ul>
				</div>

				<div class="col-12 col-lg-3 mb-4 mb-lg-0">
					<h4 class="jilp-footer-title">Contact &amp; Editorial Office</h4>
					<div class="text-white-50 small mb-3 jilp-footer-contact">
						{if $currentJournal->getData('contactName')}
							<p class="mb-2">
								<i class="bi bi-person me-2 text-primary"></i>
								{$currentJournal->getData('contactName')|escape}
							</p>
						{/if}
						{if $currentJournal->getData('contactEmail')}
							<p class="mb-2">
								<i class="bi bi-envelope me-2 text-primary"></i>
								<a class="text-white-50 text-decoration-none" href="mailto:{$currentJournal->getData('contactEmail')|escape}">
									{$currentJournal->getData('contactEmail')|escape}
								</a>
							</p>
						{/if}
						{if $currentJournal->getData('supportEmail')}
							<p class="mb-3">
								<i class="bi bi-headset me-2 text-primary"></i>
								Support:
								<a class="text-white-50 text-decoration-none" href="mailto:{$currentJournal->getData('supportEmail')|escape}">
									{$currentJournal->getData('supportEmail')|escape}
								</a>
							</p>
						{/if}
					</div>
					<div class="rounded p-2 px-3 border shadow-sm d-inline-block w-100 jilp-footer-ojs">
						<a class="text-decoration-none d-flex align-items-center gap-3" href="{url page="about" op="aboutThisPublishingSystem"}">
							<div class="rounded p-2 d-flex align-items-center justify-content-center jilp-footer-ojs-icon">
								<i class="bi bi-journal-code fs-5"></i>
							</div>
							<div>
								<span class="text-white fw-bold d-block" style="font-size:.88rem;letter-spacing:-.2px;">Open Journal Systems</span>
								<span style="font-size:.72rem;color:rgba(255,255,255,.45);">Public Knowledge Project</span>
							</div>
						</a>
					</div>
				</div>
			</div>

			{if $pageFooter}
				<div class="jilp-footer-pagecontent text-center mt-4 pt-4 border-top border-secondary text-white-50">
					{$pageFooter}
				</div>
			{/if}

			<div class="jilp-footer-copyright d-flex flex-column flex-md-row align-items-center justify-content-between text-center text-md-start gap-3 mt-4 pt-4 border-top border-secondary">
				<p class="mb-0">
					&copy; {$smarty.now|date_format:"%Y"} {$currentJournal->getLocalizedName()|escape}. All rights reserved. Powered by Open Journal Systems.
				</p>
				<p class="mb-0 text-white-50 small">
					Theme <span class="text-primary fw-bold">Journal Editorial</span>
					&bull; Bootstrap 5.3.3
				</p>
			</div>
		</footer>
	</div><!-- pkp_structure_footer_wrapper -->

</div><!-- pkp_structure_page -->

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
