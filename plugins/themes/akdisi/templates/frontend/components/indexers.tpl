{**
 * @file plugins/themes/akdisi/templates/frontend/components/indexers.tpl
 *
 * Strip logo pengindeks (S-HOME-06).
 * Konten diisi lewat custom block "akdisiIndexers" atau setting jurnal.
 * Tidak dirender bila kosong untuk menghindari section kosong.
 *}
{if $akdisiIndexers}
	<section class="akdisi-indexers" data-slot="S-HOME-06" aria-labelledby="akdisi-indexers-heading">
		<div class="akdisi-indexers__inner">
			<h2 id="akdisi-indexers-heading" class="akdisi-indexers__title">Indexing</h2>
			<div class="akdisi-indexers__list">{$akdisiIndexers}</div>
		</div>
	</section>
{/if}
