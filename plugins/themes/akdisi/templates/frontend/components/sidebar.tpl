{**
 * @file plugins/themes/akdisi/templates/frontend/components/sidebar.tpl
 *
 * Sidebar beranda (S-HOME-09, S-HOME-10, S-HOME-11).
 * Konten diisi lewat custom block manager atau setting jurnal.
 * Tidak dirender sama sekali bila semua slot kosong.
 *}
{if $akdisiFocusScope || $akdisiEditorialTeam || $akdisiTemplateFile}
	<aside class="akdisi-sidebar" aria-label="Journal information">
		{if $akdisiFocusScope}
			<section class="akdisi-sidebar__block" data-slot="S-HOME-09">
				<h3>Focus &amp; Scope</h3>
				<div class="akdisi-sidebar__body">{$akdisiFocusScope|strip_unsafe_html}</div>
			</section>
		{/if}

		{if $akdisiEditorialTeam}
			<section class="akdisi-sidebar__block" data-slot="S-HOME-10">
				<h3>Editorial Team</h3>
				<div class="akdisi-sidebar__body">{$akdisiEditorialTeam|strip_unsafe_html}</div>
			</section>
		{/if}

		{if $akdisiTemplateFile}
			<section class="akdisi-sidebar__block" data-slot="S-HOME-11">
				<h3>Article Template</h3>
				<a class="akdisi-btn akdisi-btn--small" href="{$akdisiTemplateFile|escape}">
					Download Template
				</a>
			</section>
		{/if}
	</aside>
{/if}
