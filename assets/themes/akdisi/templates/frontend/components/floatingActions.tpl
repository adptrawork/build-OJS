{**
 * @file plugins/themes/akdisi/templates/frontend/components/floatingActions.tpl
 *
 * Floating quick actions: contact link + back-to-top.
 * Contact URL diambil dari custom setting `akdisiContactUrl`.
 *}
<div class="akdisi-floating-actions" data-slot="S-HOME-15">
	{if $akdisiContactUrl}
		<a class="akdisi-floating-actions__btn akdisi-floating-actions__btn--contact" href="{$akdisiContactUrl|escape}" aria-label="Contact editorial office">
			<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
				<path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
			</svg>
		</a>
	{/if}
	{include file="frontend/components/backToTop.tpl"}
</div>
