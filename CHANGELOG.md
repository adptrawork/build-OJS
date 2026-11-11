# Changelog - JRDC OJS 3.3 Modernization (SangulineModern Theme)

All notable changes to this project will be documented in this file.

## [1.6.15] - 2026-11-12

### Changed
- **"Artikel Serupa" moved from main column into the sidebar:** the recommendBySimilarity plugin renders through the `Templates::Article::Footer::PageFooter` hook, which the core page template emits once after the article object (full-width below the grid). Theme override `templates/frontend/pages/article.tpl` drops the hook there, and the object template re-emits it inside `.jrdc-article__sidebar` (top of the entry_details column), so the block renders as the last sidebar card. No plugin edits; recommended articles now sit in the sidebar as in the prototype.
- `#articlesBySimilarityList` restyled as a sidebar card (`.75rem` uppercase eyebrow heading "Artikel Serupa", divided list items, surface bg + radius + shadow, states inherited from the sidebar stack).

## [1.6.14] - 2026-11-12

### Changed
- **Sidebar download card → LoA card:** the main download button no longer duplicates the body's PDF section. When supplementary galleys exist (every article ships an LoA galley), the sidebar card renders as "SURAT PENERIMAAN (LOA)" / "LETTER OF ACCEPTANCE (LOA)" with one full-width dark button — "Unduh Dokumen LoA (PDF)" / "Download LoA Document (PDF)" — pointing at the supplementary galley. The body's PDF viewer card remains the place to download the article PDF. Articles without a supplementary galley fall back to the previous card (UNDUH PDF + primary galley button).
- New locale keys: `article.loaTitle` (id/en). `.jrdc-article__loa-body` grid for stacked buttons.

## [1.6.13] - 2026-11-12

### Changed
- **PDF viewer chrome removed entirely:** the pdfJsViewer galley page (`/article/view/N/G`) no longer renders a `.header_view` bar — the PDF fills the page (the surrounding article page already provides return/download/chrome, and the header duplicated itself inside the embedded iframe on the article page). `viewPdf.less` trimmed to the full-height iframe layout + outdated-version notice. Plugin JS iframe bootstrap kept verbatim.

## [1.6.12] - 2026-11-12

### Changed
- **PDF viewer chrome → icon-only compact bar:** pdfJsViewer `display.tpl` overridden in the child theme (via the `TemplateResource::getFilename` hook, same mechanism as staticPages). Header now renders as a 56px bar with BS5 icons only: `bi-arrow-left` (return to article/issue, left) + truncated article title (link) + `bi-download` (right). Screen-reader spans + `aria-label` kept for accessibility; plugin's jQuery iframe bootstrap kept verbatim (the embedded viewer depends on it). Note: the parent theme's `viewPdf.less` never loaded in this child (parent visual layer dropped), so `.header_view` was previously completely unstyled (raw text links). New `styles/pages/viewPdf.less` styles the bar/iframe layout.

## [1.6.11] - 2026-11-12

### Fixed
- **Appearance Setup sidebar warnings — "The {sinta,template,in-collaboration-with,informationblockplugin} block can not be found":** the journal `sidebar` setting (journal_settings, journal 1) referenced block plugins that are not registered. No plugin code installed or fabricated; stale references purged per the 1.4.0 project rule (placeholder blocks).

### Changed (DB changes, not in git)
- `journal_settings.sidebar` (journal 1): `sinta`, `template`, `in-collaboration-with` removed; remaining order preserved (`journal-information` … `makesubmissionblockplugin`, 13 entries).
- `plugin_settings` ctx 1: orphaned placeholder CustomBlockPlugin rows deleted — `sinta` (blockTitle/blockContent/enabled), `template` (blockTitle/blockContent/enabled/showName; blockContent carried an unresolved `[URL_FILE_TEMPLATE_DOCX]` placeholder), `in-collaboration-with` (blockTitle/blockContent/enabled/showName; "[Nama Mitra 1]" partner placeholders). None were registered by the CustomBlockManager `blocks` list, so they produced the warnings.
- `informationblockplugin` (core PKP block, `plugins/blocks/information/InformationBlockPlugin.inc.php`) was legitimate but disabled (`enabled=0`, ctx 1) → enabled=1. It now renders on the frontend sidebar with the journal's real reader/author/librarian information (journal_settings, id_ID/en_US). Theme/template files untouched.

### Verified
- Same resolution path as the Appearance Setup form + `PKPContextService` validator (`PluginRegistry::loadCategory('generic', true, 1)` then `loadCategory('blocks', true, 1)`): all 13 sidebar entries register, 0 unresolved (was 4). Frontend HTTP 200; Information block renders real content; no placeholder text. OJS caches cleared.
- Rollback: `ddev snapshot restore before-appearance-fix` (snapshot taken before any DB change).

## [1.6.8] - 2026-11-11

### Changed
- **Info grid → auto-fit:** `.jrdc-article__info` now uses `repeat(auto-fit, minmax(150px, 1fr))` (per post-DevTools audit) instead of hardcoded 4-col + mobile 2-col media query — columns reflow automatically at any width without `!important`.

### Rejected from the same DevTools export (with reasons)
- "Title/authors margin-bottom 0 → text stacked": stale — the detail card body is `display:grid; gap:20px`; all blocks measure 20px apart (verified live: badges 168-191 / title 211-338 / authors 358-424 / info 444-536).
- "PDF iframe fails due to X-Frame-Options": wrong cause — was missing jQuery in the child theme (see 1.6.7), verified fixed.
- "LoA card with VERIFIED badge + `LOA/2026/JRDC/{id}` verification number": rejected — fabricates an official "verified" administrative document status and invents verification numbers. LoA stays an honest sample with real journal/issue data and no verification claims.
- "badge/info contrast fixes": dark button is #0f172a on white (~15:1, exceeds WCAG AA); badge uses success-tinted token — both already pass.

## [1.6.7] - 2026-11-11

### Fixed
- **PDF tidak render di iframe (root cause):** parent Sanguline's `init()` never runs for the child theme, so every parent script silently disappeared — including jQuery. The pdfJsViewer galley page fills the viewer iframe's `src` inside `$(document).ready(...)`; with jQuery missing the inline script threw `ReferenceError: $ is not defined` and the iframe stayed empty — the embedded PDF never rendered. Fixed by registering `jQuery` (vendored `lib/pkp/lib/vendor/components/jquery/jquery.min.js`) in the child init, as the parent originally intended. Verified: `#pdfCanvasContainer iframe` now points to `pdfJsViewer/pdf.js/web/viewer.html?file=...article/download/6/1/1` and loads the PDF. (Not an X-Frame-Options/mixed-content issue as speculated in the DevTools export.)
- **PDF card header — too much text:** replaced verbose "Unduh Naskah Lengkap / Download Full Manuscript" + solid dark button with a BS5-icon-first layout: `bi-file-earmark-pdf` (danger) + short title (`Naskah Lengkap` / `Full Manuscript`, new locale keys id/en) + "PDF · Hal. 1-12" subline + outline pill CTA with `bi-download`. ~40% less text, same tokens/radius system.

## [1.6.10] - 2026-11-12

### Fixed
- **Unclosed `{if}` regression (article page 500):** removing the fake-cover else-branch dropped the closing `{/if}` and left the template broken (Smarty compile error, article page returned 500). `{/if}` restored; article page HTTP 200 with badges/authors/info grid/abstract fully rendered.

### Changed
- **Fake placeholder fully removed from article Edisi card:** removing the else also removed the last fabricated data ("JRDC · Vol. 1 No. 1 · 2026"). No cover → card shows only real data (EDISI TERBITAN eyebrow + issue identification + journal name + link). Dead CSS rules removed (.jrdc-article__issue-cover/-title/-vol/-year).
- **Issue 3 "Edisi Khusus Ekonomi Digital" published** (was unpublished, 0 articles; year fixed 1 → 2026, `date_published = NOW()`). Archive now lists it with its uploaded cover. (DB data change, not in git.)

## [1.6.9] - 2026-11-12

### Fixed
- **Issue cover rendered as hardcoded text:** the article-page Edisi card always showed a CSS placeholder ("JRDC / Vol. 1 No. 1 / 2026") even for journals with an uploaded issue cover. Now uses `$issue->getLocalizedCoverImage()` when set (matches issue_summary.tpl archive behavior) — `<img>` linked to the issue, alt from the issue cover alt text, `loading="lazy"`. CSS placeholder only as fallback when no cover is uploaded. (Issue 2, currently the only published issue, has no cover uploaded — this is not a regression.)

## [1.6.6] - 2026-11-11

### Removed
- **Dummy DOIs:** the 5 placeholder `pub-id::doi` values (`10.1000/jrdc.2026.v1n1.*`, created for UI demo) are deleted — no real DOI exists anywhere in the journal (verified: publication_settings, tombstone settings, DOI plugin prefix unconfigured). The article page shows "—" until a real DOI is registered via Admin → Settings → DOI (template and plugin are DOI-ready).

### Changed
- **LoA PDFs rebuilt with real data** (`ojsData/journals/1/articles/loa-*.pdf`, gitignored): e-ISSN/p-ISSN 2049-3630, Volume 1 No. 1 (2026), publisher Yayasan Ratu Dirgantara Cendekiawan, real article title/author/pages/datePublished. Fake verification numbers and invented ISSN removed. Honest sample-document marker kept (no official LoA exists in the system).
- SEO via headerHead.tpl override (no core edits, no new plugins):
  - `<meta name="description">` everywhere (article → abstract stripped ≤158 chars; else journal description; else journal name)
  - `<link rel="canonical">` self-referencing per page (article/issue paths resolved; galley views canonicalize to the article; `/index` segment dropped for op=index routes)
  - Open Graph + Twitter Card (og:type=article on articles, og:image = homepageImage_en_US.png, summary_large_image)
  - JSON-LD structured data: `ScholarlyArticle` on article pages (headline, authors, dates, pages, keywords as array, isPartOf Periodical{ISSN 2049-3630}, publisher org) + `WebSite` + `Organization` on every page
  - JSON-LD braces escaped with Smarty `{ldelim}`/`{rdelim}` (literal `{` breaks the Smarty compiler otherwise)
- Verified: all 9 page types render description/canonical/OG/JSON-LD (article canonical clean, subpage canonicals drop bogus `/index` suffix).
- Gallery/pdfJsViewer pages intentionally carry no theme header (plugin-owned template) — out of scope; note as possible future override for noindex if desired.

## [1.6.5] - 2026-11-11

### Fixed
- **EN mode parity (language toggle):** clicking "English" switched `<html lang>` but the UI stayed Indonesian. Root causes fixed:
  - All hardcoded Indonesian strings in theme templates (homepage hero/cards/issue/announcement labels, article page badges/info grid/download/share/license/references, footer columns/contact, header search placeholder) moved to theme locale keys (`plugins.themes.sangulineModern.*`, 67 keys in `locale/id/locale.po` + `locale/en/locale.po`).
  - **DB titles translated to English in en_US** (not in git): navigation menu items (Register/Login/Current Issue/Archives/Announcements/About/About the Journal/Author Guidelines/Editorial Board/Privacy Statement/Contact/Editorial Team/Reviewer Board/Focus and Scope/Publication Ethics/Publication Fees/Plagiarism Policy/Copyright and License/Retraction and Withdrawal/Open Access Statement); section titles (Research Article/Literature Review/Case Study + id_ID row restored for section 1); sidebar custom blocks `journal-information`, `information-for-author`, `ai-usage-policy` (merged localized JSON — written via PDO prepared statements after discovering MySQL consumes `\"` inside single-quoted strings, corrupting hand-escaped JSON).
- Verified: EN mode renders fully English chrome (nav, hero, cards, article page, footer, sidebar blocks, breadcrumbs); ID mode unchanged (Indonesian chrome + content).

### Notes
- Article/announcement/section *content* (titles, abstracts, announcements) remains Indonesian — that is editorial content, not chrome. Section titles live in `section_settings` (id_ID/en_US rows both present).
- `recommendBySimilarity` locale strings come from the plugin's own locale files — both locales ship in core.

## [1.6.4] - 2026-11-11

### Changed
- **Icons → Bootstrap Icons (CDN):** the child theme dropped the parent's visual layer but never re-registered Font Awesome, so every `fa fa-*` icon rendered as `width:0` (invisible) across the theme. Now uses `bootstrap-icons@1.13.1` from jsdelivr (registered in child init `addStyle('bootstrapIcons')`, user-requested) — no icon fonts vendored, no FA anywhere:
  - `share` buttons render real brand glyphs: `bi-whatsapp`, `bi-twitter-x`, `bi-facebook`, `bi-linkedin` (+ `bi-link-45deg` for Salin Tautan), icon stacked over 10px label per prototype.
  - All theme templates swapped `fa fa-*` → `bi bi-*` (article_details download/PDF/issue/share/copy, announcements list arrow); inline copy SVG replaced with `bi-copy`.
  - Core `submissions.tpl` checklist bullet (`fa fa-check`) — new theme override `templates/frontend/pages/submissions.tpl` with `bi bi-check-circle-fill`.
  - `static.less` checklist `.fa` → `.bi`; share button LESS rewritten for stacked icon+label.
- Note: `bi-twitter-x` used for the X network (link is still `twitter.com/intent/tweet`). Core/parent templates still reference `fa fa-*` but are not rendered in this theme (child overrides or dropped visual layer).

## [1.6.3] - 2026-11-11

### Added
- **Article Details Page — Prototype Rebuild (article.html):** main column now carries one "Detail Artikel" card (section + Akses Terbuka + Hal badges, H1, authors with superscript affiliation refs + affiliation footnotes + ORCID rows, DOI/DITERIMA/TERBIT/HALAMAN info grid with DOI copy button, abstract, keyword chips) + an embedded PDF viewer card (pdfJsViewer iframe, 700px) + a References card with an expand toggle (Bootstrap collapse, >5 refs split into `#extraReferences`) + biographies; sidebar carries the Edisi card (CSS cover, "Lihat Semua Artikel Edisi Ini"), the Unduh box (Halaman row, dark download button + supplementary galleys incl. LoA), the usageStats chart, a Bagikan Artikel card (WA/X/FB/LinkedIn + Salin Tautan) and the Lisensi & Hak Cipta card (CC badge + journal licenseTerms).
- "Artikel Serupa" (recommendBySimilarity) renders below the grid; styled in `article.less` — its output is unchanged (hook fixed at page footer).
- **DB data filled (not in git):** controlled-vocab keywords for pubs 6–10 (id_ID+en_US, incl. a shared "manajemen" keyword so similarity has a hit); `citationsRaw` for pubs 6–10 (single-locale rows — schema type is string, NOT localized); author biographies; journal `licenseTerms` (id_ID+en_US); `accessStatus=1` per publication (journal is open access; badge renders); DOI display-ready settings (`pub-id::doi`); `doipubidplugin` enabled; search index rebuilt via `tools/rebuildSearchIndex.php` (5 articles) — search page works again.
- **LoA sample documents:** one-page PDF per article (`ojsData/journals/1/articles/*/loa-*.pdf`, gitignored) registered as *supplementary* galleys (genre OTHER, label "LoA") — the page now renders "Unduh Dokumen LoA (PDF)".

### Fixed
- Article grid columns: `main_entry`/`entry_details` legacy float-grid classes dropped from the markup — the parent's `float:left; width:calc(100%-305px)` overrode Bootstrap `col-lg-8/4`, stacking the columns full-width (1256px each). Bootstrap columns render untouched (837/419px at 1440).
- Share URLs and "Salin Tautan Artikel": `{url}` is already absolute in OJS — `$baseUrl|cat:` double-prepended the host; article URL is now taken directly.

### Notes
- **DOI prefix `10.1000` is the Crossref example prefix — placeholders.** Replace with real journal DOIs and deposit via the DOI plugin (Settings → DOI) before any production use.
- **LoA PDFs are SAMPLE documents** (marked "Dokumen contoh") for UI completeness — replace with real Letters of Acceptance per article.
- Schema caveat learned: `publication_settings` rows with `locale` on a non-localized schema property (e.g. citationsRaw) make `getData()` return an array — broke explode() with a 500. Keep non-localized props at `locale=''`.
- DevTools audit items superseded by the rebuild: title is now `clamp(1.5rem, 3vw, 2.25rem)`; button radii unified on tokens (8px); icon/action spacing via flex gaps. Eyebrow labels kept at 10px/700/uppercase (prototype), not the audit's 12px.

## [1.6.2] - 2026-11-11

### Fixed
- **Breadcrumb/Title Parity Across All Content Pages:** three page types rendered three different chromes — core about pages (breadcrumb inside `.page` card + `h1`), static pages plugin (no breadcrumb at all + `h2`), custom nav menu pages (breadcrumb outside the card + `h1`). Now every page renders `Beranda / {Title}` inside the card + `h1.page_title`, matching about.tpl:
  - New theme override `templates/plugins/generic/staticPages/templates/content.tpl` (via the `TemplateResource::getFilename` hook mechanism) adds breadcrumb + H1 to the 8 static pages.
  - New theme override `templates/frontend/pages/navigationMenuItemViewContent.tpl` moves the breadcrumb inside the card for custom nav menu pages (Dewan Mitra Bestari).
  - Static page titles translated to Indonesian in DB (`static_page_settings.title`) to match menu labels: Hak Cipta dan Lisensi, Fokus dan Ruang Lingkup, Etika Publikasi, Biaya Publikasi, Retraksi dan Penarikan, Pernyataan Akses Terbuka, Kebijakan Plagiarisme, Panduan Penulis (author-guidelines, kept distinct from the Pedoman Penulis menu item).
  - Locale renames in `locale/id_ID/locale.po` so page titles match menu labels: `about.aboutContext` "Tentang Jurnal Ini" → "Tentang Jurnal", `about.submissions` "Penyerahan Naskah" → "Pedoman Penulis" (keys only used by page titles + core fallback nav, which this journal doesn't render).
- Existing `.page .cmp_breadcrumbs + h1` rule in static.less finally has a matching template (was dead CSS for plugin pages).

### Notes
- Menu "Dewan Redaksi" (Tentang dropdown) and "Dewan Editor" (Redaksi dropdown) both point to `/about/editorialTeam`, titled "Dewan Editor" — relabel or remove the duplicate in Navigation Menus if desired.

## [1.6.1] - 2026-11-11

### Fixed
- **Dead Links to Laragon Domain (DB data, not git):** menu items, journal settings, and announcement content still pointed at `http://ojs-3.3.0-24.test`, so static pages looked "missing" (they existed all along — 8 paths in `static_pages` with full en_US content, all HTTP 200). Snapshot `before-domain-fix` taken for rollback. Fixes applied via `REPLACE()` in the ddev `db` database:
  - `navigation_menu_item_settings.remoteUrl` (7 rows) → **relative** paths (`/index.php/jrdc/{path}`) — `PKPNavigationMenuService` renders remoteUrl raw into `href`, so relative survives domain moves.
  - `journal_settings` (5 rows: emailSignature, authorInformation×2, readerInformation×2) → **absolute** `https://ojs-boostrap.ddev.site:8443` (email signature needs absolute).
  - `announcement_settings` (2 rows: announcement 1 description + descriptionShort) → **absolute** (announcement content feeds the Web Feed RSS/Atom plugin).
- Sweep of all `db.*settings` tables confirms 0 remaining occurrences of the old domain; homepage, static pages, and announcement detail all verified clean and rendering (200).

### Notes
- Search returns 0 results for any query because the search index is empty after the DB restore — rebuild it from the admin (Settings → search rebuild), unrelated to styling.
- DB data changes are not covered by git; this changelog entry is the record. Re-apply the same `REPLACE()` if the DB is restored from an older dump.

## [1.6.0] - 2026-11-11

### Added
- **Issue Page Card:** child `issue.tpl` override wraps the issue TOC in the same `section.card.jrdc-card-section.jrdc-issue` markup as the homepage card (header with h1 `.jrdc-card-title` + `.jrdc-issue__toc`), so `/issue/view/N` renders identical to the homepage "Terbitan Jurnal Terbaru" card. Shared card skin in `home.less` unscoped from `.page_index_journal` to cover both pages.
- **Bootstrap 5.3.3 TOC Sections:** `.jrdc-toc-section` with hairline header and article-count chip.
- **Article Card Rewrite:** ids row (DOI/pages), lucide SVG stats, Abstrak chip, PDF chip.
- **Archive Card Rewrite:** 3:4 cover, Diterbitkan, Artikel Ilmiah, ISSN-conditional footer, Lihat Edisi button.

### Changed
- **Issue Card (homepage):** 3px → 1px translucent border + `--bs-box-shadow-sm`; footer padding aligned to header (`1rem 1.5rem`, tertiary bg, border-top); eyebrow demoted to 11px/700 uppercase secondary label; "Aktif" badge as green subtle pill; issue title colored `var(--bs-primary)` (= theme accent). DevTools-audit findings.
- **TOC Sections Unboxed:** removed the `div.section.jrdc-toc-section` wrapper from `issue_toc.tpl` (header + article list are now flat children of `.sections.jrdc-toc-sections`) and deleted its box rule in `issue.less` (padding/bg/border/shadow). The wrapper double-boxed the content since `issue_toc.tpl` is only ever included inside a card (homepage issue card + issue page card) — the prototype has no section box inside a card (homepage proto: flat list; issue proto: section cards only at top level). Section separation now rides on the header's `margin-block: 2rem 1.5rem` with a `:first-child` reset, safe for multi-section journals. Affects both homepage and `/issue/view/N` identically.
- **Article Cards (TOC/homepage):** title 1rem → 1.125rem/1.4; authors .75rem → .875rem (stale `.obj_article_summary .authors` rule deleted — it beat the card rule on specificity and stacked a stray .5rem margin over the grid gap); hover now lifts with `--jrdc-shadow-hover` (transition extended to box-shadow).
- **Accent Default:** `#0b2038` → `#c2410c` (burnt orange).
- **Primary Locale:** `journal` → `id_ID`.
- **Galley Chip:** uses stored label (PDF) with full label in `title` attr.
- **Tokens:** soft/border/hover derived via `color-mix` from primary (dark mode auto-derives).

### Fixed
- **Sidebar Grid (P0):** extra `</div>` in `indexJournal.tpl` (after `.jrdc-issue__footer`) closed `.jrdc-main` early, shifting footer.tpl's closes up one level and pushing the `aside` out of `.row` — sidebar stacked full-width below the main column. Removing the stray close restores `aside` as a direct child of `.row` (verified: main col 837px = 66%, aside top-aligned beside it). The stray close was previously masked by an unclosed div in the old TOC heading row removed in 1.6.0.
- **Issue/Search Page Footer Misalignment (P0):** the `.page ul, .page ol` prose reset in `static.less` (loaded last, specificity 0,1,1) stomped theme component rules on every `.page`-wrapped page (issue, search, article) — the homepage wrapper `page_index_journal` has no `page` class, which is why only the homepage looked right. Symptoms: PDF chip sat 8.5px above the Abstrak chip (ul got a 16px bottom margin), TOC lists gained a stray 16px bottom margin, breadcrumb `ol` got 16px margin + 24px indent, and `.page li + li` staggered flex/grid items (breadcrumbs, pagination, TOC cards) by 5.6px. Root fix: reset selectors rewritten with `:where()` (zero specificity) so component rules always win, plus a `.cmp_breadcrumbs/.cmp_pagination/.obj_article_summary/.obj_issue_toc li { margin: 0 }` chrome exclusion; galleys ul gets chip-matching font metrics (12px/1.5) so the row is exactly 30px. Verified pixel-equal chip tops (585.91 = 585.91) and identical footer metrics on homepage and issue page.
- **Locale Loading:** id_ID now renders "Dilihat"/"Diunduh" (getLocaleFilename candidate fallback + registration order).
- **Duplicate Search/User Menu:** removed from desktop first row.
- **TOC Cards:** removed badges/Detail Naskah/DOI-copy per prototype.

### Removed
- Badges, Detail Naskah button, DOI-copy button, Font Awesome icons from TOC cards.
- Dead LESS rules.

## [1.5.1] - 2026-11-11

### Fixed
- **ddev Site 500 / Redirect Loop (P0):** `config.inc.php` still carried Laragon/Windows values (`host=localhost`, `files_dir=D:/...`, `base_url=http://ojs-3.3.0-24.test`). Rewired for ddev: `host=db`, `username=db`, `password=db`, `name=db`, `files_dir=/var/www/html/ojsData`, `base_url=https://ojs-boostrap.ddev.site:8443`, `allowed_hosts=["ojs-boostrap.ddev.site"]`.
- **Database Restored:** ddev MariaDB volume was empty (DB version switch 10.6 → 11.8 had wiped it). Dumped the real `ojs-3.3.0-24` schema (114 tables) from the Laragon MySQL 8.0.30 datadir on `/mnt/DiskD/laragon/data/mysql-8` via a throwaway `mysql:8.0.30` container and imported into ddev's `db` database (CREATE DATABASE line re-collated `utf8mb4_0900_ai_ci` → `utf8mb4_general_ci` for MariaDB). Snapshot kept: `ddev snapshot restore ojs-restored-from-laragon`.
- **PHP 8.4 Deprecation Wall:** All "Implicitly marking parameter as nullable" notices came from running OJS 3.3 (patched upstream only through PHP 8.1/8.2) on PHP 8.4. `php_version` reverted to `8.2` in `.ddev/config.yaml` (the value the previously working jrdc-ojs project used).
- **PATH_INFO Redirect Loop:** ddev's default `location ~ \.php$` doesn't match `/index.php/jrdc`, so OJS lost PATH_INFO and looped `→ /index.php/jrdc`. Restored the deleted `.ddev/nginx/ojs.conf` from git history (prefix `location /index.php` with `fastcgi_split_path_info` + `PATH_INFO`, plus sitemap rewrite). Note: `.ddev/nginx_full/nginx-site.conf` cannot be hand-edited — ddev regenerates it on every start; use `.ddev/nginx/*.conf` instead.

### Verified
- Homepage and article/archive/search/login/about/about-submissions routes all HTTP 200; zero deprecation output; JRDC journal + SangulineModern theme render from restored data.

## [1.5.0] - 2026-11-10

### Added
- **Full Bootstrap 5.3.3 Rebuild:**
  - Vendored local Bootstrap 5.3.3 CSS and JS bundle in child theme.
  - Responsive Bootstrap `navbar` with `offcanvas` menu for mobile views.
  - Dedicated `navigationMenuBootstrap.tpl` rendering nested Bootstrap dropdowns.
  - Rebuilt Homepage (`indexJournal.tpl`) with Bootstrap cards, badges, and responsive action groups.
  - Rebuilt Article Details & Summary (`article_details.tpl`, `article_summary.tpl`) with 2-column Bootstrap grid (`col-lg-8` / `col-lg-4`), metadata cards, and list groups.
  - Rebuilt Issue Table of Contents (`issue_toc.tpl`) with Bootstrap cards, badges, and galley CTA buttons.
  - Rebuilt Issue Archive (`issueArchive.tpl`, `issue_summary.tpl`) with responsive multi-column grid (`row-cols-1 row-cols-md-2 row-cols-lg-3`).
  - Styled Search, Static Pages, Submissions, and Auth/Login pages to harmonize with Bootstrap styling.
  - Enhanced Custom Block Manager sidebar widgets, UsageStats graphs, and PDF/HTML galley viewers in `plugins.less`.

### Fixed
- Fixed skip-to-content target anchor (`#siteNav`) in header offcanvas.
- Synchronized `aria-expanded` on mobile hamburger toggle with Bootstrap offcanvas events.
- Added full viewport dimensions and styling for HTML article galley iframes.
- Fixed LESS variable evaluation for `calc()` expressions across sub-pages.
- Removed dead `modern.less` legacy stylesheet.
- Preserved full OJS 3.3 Smarty hooks, localized URLs, and Custom Block Manager architecture.

## [1.4.1] - 2026-11-10

### Changed
- **Header Search Position:** Search box moved from the center to the right-hand action group, matching the prototype (brand → nav → search → user → dark toggle).
- **Issue Intro Heading:** `.obj_issue_toc .heading` no longer renders the oversized padded box (91px → 31px) when only the "Published" chip is present; padding/background/margins compacted.

## [1.4.0] - 2026-11-10

### Fixed
- **Article Page Grid Collapse (P0):** Parent `.row` clearfix `::before/::after` became CSS Grid items and parent `.main_entry` kept `float:left; width:calc(100% - 305px)`, collapsing the main column to 0px and the abstract to 60px. Pseudo-elements are now hidden inside `.jrdc-article__row` and both grid children reset to `float:none; width:auto; min-width:0`. Verified at 1440/1280/1024/768/390/320: main 467px, abstract 467px, sidebar 234px at 1440.
- **Giant ✕ on Mobile Panel (P1):** Parent `.pkp_site_nav_toggle--transform > span::before/::after` rotated 100%-wide bars by ±405° across the header. Parent pseudo-elements are now disabled; the three child bars animate into a tidy X instead.
- **Duplicate Search at 768/1024 (P1):** `.jrdc-nav__search { display:flex !important }` (later in cascade) beat `.jrdc-header__search { display:none !important }` at equal specificity. Header search is now hidden ≤1199px with `.pkp_head_wrapper.jrdc-header__inner` specificity. Exactly one visible search form when the panel is open.
- **Mobile Panel 7px Gap:** `#jrdcSiteNav` used hardcoded `top:80px` while the mobile header is 73px. Changed to `top:calc(100% + 1px)`; measured gap is now 0.
- **Search Page Button:** Parent `button.submit::before/::after` icon overlay covered the "Search" label. Both pseudo-elements are now disabled.
- **Dark Toggle Double Border:** Global `.jrdc-theme-toggle` border overrode the mobile rule. Border is now `none` inside the bordered controls box ≤1199px.
- **Toggle aria-expanded:** Parent handler toggles classes but never sets `aria-expanded`; child now mirrors the state on the next tick so screen readers stay in sync.
- **Header Search Button Pseudo:** `.jrdc-search__button::before/::after` (parent default icon) are now disabled for consistency, matching the search-page fix.
- **Duplicate PDF CTA:** The primary galley block in the article sidebar is hidden because the same download is already shown above the fold in the main column; supplementary galleys remain visible.

### Changed
- **Sidebar Blocks Cleaned:** Removed `sinta`, `in-collaboration-with`, and `template` from the Custom Block Manager list (duplicate "Sejarah Jurnal" link, partner placeholders, missing template URL). `journal-profile` now shows only verified data (name, abbreviation, publisher); dummy "Visitor counter" label and mailing-address bracket placeholders removed. The core Web Feed block (misleadingly titled "Current Issue", showing only Atom/RSS icons) is hidden from the sidebar; feeds remain in `<head>`.
- **CHANGELOG/Version Sync:** Entries ordered newest-first; `version.xml` release updated to `1.4.0.0`.

## [1.3.0] - 2026-11-09

### Changed
- **Mobile Header Layout:** First row on screens ≤1199px now contains only brand (left) and bordered toggle box (hamburger + light/dark, right). Search form, navigation, and user/admin menu (Daftar/Masuk) moved into the dropdown panel (`#jrdcSiteNav`) so the first row stays clean and overflow-free.
- **Desktop Header Order:** `brand → search (flexible, 170px basis; 240px basis ≥1360px, shrinks to fit) → primary nav → actions`. Brand text hidden ≤1360px (logo only) to fit the 1280px container without overflow; nav link padding tightened to 0.65rem.

### Fixed
- **Hamburger Position:** Parent Sanguline sets `.pkp_site_nav_toggle { position: absolute }` which threw the toggle out of the controls box on mobile — neutralized with `position: static !important`.
- **User Menu Visibility:** Mobile hide rule for `.jrdc-nav__user` moved after the base rule with higher specificity so Daftar/Masuk no longer shows in the first row on phones.
- **Panel Block Cascade:** Mobile search/user blocks inside the nav panel now override the desktop `display: none` via EOF media rule, so the panel actually shows Search → Navigation → Daftar/Masuk.

### Added
- **Mobile Panel Blocks:** Second search form (`#jrdc-search-query-mobile`) and second user menu (`#navigationUserMobile`) inside `#jrdcSiteNav` for mobile only; desktop keeps the original header search/user menu. All Smarty `{load_menu}`, `{url}`, and `{translate}` logic preserved; no core/parent files modified.

## [1.2.0] - 2026-11-09

### Added
- **Page-level Styling (CSS-only, no template overrides):** `.page_about` (editorial sections), `.page_issue` / `.obj_issue_toc` (cover + section headings), `.page_announcement` / `.obj_announcement`, and `.page_login` / `.page_register` (minimal modern forms) in `modern.less`.
- **QA (Tahap 7):** All 9 public routes return 200; desktop 1440px and mobile 390px show no horizontal overflow.

### Notes
- About/issue/archive/search/announcement/login/register templates remain core OJS (verified by sub-agent audit: hooks, routing, galley/TOC/pagination includes intact). They are styled via the shared `.pkp_structure_main > .page` card + new page sections, so OJS workflow and plugins are untouched.

## [1.1.0] - 2026-11-09

### Added
- **Design System Tokens:** CSS custom properties (`:root` --jrdc-*) in `modern.less` alongside LESS variables for runtime theming and dark mode.
- **Child JS Bundle:** `js/jrdc.js` (hamburger sync + Escape/click-outside, dark-mode localStorage persistence, DOI copy button, abstract-toggle fallback, article reading-progress bar) registered via `addScript()` with forward-slash URL.
- **Homepage Hero CTAs:** "Lihat Edisi Terbaru" and "Panduan Penulis" buttons; larger cover (260px) with accessible placeholder.
- **Article Improvements:** DOI copy button, prominent PDF download area above the fold in `article_details.tpl`, reading-progress bar, primary/secondary button hierarchy.
- **Zero Inline Styles:** Removed all `style="..."` from theme templates (header, footer, homepage, article cards) — presentation now fully in `modern.less`.

### Fixed
- **Sidebar Hook Duplication:** Removed `Templates::Common::Sidebar` hook call from `indexJournal.tpl`; `footer.tpl` is now the single renderer so Block Manager plugins run once.
- **Open-Access Badge:** `article_summary.tpl` now shows "Akses Terbuka" only when `publishingMode` or article `accessStatus` is open; removed static "Peer-Reviewed" badge.
- **Announcement Slider A11y:** Prev/next buttons use localized labels; dots use concise `Slide N` labels.
- **Script URL Backslash:** Child `jrdc.js` also registered with `$base` absolute URL to avoid Windows `DIRECTORY_SEPARATOR` 404.

### Changed
- **Article Summary Hierarchy:** PDF primary, Detail secondary, Abstract ghost; title uses `clamp()` for fluid type.
- **Announcement Slider:** Renders as vertical list on ≤640px; `prefers-reduced-motion` disables smooth scroll and reading-progress bar.
