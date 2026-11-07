{**
 * templates/frontend/components/footer.tpl
 * JRDC Theme — Site footer
 *}
	</main><!-- /.jrdc-main -->

	<footer class="jrdc-footer" role="contentinfo">
		<div class="jrdc-container">
			<div class="jrdc-footer-grid">
				<div>
					<div class="jrdc-footer-brand">
						{if $currentContext}
							{$currentContext->getLocalizedName()|escape}
						{else}
							{$siteTitle|escape}
						{/if}
					</div>
					{if $currentContext && $currentContext->getLocalizedDescription()}
						<p style="margin:0;opacity:0.85;line-height:1.6;max-width:36ch;">
							{$currentContext->getLocalizedDescription()|strip_tags|truncate:180}
						</p>
					{/if}
				</div>

				<div>
					<strong style="color:#fff;display:block;margin-bottom:0.75rem;">{translate key="about.aboutContext"}</strong>
					{load_menu name="footer" id="jrdcFooterNav" ulClass="" liClass=""}
				</div>

				<div>
					<strong style="color:#fff;display:block;margin-bottom:0.75rem;">{translate key="navigation.user"}</strong>
					<ul style="list-style:none;margin:0;padding:0;">
						{if $isUserLoggedIn}
							<li><a href="{url page="submissions"}">{translate key="navigation.dashboard"}</a></li>
							<li><a href="{url page="user" op="profile"}">{translate key="user.profile"}</a></li>
							<li><a href="{url page="login" op="signOut"}">{translate key="user.logout"}</a></li>
						{else}
							<li><a href="{url page="login"}">{translate key="user.login"}</a></li>
							<li><a href="{url page="user" op="register"}">{translate key="user.register"}</a></li>
						{/if}
					</ul>
				</div>
			</div>

			<div class="jrdc-footer-bottom">
				<div>
					{if $currentContext}
						{translate key="common.publishedBy"} {$currentContext->getData('publisherInstitution')|escape}
					{/if}
				</div>
				<div>
					{if $pageFooter}
						{$pageFooter}
					{else}
						&copy; {if $currentContext}{$currentContext->getLocalizedName()|escape}{else}{$siteTitle|escape}{/if}
					{/if}
				</div>
			</div>
		</div>
	</footer>

	{load_script context="frontend"}
</body>
</html>
