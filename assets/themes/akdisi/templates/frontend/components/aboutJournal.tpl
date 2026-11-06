{**
 * @file plugins/themes/akdisi/templates/frontend/components/aboutJournal.tpl
 *
 * Ringkasan tentang jurnal (S-HOME-05).
 * Muncul hanya bila journal description tersedia.
 *}
{if $journalDescription}
	<section class="akdisi-about" data-slot="S-HOME-05" aria-labelledby="akdisi-about-heading">
		<div class="akdisi-about__inner">
			<h2 id="akdisi-about-heading">{translate key="about.aboutContext"}</h2>
			<p class="akdisi-about__body">{$journalDescription|strip_tags|truncate:600|escape}</p>
			<a class="akdisi-link" href="{url page="about"}">
				{translate key="common.more"}
			</a>
		</div>
	</section>
{/if}
