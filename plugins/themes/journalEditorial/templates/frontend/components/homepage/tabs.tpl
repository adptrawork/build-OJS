{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/tabs.tpl
 *}
<section class="container py-4 mb-5">
	<div class="w-100 mb-4">
		<ul class="nav jilp-tabs mb-0 shadow-sm w-100" id="jilpArticleTabs" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="latest-tab" data-bs-toggle="pill" data-bs-target="#latest-content" type="button" role="tab" aria-controls="latest-content" aria-selected="true">
					<i class="bi bi-clock-history me-1"></i> Latest Articles
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="viewed-tab" data-bs-toggle="pill" data-bs-target="#viewed-content" type="button" role="tab" aria-controls="viewed-content" aria-selected="false">
					<i class="bi bi-eye me-1"></i> Most Viewed
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="cited-tab" data-bs-toggle="pill" data-bs-target="#cited-content" type="button" role="tab" aria-controls="cited-content" aria-selected="false">
					<i class="bi bi-quote me-1"></i> Most Cited
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="issues-tab" data-bs-toggle="pill" data-bs-target="#issues-content" type="button" role="tab" aria-controls="issues-content" aria-selected="false">
					<i class="bi bi-journals me-1"></i> Journal Issues
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="announcements-tab" data-bs-toggle="pill" data-bs-target="#announcements-content" type="button" role="tab" aria-controls="announcements-content" aria-selected="false">
					<i class="bi bi-megaphone me-1"></i> Announcements
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="about-tab" data-bs-toggle="pill" data-bs-target="#about-content" type="button" role="tab" aria-controls="about-content" aria-selected="false">
					<i class="bi bi-info-circle me-1"></i> About Journal
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="editorial-tab" data-bs-toggle="pill" data-bs-target="#editorial-content" type="button" role="tab" aria-controls="editorial-content" aria-selected="false">
					<i class="bi bi-people me-1"></i> Editorial &amp; Indexing
				</button>
			</li>
		</ul>
	</div>

	<div class="tab-content" id="jilpArticleTabsContent">
		<div class="tab-pane fade show active" id="latest-content" role="tabpanel" aria-labelledby="latest-tab">
			{if $jilpArticles && $jilpArticles|@count > 0}
				<div class="row g-4">
					{foreach from=$jilpArticles item=article name=latest}
						{if $smarty.foreach.latest.index < 6}
							<div class="col-lg-4 col-md-6">
								{include file="frontend/components/homepage/articleCard.tpl" article=$article}
							</div>
						{/if}
					{/foreach}
				</div>
				<div class="text-center mt-4">
					<a class="btn btn-outline-primary rounded-pill px-4 fw-bold" href="{url page="issue" op="archive"}">View All Articles <i class="bi bi-arrow-right ms-1"></i></a>
				</div>
			{else}
				<div class="jilp-empty-state">
					<i class="bi bi-journal-x"></i>
					<p>No published articles yet. New research will appear here after publication.</p>
				</div>
			{/if}
		</div>

		<div class="tab-pane fade" id="viewed-content" role="tabpanel" aria-labelledby="viewed-tab">
			{if $jilpArticles && $jilpArticles|@count > 0}
				<div class="row g-4">
					{foreach from=$jilpArticles item=article name=viewed}
						{if $smarty.foreach.viewed.index < 3}
							<div class="col-lg-4 col-md-6">
								{include file="frontend/components/homepage/articleCard.tpl" article=$article}
							</div>
						{/if}
					{/foreach}
				</div>
			{else}
				<div class="jilp-empty-state"><i class="bi bi-eye"></i><p>View statistics will appear once articles receive readers.</p></div>
			{/if}
		</div>

		<div class="tab-pane fade" id="cited-content" role="tabpanel" aria-labelledby="cited-tab">
			{if $jilpArticles && $jilpArticles|@count > 0}
				<div class="row g-4">
					{foreach from=$jilpArticles item=article name=cited}
						{if $smarty.foreach.cited.index < 3}
							<div class="col-lg-4 col-md-6">
								{include file="frontend/components/homepage/articleCard.tpl" article=$article}
							</div>
						{/if}
					{/foreach}
				</div>
			{else}
				<div class="jilp-empty-state"><i class="bi bi-quote"></i><p>Citation metrics will appear as articles are cited.</p></div>
			{/if}
		</div>

		<div class="tab-pane fade" id="issues-content" role="tabpanel" aria-labelledby="issues-tab">
			{if $jilpIssues && $jilpIssues|@count > 0}
				<div class="row g-4">
					{foreach from=$jilpIssues item=issue}
						<div class="col-lg-4 col-md-6">
							{include file="frontend/components/homepage/issueCard.tpl" issue=$issue}
						</div>
					{/foreach}
				</div>
				<div class="text-center mt-4">
					<a class="btn btn-outline-primary rounded-pill px-4 fw-bold" href="{url page="issue" op="archive"}">Full Archive <i class="bi bi-arrow-right ms-1"></i></a>
				</div>
			{else}
				<div class="jilp-empty-state"><i class="bi bi-journals"></i><p>No issues have been published yet.</p></div>
			{/if}
		</div>

		<div class="tab-pane fade" id="announcements-content" role="tabpanel" aria-labelledby="announcements-tab">
			{if $announcements && $announcements->count() > 0}
				<div class="row g-4">
					{foreach from=$announcements item=announcement name=news}
						{if $smarty.foreach.news.index < 3}
							<div class="col-lg-4 col-md-6">
								<article class="jilp-announcement-card h-100">
									<div class="jilp-announcement-icon"><i class="bi bi-megaphone-fill"></i></div>
									<h3 class="jilp-announcement-title">
										<a href="{url page="announcement" op="view" path=$announcement->id}">{$announcement->getLocalizedData('title')|escape}</a>
									</h3>
									{if $announcement->datePosted}
										<p class="jilp-announcement-date"><i class="bi bi-calendar3 me-1"></i> {$announcement->datePosted|date_format:$dateFormatShort}</p>
									{/if}
									<p class="jilp-announcement-desc">{$announcement->getLocalizedData('descriptionShort')|strip_tags|truncate:160|escape}</p>
									<a class="jilp-announcement-link" href="{url page="announcement" op="view" path=$announcement->id}">Read more <i class="bi bi-arrow-right"></i></a>
								</article>
							</div>
						{/if}
					{/foreach}
				</div>
			{else}
				<div class="jilp-empty-state"><i class="bi bi-megaphone"></i><p>No announcements have been posted yet.</p></div>
			{/if}
		</div>

		<div class="tab-pane fade" id="about-content" role="tabpanel" aria-labelledby="about-tab">
			<div class="row g-4">
				<div class="col-lg-7">
					<div class="jilp-about-card h-100">
						<h3 class="h4 fw-bold mb-3">About the Journal</h3>
						{if $currentJournal->getLocalizedDescription()}
							<div class="text-muted">{$currentJournal->getLocalizedDescription()|strip_unsafe_html}</div>
						{else}
							<p class="text-muted">Journal description has not been added yet.</p>
						{/if}
						{if $jilpFocusScope}
							<h4 class="h5 fw-bold mt-4 mb-2">Focus &amp; Scope</h4>
							<div class="text-muted">{$jilpFocusScope|strip_unsafe_html}</div>
						{/if}
					</div>
				</div>
				<div class="col-lg-5">
					<div class="jilp-about-card h-100">
						<h3 class="h4 fw-bold mb-3">Journal Identity</h3>
						<ul class="jilp-identity-list list-unstyled mb-0">
							<li><span>Journal Name</span><strong>{$currentJournal->getLocalizedName()|escape}</strong></li>
							{if $currentJournal->getData('issn')}
								<li><span>p-ISSN</span><strong>{$currentJournal->getData('issn')|escape}</strong></li>
							{/if}
							{if $currentJournal->getData('onlineIssn')}
								<li><span>e-ISSN</span><strong>{$currentJournal->getData('onlineIssn')|escape}</strong></li>
							{/if}
							{if $currentJournal->getData('contactName')}
								<li><span>Contact</span><strong>{$currentJournal->getData('contactName')|escape}</strong></li>
							{/if}
							{if $currentJournal->getData('contactEmail')}
								<li><span>Email</span><strong><a href="mailto:{$currentJournal->getData('contactEmail')|escape}">{$currentJournal->getData('contactEmail')|escape}</a></strong></li>
							{/if}
						</ul>
					</div>
				</div>
			</div>
		</div>

		<div class="tab-pane fade" id="editorial-content" role="tabpanel" aria-labelledby="editorial-tab">
			<div class="row g-4">
				<div class="col-lg-7">
					<div class="jilp-about-card h-100">
						<h3 class="h4 fw-bold mb-3">Editorial Leadership</h3>
						{if $jilpEditorialTeam}
							<div class="text-muted">{$jilpEditorialTeam|strip_unsafe_html}</div>
						{else}
							<p class="text-muted">Meet the editorial team behind {$currentJournal->getLocalizedName()|escape}.</p>
						{/if}
						<a class="btn btn-outline-primary rounded-pill px-4 fw-bold mt-3" href="{url page="about" op="editorialTeam"}">View Editorial Team <i class="bi bi-arrow-right ms-1"></i></a>
					</div>
				</div>
				<div class="col-lg-5">
					<div class="jilp-about-card h-100">
						<h3 class="h4 fw-bold mb-3">Indexed &amp; Abstracted In</h3>
						<div class="jilp-indexing-grid jilp-indexing-grid--compact">
							{foreach from=$jilpIndexers item=indexer}
								<div class="jilp-indexer-badge">{$indexer|escape}</div>
							{/foreach}
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
