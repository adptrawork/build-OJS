{**
 * @file plugins/themes/akdisi/templates/frontend/components/hero.tpl
 *
 * Hero block untuk beranda AKDISI (S-HOME-02, S-HOME-03, S-HOME-04).
 * Layout asimetris: teks di kiri, sampul issue terkini di kanan.
 *}
<header class="akdisi-hero" data-slot="S-HOME-02">
	<div class="akdisi-hero__content">
		<div class="akdisi-hero__text">
			<h1 class="akdisi-hero__title">{$currentContext->getLocalizedName()|escape}</h1>
			{if $journalDescription}
				<p class="akdisi-hero__tagline akdisi-typewriter" aria-label="{$journalDescription|strip_tags|truncate:280|escape}">
					<span class="akdisi-typewriter__text">{$journalDescription|strip_tags|truncate:280|escape}</span>
				</p>
			{/if}

			<div class="akdisi-hero__badges" data-slot="S-HOME-03">
				<span class="akdisi-badge">Open Access</span>
				<span class="akdisi-badge">Peer-Reviewed</span>
			</div>

			<div class="akdisi-hero__cta">
				<a class="akdisi-btn akdisi-btn--primary" href="{url page="submissions"}">
					{translate key="navigation.submissions"}
				</a>
				{if $issue}
					<a class="akdisi-btn akdisi-btn--ghost" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="current"}">
						{translate key="journal.currentIssue"}
					</a>
				{/if}
			</div>
		</div>

		<div class="akdisi-hero__visual" data-slot="S-HOME-04">
			{if $issue}
				<div class="akdisi-hero__issue">
					{assign var="coverUrl" value=$issue->getLocalizedCoverImageUrl()}
					{if $coverUrl}
						<img
							src="{$coverUrl|escape}"
							alt="{$issue->getLocalizedCoverImageAltText()|default:$issue->getIssueIdentification()|escape}"
							class="akdisi-hero__cover"
							loading="eager"
						>
					{/if}
					<div class="akdisi-hero__issue-meta">
						<span class="akdisi-eyebrow">{translate key="journal.currentIssue"}</span>
						<strong class="akdisi-hero__issue-id">{$issue->getIssueIdentification()|escape}</strong>
					</div>
				</div>
			{else}
				<div class="akdisi-hero__issue akdisi-hero__issue--empty">
					<span class="akdisi-eyebrow">{translate key="journal.currentIssue"}</span>
					<p>{translate key="issue.noIssues"}</p>
				</div>
			{/if}
		</div>
	</div>
</header>
