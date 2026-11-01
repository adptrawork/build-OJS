{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/tabs.tpl
 *}
<section class="container py-4 mb-5">
	<div class="w-100 mb-4">
		<ul class="nav jilp-tabs mb-0 shadow-sm w-100" id="jilpArticleTabs" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="latest-tab" data-bs-toggle="pill" data-bs-target="#latest-content" type="button" role="tab" aria-controls="latest-content" aria-selected="true">
					<i class="bi bi-clock-history me-1"></i> {translate key="plugins.themes.journalEditorial.tabs.latest"}
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="viewed-tab" data-bs-toggle="pill" data-bs-target="#viewed-content" type="button" role="tab" aria-controls="viewed-content" aria-selected="false">
					<i class="bi bi-eye me-1"></i> {translate key="plugins.themes.journalEditorial.tabs.viewed"}
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="cited-tab" data-bs-toggle="pill" data-bs-target="#cited-content" type="button" role="tab" aria-controls="cited-content" aria-selected="false">
					<i class="bi bi-quote me-1"></i> {translate key="plugins.themes.journalEditorial.tabs.cited"}
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="issues-tab" data-bs-toggle="pill" data-bs-target="#issues-content" type="button" role="tab" aria-controls="issues-content" aria-selected="false">
					<i class="bi bi-journals me-1"></i> {translate key="plugins.themes.journalEditorial.tabs.issues"}
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="announcements-tab" data-bs-toggle="pill" data-bs-target="#announcements-content" type="button" role="tab" aria-controls="announcements-content" aria-selected="false">
					<i class="bi bi-megaphone me-1"></i> {translate key="plugins.themes.journalEditorial.tabs.announcements"}
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="about-tab" data-bs-toggle="pill" data-bs-target="#about-content" type="button" role="tab" aria-controls="about-content" aria-selected="false">
					<i class="bi bi-info-circle me-1"></i> {translate key="plugins.themes.journalEditorial.tabs.about"}
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="editorial-tab" data-bs-toggle="pill" data-bs-target="#editorial-content" type="button" role="tab" aria-controls="editorial-content" aria-selected="false">
					<i class="bi bi-people me-1"></i> {translate key="plugins.themes.journalEditorial.tabs.editorial"}
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
					<a class="btn btn-outline-primary rounded-pill px-4 fw-bold" href="{url page="issue" op="archive"}">{translate key="plugins.themes.journalEditorial.tabs.viewAllArticles"} <i class="bi bi-arrow-right ms-1"></i></a>
				</div>
			{else}
				<div class="jilp-empty-state">
					<i class="bi bi-journal-x"></i>
					<p>{translate key="plugins.themes.journalEditorial.tabs.emptyArticles"}</p>
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
				<div class="jilp-empty-state"><i class="bi bi-eye"></i><p>{translate key="plugins.themes.journalEditorial.tabs.emptyViews"}</p></div>
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
				<div class="jilp-empty-state"><i class="bi bi-quote"></i><p>{translate key="plugins.themes.journalEditorial.tabs.emptyCitations"}</p></div>
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
					<a class="btn btn-outline-primary rounded-pill px-4 fw-bold" href="{url page="issue" op="archive"}">{translate key="plugins.themes.journalEditorial.tabs.fullArchive"} <i class="bi bi-arrow-right ms-1"></i></a>
				</div>
			{else}
				<div class="jilp-empty-state"><i class="bi bi-journals"></i><p>{translate key="plugins.themes.journalEditorial.tabs.emptyIssues"}</p></div>
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
									<a class="jilp-announcement-link" href="{url page="announcement" op="view" path=$announcement->id}">{translate key="plugins.themes.journalEditorial.readMore"} <i class="bi bi-arrow-right"></i></a>
								</article>
							</div>
						{/if}
					{/foreach}
				</div>
			{else}
				<div class="jilp-empty-state"><i class="bi bi-megaphone"></i><p>{translate key="plugins.themes.journalEditorial.tabs.emptyAnnouncements"}</p></div>
			{/if}
		</div>

		<div class="tab-pane fade" id="about-content" role="tabpanel" aria-labelledby="about-tab">
			<div class="row g-4">
				<div class="col-lg-7">
					<div class="jilp-about-card h-100">
						{if $jilpAbout}
							<div class="jilp-prose">{$jilpAbout|strip_unsafe_html}</div>
						{else}
							<h3 class="h4 fw-bold mb-3">{translate key="plugins.themes.journalEditorial.about.title"}</h3>
							<p class="text-muted">{translate key="plugins.themes.journalEditorial.about.empty"}</p>
						{/if}
					</div>
				</div>
				<div class="col-lg-5">
					<div class="jilp-about-card h-100 mb-4">
						<h3 class="h4 fw-bold mb-3">{translate key="plugins.themes.journalEditorial.about.focusScope"}</h3>
						{if $jilpFocusScope}
							<div class="jilp-prose">{$jilpFocusScope|strip_unsafe_html}</div>
						{else}
							<p class="text-muted">{translate key="plugins.themes.journalEditorial.about.empty"}</p>
						{/if}
					</div>
					<div class="jilp-about-card h-100">
						<h3 class="h4 fw-bold mb-3">{translate key="plugins.themes.journalEditorial.editorial.title"}</h3>
						{if $jilpEditorialTeam}
							<div class="jilp-prose">{$jilpEditorialTeam|strip_unsafe_html}</div>
						{else}
							<p class="text-muted">{translate key="plugins.themes.journalEditorial.editorial.desc" journalName=$currentJournal->getLocalizedName()|escape}</p>
						{/if}
						<a class="btn btn-outline-primary rounded-pill px-4 fw-bold mt-3" href="{url page="about" op="editorialTeam"}">{translate key="plugins.themes.journalEditorial.editorial.viewTeam"} <i class="bi bi-arrow-right ms-1"></i></a>
					</div>
				</div>
			</div>
		</div>

		<div class="tab-pane fade" id="editorial-content" role="tabpanel" aria-labelledby="editorial-tab">
			<div class="row g-4">
				<div class="col-lg-7">
					<div class="jilp-about-card h-100">
						<h3 class="h4 fw-bold mb-3">{translate key="plugins.themes.journalEditorial.editorial.title"}</h3>
						{if $jilpEditorialTeam}
							<div class="jilp-prose">{$jilpEditorialTeam|strip_unsafe_html}</div>
						{else}
							<p class="text-muted">{translate key="plugins.themes.journalEditorial.editorial.desc" journalName=$currentJournal->getLocalizedName()|escape}</p>
						{/if}
						<a class="btn btn-outline-primary rounded-pill px-4 fw-bold mt-3" href="{url page="about" op="editorialTeam"}">{translate key="plugins.themes.journalEditorial.editorial.viewTeam"} <i class="bi bi-arrow-right ms-1"></i></a>
					</div>
				</div>
				<div class="col-lg-5">
					<div class="jilp-about-card h-100">
						<h3 class="h4 fw-bold mb-3">{translate key="plugins.themes.journalEditorial.indexing.compactTitle"}</h3>
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
