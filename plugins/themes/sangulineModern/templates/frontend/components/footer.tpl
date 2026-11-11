{**
 * SangulineModern child theme - footer override (parent: Sanguline)
 * Closes the Bootstrap content shell opened by header.tpl, renders the single
 * Sidebar hook, then the 4-column footer.
 *}

				</div><!-- .jrdc-main col -->

				{* Sidebars *}
				{if empty($isFullWidth)}
					{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
					{if $sidebarCode}
						<aside class="col-12 col-xl-4 pkp_structure_sidebar left jrdc-sidebar" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
							{* Sidebar Navigation Menu - appears at top of sidebar *}
							{capture assign="sidebarMenu"}{load_menu name="sidebar" id="navigationSidebar" ulClass="pkp_nav_list"}{/capture}
							{if $sidebarMenu|trim != ""}
								<div class="pkp_block block_sidebar_nav jrdc-sidebar__nav">
									<h2 class="pkp_block_title jrdc-sidebar__title">{translate key="plugins.themes.sanguline.sidebar.additionalMenu"}</h2>
									{$sidebarMenu}
								</div>
							{/if}
							{$sidebarCode}
						</aside><!-- .jrdc-sidebar -->
					{/if}
				{/if}
			</div><!-- .row -->
		</div><!-- .jrdc-content -->

		<footer class="pkp_structure_footer_wrapper jrdc-footer" role="contentinfo">
			<a id="pkp_content_footer"></a>

			<div class="pkp_structure_footer jrdc-footer__inner">
				<div class="container-fluid jrdc-container">
					<div class="row g-4">

						{* Column 1: Brand & Publisher Blurb *}
						<div class="col-12 col-lg-4 footer-col footer-col--brand">
							<div class="footer-brand__title">
								{$currentJournal->getLocalizedName()|escape|default:"Jurnal Ratu Dirgantara Cendekiawan"}
							</div>
							<p class="footer-brand__desc">
								{translate key="plugins.themes.sangulineModern.footer.publisherDesc"}
							</p>
							<p class="footer-brand__note">
								{translate key="plugins.themes.sangulineModern.footer.note"}
							</p>
						</div>

						{* Column 2: Untuk Penulis *}
						<div class="col-12 col-sm-6 col-lg-2 footer-col">
							<h3 class="footer-col__title">{translate key="plugins.themes.sangulineModern.footer.forAuthors"}</h3>
							<ul class="list-unstyled">
								<li><a href="{url page="about" op="submissions"}">{translate key="plugins.themes.sangulineModern.about.authorGuidelines"}</a></li>
								<li><a href="{url page="about"}">{translate key="plugins.themes.sangulineModern.about.focusScope"}</a></li>
								<li><a href="{url page="about" op="submissions" anchor="copyrightNotice"}">{translate key="plugins.themes.sangulineModern.about.publicationEthics"}</a></li>
								<li><a href="{url page="about" op="submissions"}">{translate key="plugins.themes.sangulineModern.footer.peerReview"}</a></li>
								<li><a href="{url page="about" op="submissions"}">{translate key="plugins.themes.sangulineModern.footer.manuscriptTemplate"}</a></li>
								<li><a href="{url page="submission" op="wizard"}">{translate key="plugins.themes.sangulineModern.footer.submitOnline"}</a></li>
							</ul>
						</div>

						{* Column 3: Navigasi & Arsip *}
						<div class="col-12 col-sm-6 col-lg-3 footer-col">
							<h3 class="footer-col__title">{translate key="plugins.themes.sangulineModern.footer.navArchive"}</h3>
							<ul class="list-unstyled">
								<li><a href="{url page="index"}">{translate key="plugins.themes.sangulineModern.footer.home"}</a></li>
								<li><a href="{url page="issue" op="current"}">{translate key="plugins.themes.sangulineModern.footer.latestIssue"}</a></li>
								<li><a href="{url page="issue" op="archive"}">{translate key="plugins.themes.sangulineModern.footer.issueArchive"}</a></li>
								<li><a href="{url page="about" op="editorialTeam"}">{translate key="plugins.themes.sangulineModern.about.editorialBoard"}</a></li>
								<li><a href="{url page="announcement"}">{translate key="plugins.themes.sangulineModern.announcements.title"}</a></li>
								<li><a href="{url page="about"}">{translate key="plugins.themes.sangulineModern.footer.indexing"}</a></li>
							</ul>
						</div>

						{* Column 4: Kontak & Sekretariat *}
						<div class="col-12 col-lg-3 footer-col">
							<h3 class="footer-col__title">{translate key="plugins.themes.sangulineModern.footer.contactTitle"}</h3>
							<div class="footer-contact">
								<div>
									<span class="footer-contact__label">{translate key="plugins.themes.sangulineModern.footer.editorialEmail"}</span>
									{if $currentContext && $currentContext->getData('contactEmail')}
										<a href="mailto:{$currentContext->getData('contactEmail')|escape}" class="footer-contact__value">{$currentContext->getData('contactEmail')|escape}</a>
									{/if}
								</div>
								<div>
									<span class="footer-contact__label">{translate key="plugins.themes.sangulineModern.footer.officeAddress"}</span>
									<span class="footer-contact__value">
										{if $currentContext && $currentContext->getData('mailingAddress')}
											{$currentContext->getData('mailingAddress')|escape}
										{/if}
									</span>
								</div>
								<div>
									<span class="footer-contact__label">{translate key="plugins.themes.sangulineModern.footer.officeHours"}</span>
									<span class="footer-contact__value">{translate key="plugins.themes.sangulineModern.footer.officeHoursValue"}</span>
								</div>
							</div>
						</div>
					</div>
				</div>

				{if $pageFooter}
					<div class="container-fluid jrdc-container">
						<div class="pkp_footer_content jrdc-footer__content">
							{$pageFooter}
						</div>
					</div>
				{/if}

				<div class="container-fluid jrdc-container">
					{* Bottom bar: Copyright & Legal links *}
					<div class="jrdc-footer-bottom d-flex flex-wrap align-items-center justify-content-between gap-3">
						<div>
							&copy; {$smarty.now|date_format:"%Y"} {translate key="plugins.themes.sangulineModern.footer.copyrightLine"}
						</div>
						<div class="jrdc-footer__legal d-flex flex-wrap align-items-center gap-2">
							<a href="{url page="about" op="submissions" anchor="privacyStatement"}">{translate key="plugins.themes.sangulineModern.footer.privacyPolicy"}</a>
							<span>&bull;</span>
							<a href="{url page="about" op="submissions" anchor="copyrightNotice"}">{translate key="plugins.themes.sangulineModern.footer.copyrightNotice"}</a>
							<span>&bull;</span>
							<a href="{url page="about"}">{translate key="plugins.themes.sangulineModern.footer.openAccessStmt"}</a>
						</div>
					</div>

					{* Sanguline Theme Copyright - Protected *}
					<div class="sanguline_theme_credit jrdc-footer__credit" data-sanguline="protected">
						<span class="theme_credit_text">Sanguline Theme by</span>
						<a href="https://sanguilmu.com/" target="_blank" rel="noopener noreferrer" class="theme_credit_link">Sangu Ilmu</a>
					</div>
				</div>
			</div>
		</footer><!-- pkp_structure_footer_wrapper -->

	</div><!-- pkp_structure_page -->

	{load_script context="frontend"}

	{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
