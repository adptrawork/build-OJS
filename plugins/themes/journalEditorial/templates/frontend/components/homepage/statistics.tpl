{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/statistics.tpl
 *}
<div class="container jilp-stats-bar-container">
	<div class="jilp-stats-card">
		<div class="jilp-stat-item">
			<div class="jilp-stat-icon shadow-sm"><i class="bi bi-file-earmark-text"></i></div>
			<div>
				<div class="jilp-stat-number">{$jilpStats->articles|default:0}{if $jilpStats->articles}+{/if}</div>
				<div class="jilp-stat-label">Published Articles</div>
			</div>
		</div>
		<div class="jilp-stat-item">
			<div class="jilp-stat-icon shadow-sm"><i class="bi bi-people-fill"></i></div>
			<div>
				<div class="jilp-stat-number">{$jilpStats->authors|default:0}{if $jilpStats->authors}+{/if}</div>
				<div class="jilp-stat-label">Contributing Authors</div>
			</div>
		</div>
		<div class="jilp-stat-item">
			<div class="jilp-stat-icon shadow-sm"><i class="bi bi-award-fill"></i></div>
			<div>
				<div class="jilp-stat-number">{$jilpStats->reviewers|default:0}{if $jilpStats->reviewers}+{/if}</div>
				<div class="jilp-stat-label">Active Reviewers</div>
			</div>
		</div>
		<div class="jilp-stat-item">
			<div class="jilp-stat-icon shadow-sm"><i class="bi bi-journals"></i></div>
			<div>
				<div class="jilp-stat-number">{$jilpStats->issues|default:0}{if $jilpStats->issues}+{/if}</div>
				<div class="jilp-stat-label">Published Issues</div>
			</div>
		</div>
	</div>
</div>
