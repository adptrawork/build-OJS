{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/statistics.tpl
 *}
<section class="je-stats" aria-label="Journal statistics">
	<div class="je-container">
		<div class="je-stats__grid">
			<div class="je-stat">
				<div class="je-stat__icon">
					<span class="material-symbols-outlined">timer</span>
				</div>
				<div>
					<div class="je-stat__number">{$jeStats->avgReviewDays|default:42}</div>
					<div class="je-stat__label">Avg. Review Time (days)</div>
				</div>
			</div>
			<div class="je-stat">
				<div class="je-stat__icon">
					<span class="material-symbols-outlined">verified</span>
				</div>
				<div>
					<div class="je-stat__number">{$jeStats->acceptanceRate|default:28}%</div>
					<div class="je-stat__label">Acceptance Rate</div>
				</div>
			</div>
			<div class="je-stat">
				<div class="je-stat__icon">
					<span class="material-symbols-outlined">menu_book</span>
				</div>
				<div>
					<div class="je-stat__number">{$jeStats->issues|default:0}</div>
					<div class="je-stat__label">Issues Published</div>
				</div>
			</div>
			<div class="je-stat">
				<div class="je-stat__icon">
					<span class="material-symbols-outlined">article</span>
				</div>
				<div>
					<div class="je-stat__number">{$jeStats->articles|default:0}</div>
					<div class="je-stat__label">Published Articles</div>
				</div>
			</div>
		</div>
	</div>
</section>
