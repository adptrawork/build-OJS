{**
 * @file plugins/themes/journalEditorial/templates/frontend/components/homepage/tabs.tpl
 *
 * Ruled lists instead of stacked cards: elevation carries no meaning here,
 * the article title and metadata do the work.
 *}
<section class="container py-4 mb-5">
	<ul class="nav jilp-tabs mb-0" id="jilpArticleTabs" role="tablist">
		<li class="nav-item" role="presentation">
			<button class="nav-link active" id="latest-tab" data-bs-toggle="pill" data-bs-target="#latest-content" type="button" role="tab" aria-controls="latest-content" aria-selected="true">
				{translate key="plugins.themes.journalEditorial.tabs.latest"}
			</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="viewed-tab" data-bs-toggle="pill" data-bs-target="#viewed-content" type="button" role="tab" aria-controls="viewed-content" aria-selected="false">
				{translate key="plugins.themes.journalEditorial.tabs.viewed"}
			</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="cited-tab" data-bs-toggle="pill" data-bs-target="#cited-content" type="button" role="tab" aria-controls="cited-content" aria-selected="false">
				{translate key="plugins.themes.journalEditorial.tabs.cited"}
			</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="issues-tab" data-bs-toggle="pill" data-bs-target="#issues-content" type="button" role="tab" aria-controls="issues-content" aria-selected="false">
				{translate key="plugins.themes.journalEditorial.tabs.issues"}
			</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="announcements-tab" data-bs-toggle="pill" data-bs-target="#announcements-content" type="button" role="tab" aria-controls="announcements-content" aria-selected="false">
				{translate key="plugins.themes.journalEditorial.tabs.announcements"}
			</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="about-tab" data-bs-toggle="pill" data-bs-target="#about-content" type="button" role="tab" aria-controls="about-content" aria-selected="false">
				{translate key="plugins.themes.journalEditorial.tabs.about"}
			</button>
		</li>
		<li class="nav-item" role="presentation">
			<button class="nav-link" id="editorial-tab" data-bs-toggle="pill" data-bs-target="#editorial-content" type="button" role="tab" aria-controls="editorial-content" aria-selected="false">
				{translate key="plugins.themes.journalEditorial.tabs.editorial"}
			</button>
		</li>
	</ul>

	<div class="tab-content" id="jilpArticleTabsContent">
		<div class="tab-pane fade show active" id="latest-content" role="tabpanel" aria-labelledby="latest-tab">
			{if $jilpArticles && $jilpArticles|@count > 0}
				<ol class="jilp-rule-list">
					{foreach from=$jilpArticles item=article name=latest}
						{if $smarty.foreach.latest.index < 6}
							<li>
								<a href="{url page="article" op="view" path=$article->id}">
									<span class="jilp-row-index">{$smarty.foreach.latest.index + 1}</span>
									<div>
										<div class="jilp-row-title">{$article->title|escape}</div>
										<div class="jilp-row-meta">
											{$article->authors|escape}
											{if $article->issueTitle} &middot; {$article->issueTitle|escape}{/if}
										</div>
									</div>
									<span class="jilp-row-end">
										{if $article->date}{$article->date|date_format:$dateFormatShort}{/if}
										<i class="bi bi-arrow-right" aria-hidden="true"></i>
									</span>
								</a>
							</li>
						{/if}
					{/foreach}
				</ol>
				<div class="mt-4">
					<a class="jilp-link-arrow-cta" href="{url page="issue" op="archive"}">{translate key="plugins.themes.journalEditorial.tabs.viewAllArticles"} <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
				</div>
			{else}
				<div class="jilp-empty-state">
					<i class="bi bi-journal-x" aria-hidden="true"></i>
					<p>{translate key="plugins.themes.journalEditorial.tabs.emptyArticles"}</p>
				</div>
			{/if}
		</div>

		<div class="tab-pane fade" id="viewed-content" role="tabpanel" aria-labelledby="viewed-tab">
			{if $jilpArticles && $jilpArticles|@count > 0}
				<ol class="jilp-rule-list">
					{foreach from=$jilpArticles item=article name=viewed}
						{if $smarty.foreach.viewed.index < 3}
							<li>
								<a href="{url page="article" op="view" path=$article->id}">
									<span class="jilp-row-index">{$smarty.foreach.viewed.index + 1}</span>
									<div>
										<div class="jilp-row-title">{$article->title|escape}</div>
										<div class="jilp-row-meta">{$article->authors|escape}</div>
									</div>
									<span class="jilp-row-end"><i class="bi bi-arrow-right" aria-hidden="true"></i></span>
								</a>
							</li>
						{/if}
					{/foreach}
				</ol>
			{else}
				<div class="jilp-empty-state"><i class="bi bi-eye" aria-hidden="true"></i><p>{translate key="plugins.themes.journalEditorial.tabs.emptyViews"}</p></div>
			{/if}
		</div>

		<div class="tab-pane fade" id="cited-content" role="tabpanel" aria-labelledby="cited-tab">
			{if $jilpArticles && $jilpArticles|@count > 0}
				<ol class="jilp-rule-list">
					{foreach from=$jilpArticles item=article name=cited}
						{if $smarty.foreach.cited.index < 3}
							<li>
								<a href="{url page="article" op="view" path=$article->id}">
									<span class="jilp-row-index">{$smarty.foreach.cited.index + 1}</span>
									<div>
										<div class="jilp-row-title">{$article->title|escape}</div>
										<div class="jilp-row-meta">{$article->authors|escape}</div>
									</div>
									<span class="jilp-row-end"><i class="bi bi-arrow-right" aria-hidden="true"></i></span>
								</a>
							</li>
						{/if}
					{/foreach}
				</ol>
			{else}
				<div class="jilp-empty-state"><i class="bi bi-quote" aria-hidden="true"></i><p>{translate key="plugins.themes.journalEditorial.tabs.emptyCitations"}</p></div>
			{/if}
		</div>

		<div class="tab-pane fade" id="issues-content" role="tabpanel" aria-labelledby="issues-tab">
			{if $jilpIssues && $jilpIssues|@count > 0}
				<ol class="jilp-rule-list">
					{foreach from=$jilpIssues item=issue}
						<li>
							<a href="{url page="issue" op="view" path=$issue->id}">
								<span class="jilp-row-index"><i class="bi bi-journal-bookmark" aria-hidden="true"></i></span>
								<div>
									<div class="jilp-row-title">{$issue->title|escape}</div>
									<div class="jilp-row-meta">
										{$issue->date|date_format:$dateFormatShort}
									</div>
								</div>
								<span class="jilp-row-end">
									{translate key="plugins.themes.journalEditorial.issue.view"} <i class="bi bi-arrow-right" aria-hidden="true"></i>
								</span>
							</a>
						</li>
					{/foreach}
				</ol>
				<div class="mt-4">
					<a class="jilp-link-arrow-cta" href="{url page="issue" op="archive"}">{translate key="plugins.themes.journalEditorial.tabs.fullArchive"} <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
				</div>
			{else}
				<div class="jilp-empty-state"><i class="bi bi-journals" aria-hidden="true"></i><p>{translate key="plugins.themes.journalEditorial.tabs.emptyIssues"}</p></div>
			{/if}
		</div>

		<div class="tab-pane fade" id="announcements-content" role="tabpanel" aria-labelledby="announcements-tab">
			{if $announcements && $announcements->count() > 0}
				<ul class="jilp-rule-list">
					{foreach from=$announcements item=announcement name=news}
						{if $smarty.foreach.news.index < 3}
							<li>
								<a href="{url page="announcement" op="view" path=$announcement->id}">
									<span class="jilp-row-index">{$announcement->datePosted|date_format:"d/m"}</span>
									<div>
										<div class="jilp-row-title">{$announcement->getLocalizedData('title')|escape}</div>
										<div class="jilp-row-meta">{$announcement->getLocalizedData('descriptionShort')|strip_tags|truncate:140|escape}</div>
									</div>
									<span class="jilp-row-end"><i class="bi bi-arrow-right" aria-hidden="true"></i></span>
								</a>
							</li>
						{/if}
					{/foreach}
				</ul>
			{else}
				<div class="jilp-empty-state"><i class="bi bi-megaphone" aria-hidden="true"></i><p>{translate key="plugins.themes.journalEditorial.tabs.emptyAnnouncements"}</p></div>
			{/if}
		</div>

		<div class="tab-pane fade" id="about-content" role="tabpanel" aria-labelledby="about-tab">
			<div class="jilp-split">
				<div class="jilp-split-main">
					{if $jilpAbout}
						<div class="jilp-prose">{$jilpAbout|strip_unsafe_html}</div>
					{else}
						<h3 class="h4 fw-bold mb-3">{translate key="plugins.themes.journalEditorial.about.title"}</h3>
						<p class="text-muted">{translate key="plugins.themes.journalEditorial.about.empty"}</p>
					{/if}
				</div>
				<aside class="jilp-split-rail">
					<div class="jilp-rail-block">
						<h3 class="jilp-rail-title">{translate key="plugins.themes.journalEditorial.about.focusScope"}</h3>
						{if $jilpFocusScope}
							<div class="jilp-prose">{$jilpFocusScope|strip_unsafe_html}</div>
						{else}
							<p class="text-muted mb-0">{translate key="plugins.themes.journalEditorial.about.empty"}</p>
						{/if}
					</div>
					<div class="jilp-rail-block">
						<h3 class="jilp-rail-title">{translate key="plugins.themes.journalEditorial.editorial.title"}</h3>
						{if $jilpEditorialTeam}
							<div class="jilp-prose">{$jilpEditorialTeam|strip_unsafe_html}</div>
						{else}
							<p class="text-muted">{translate key="plugins.themes.journalEditorial.editorial.desc" journalName=$currentJournal->getLocalizedName()|escape}</p>
						{/if}
						<a class="jilp-link-arrow-cta" href="{url page="about" op="editorialMasthead"}">{translate key="plugins.themes.journalEditorial.editorial.viewTeam"} <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
					</div>
				</aside>
			</div>
		</div>

		<div class="tab-pane fade" id="editorial-content" role="tabpanel" aria-labelledby="editorial-tab">
			<div class="jilp-split">
				<div class="jilp-split-main">
					<h3 class="jilp-rail-title">{translate key="plugins.themes.journalEditorial.editorial.title"}</h3>
					{if $jilpEditorialTeam}
						<div class="jilp-prose">{$jilpEditorialTeam|strip_unsafe_html}</div>
					{else}
						<p class="text-muted">{translate key="plugins.themes.journalEditorial.editorial.desc" journalName=$currentJournal->getLocalizedName()|escape}</p>
					{/if}
					<a class="jilp-link-arrow-cta" href="{url page="about" op="editorialMasthead"}">{translate key="plugins.themes.journalEditorial.editorial.viewTeam"} <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
				</div>
				<aside class="jilp-split-rail">
					<div class="jilp-rail-block">
						<h3 class="jilp-rail-title">{translate key="plugins.themes.journalEditorial.indexing.compactTitle"}</h3>
						<ul class="jilp-indexer-list">
							{foreach from=$jilpIndexers item=indexer}
								<li>{$indexer|escape}</li>
							{/foreach}
						</ul>
					</div>
				</aside>
			</div>
		</div>
	</div>
</section>
