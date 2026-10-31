{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/journalIdentity.tpl
 *}
<section class="je-section" aria-labelledby="je-identity-title">
	<div class="je-container">
		<h2 id="je-identity-title" class="je-section__title">Journal Identity &amp; Specifications</h2>
		<div class="je-identity">
			<div class="je-identity__item">
				<span class="je-identity__label">Journal Name</span>
				<span>{$currentJournal->getLocalizedName()|escape}</span>
			</div>
			{if $currentJournal->getData('issn')}
			<div class="je-identity__item">
				<span class="je-identity__label">ISSN</span>
				<span>{$currentJournal->getData('issn')|escape}</span>
			</div>
			{/if}
			{if $currentJournal->getData('onlineIssn')}
			<div class="je-identity__item">
				<span class="je-identity__label">e-ISSN</span>
				<span>{$currentJournal->getData('onlineIssn')|escape}</span>
			</div>
			{/if}
			{if $jeFocusScope}
			<div class="je-identity__item">
				<span class="je-identity__label">Focus &amp; Scope</span>
				<span>{$jeFocusScope|strip_unsafe_html}</span>
			</div>
			{/if}
		</div>
	</div>
</section>
