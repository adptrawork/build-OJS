{**
 * @file plugins/themes/akdisi/templates/frontend/components/currentIssue.tpl
 *
 * Table of contents issue terkini (S-HOME-08).
 * Memakai issue_toc bawaan OJS dengan wrapper styling AKDISI.
 *}
{if $issue}
	<section class="akdisi-current-issue" data-slot="S-HOME-08" aria-labelledby="akdisi-current-issue-heading">
		<div class="akdisi-current-issue__inner">
			<div class="akdisi-current-issue__header">
				<h2 id="akdisi-current-issue-heading">{translate key="journal.currentIssue"}</h2>
				<a class="akdisi-link" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}">
					{translate key="journal.viewAllIssues"}
				</a>
			</div>
			{include file="frontend/objects/issue_toc.tpl" heading="h3"}
		</div>
	</section>
{/if}
