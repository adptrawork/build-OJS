{**
 * @file plugins/themes/akdisi/templates/frontend/components/statsStrip.tpl
 *
 * Strip statistik jurnal.
 * Hanya menampilkan angka yang tersedia; field kosong disembunyikan.
 *}
{if $akdisiStats && (
	$akdisiStats->articles|default:0 > 0
	|| $akdisiStats->issues|default:0 > 0
	|| $akdisiStats->avgReviewDays|default:0 > 0
	|| $akdisiStats->acceptanceRate|default:0 > 0
)}
	<section class="akdisi-stats" data-slot="S-HOME-12" aria-label="Journal statistics">
		<div class="akdisi-stats__inner">
			{if $akdisiStats->articles|default:0 > 0}
				<div class="akdisi-stat">
					<strong class="akdisi-stat__value">{$akdisiStats->articles|number_format}</strong>
					<span class="akdisi-stat__label">Articles</span>
				</div>
			{/if}
			{if $akdisiStats->issues|default:0 > 0}
				<div class="akdisi-stat">
					<strong class="akdisi-stat__value">{$akdisiStats->issues|number_format}</strong>
					<span class="akdisi-stat__label">Issues</span>
				</div>
			{/if}
			{if $akdisiStats->avgReviewDays|default:0 > 0}
				<div class="akdisi-stat">
					<strong class="akdisi-stat__value">{$akdisiStats->avgReviewDays|escape}</strong>
					<span class="akdisi-stat__label">Avg. Review Days</span>
				</div>
			{/if}
			{if $akdisiStats->acceptanceRate|default:0 > 0}
				<div class="akdisi-stat">
					<strong class="akdisi-stat__value">{$akdisiStats->acceptanceRate|escape}%</strong>
					<span class="akdisi-stat__label">Acceptance Rate</span>
				</div>
			{/if}
		</div>
	</section>
{/if}
