# Changelog

## 2026-11-07 — Pure CSS theme, prototype parity

- Replaced compiled Tailwind `plugins/themes/jrdcTheme/styles/jrdc.css` (~28 KB) with hand-written CSS: CSS variables, Grid, Flexbox, `clamp()` fluid type, `.dark` overrides. No build step, no `@apply`, no utility classes.
- Added core-object styling: `.obj_issue_toc`, `.obj_article_summary`, `.obj_issue_summary`, `.issues_archive`, `.galleys_links`, `.cmp_breadcrumbs`, `.cmp_notification`, `.pkp_block`, `.search_results`, forms, tables, pagination.
- Tokens: prototype-matching `#c2410c` primary, `#fbbf24` accent, Geist font, `#0b2038` hero.
- Brand: `brandMark.tpl` (reusable SVG), `brandTagline` option.
- Footer: 4-column layout with brand tile, links, contact, social icons (`socialIcon.tpl`), amber headings, `jrdc-footer__brand-name/__tagline`.
- Sidebar: option-gated cards with new icon markup (`.jrdc-sidecard__icon`).
- Announcements: date badge (`.jrdc-announcements__date/__day/__month`) beside title + teaser.
- Hero: optional cover image, CSS-drawn fallback (`.jrdc-cover`) when no upload; `heroFacts` and `homeFeatures` via `getPairs()`.
- `getPairs()` added to parse free-text options (hero facts, features, stats) that don't require URL schemes.
- Deleted `assets/themes/jrdcPure/` — 3.3 duplicate that cannot load here.
- DB: seeded theme options (hero, footer, sidebar links, social channels).
- Verified: `php -l` clean; 12 routes 200; `jrdcTheme-ojs35.zip` (30 KB, 30 files).

## 2026-11-07 — Seed DB prototype data + fix locale conflict
- Populated DB with prototype data: journal settings (description, aims/scope, contact, ISSN, open access, privacy), 1 section (Artikel Penelitian), 1 published current issue (Vol. 1 No. 1, Apr 2026), 3 published articles with authors, 3 announcements, author user group.
- Theme options populated via plugin_settings: hero, about card, features, footer, sidebar (about/links/stats/share), stats items.
- Fixed 500 caused by conflicting `privacyStatement` rows (locale '' vs 'en_US' for a multilingual setting): removed the empty-locale row, kept en_US. Also set `enableAnnouncements=1` and `numAnnouncementsHomepage=3`.
- Verified: homepage now renders hero/about/latest-issue/announcements/sidebar/footer; issue view and article view render with content; no 500; no overflow at 1440/1024/768/375.
- DB backup: `ojs-jrdc/cache/db-post-seed-2026-11-07.sql` (pre-seed backup retained at `db-pre-seed-2026-11-06.sql`).

## 2026-11-06 — Theme `jrdc` (OJS 3.3) dari prototipe

- New theme `ojs-jrdc/plugins/themes/jrdc/` (OJS 3.3 non-namespaced style, `JrdcThemePlugin.inc.php` + `index.php`), 22 theme options via `ThemePlugin::addOption` (colours, hero, nav, homepage about, footer, 6 sidebar toggles, sidebar links/tools/stats/share, static text). Tailwind compiled to `styles/jrdc.css`; `js/jrdc.js` for dark mode, mobile nav, copy link.
- Templates: header/footer act as the page shell (`<main>` opened in header, closed in footer) so issue/article/search/about/login/etc. inherit it. Only `frontend/pages/indexJournal.tpl` and the staticPages `content.tpl` are overridden; everything else is styled through semantic classes (`.jrdc-card`, `.jrdc-prose`, `.obj_article_summary`, `.obj_issue_toc`, `.cmp_form`, …).
- Colours are CSS variables injected per request, so Tailwind utilities follow the admin choice without a rebuild. Nav uses `{load_menu}` with a fallback menu (Home/About/Archives/Submissions/Contact, Login/Register or Dashboard/Logout) because the fresh journal has no navigation menus.
- Link textareas are `Label | URL [| Note]`, filtered in PHP: unknown schemes (`javascript:` etc.) are dropped.
- Activation in this install: `versions` row (`plugins.themes` / `jrdc` / `JrdcThemePlugin`, `current=1`) + `plugin_settings` `jrdcthemeplugin-1-enabled=1` + `journal_settings.themePluginPath='jrdc'`. Without the plugin_settings row the theme is not loaded and `$activeTheme` is null (fatal in templates).
- Verified with agent-browser at 1440/1024/834/768/375/360 px on index/about/issue-archive/search/login: no horizontal overflow, nav collapses at <1024 px, mobile menu and dark mode (persisted) work; option changes (colour, hero title, sidebar links) render correctly. Issue/article pages are inherited core templates but not visually verified — this journal has 0 sections/issues/articles.
- Note: `lib/pkp/tools/installPluginVersion.php` fatals on this PHP build (`xml_parser_create(): Argument #1 ($encoding) is not a supported source encoding`), so the version row was inserted directly.

## 2026-11-06 — Responsif prototipe + hapus label sampul
- Hapus “Vol. 1 No. 1 · 2026 / Edisi Perdana” dari kartu sampul hero (termasuk caption duplikatnya).
- Responsif: breakpoint menu hamburger dinaikkan 768→1024px (header tablet 834px sebelumnya pecah 3 baris); target sentuh menu ponsel ≥44px; meta hero ditumpuk di ≤768px; sampul ≤260px di ponsel; padding kartu & jarak konten dikurangi di ponsel. Terverifikasi via agent-browser di 1440/1024/834/768/375/360px — tanpa overflow horizontal, menu & dropdown ponsel berfungsi.

## 2026-11-06 — Prototype beranda JRDC direvisi (design-taste-frontend)
- `docs/prototype/index.html` + `styles.css` + `script.js` direvisi dari panduan UI:
  satu bahasa (Indonesia), satu menu utama (chip hero & duplikasi Latest/Current dihapus),
  klaim indeks diganti status "dalam proses", statistik manual/"Dibaca" dihapus,
  ISSN/DOI/alamat/telepon placeholder diganti status jujur, sampul CSS tanpa gambar eksternal,
  palet #143C5A/#B23A00, font Manrope+Lora, GSAP/Lenis diganti CSS+vanilla JS, menu ponsel.
- Backup: `/mnt/DiskD/Workspace/Backups/ojs-prototype/`.

## 2026-11-06 — Downgrade to OJS 3.3.0-24 + port themes

- Deleted OJS 3.5 install; installed OJS 3.3.0-24 (PHP 8.1, MariaDB 10.6).
- Ported `journalEditorial` and `akdisi` themes from OJS 3.5 APIs to OJS 3.3:
  - Removed namespaces/`use`; `Hook::add` → `HookRegistry::register`; `Locale::getLocale` → `AppLocale::getLocale`; `Repo::*` → DAOs (`SubmissionDAO::getExportable`, `IssueDAO`, `SectionDAO`, `JournalSettingsDAO`); `DB::table` → `JournalSettingsDAO::getSettings`; `Illuminate\DB` removed.
  - `index.php` wrappers updated to 3.3 style.
  - Templates: `router=PKP\core\PKPApplication::ROUTE_PAGE` removed; `editorialMasthead` links/overrides renamed to `editorialTeam`; `->count()` → `|@count`/`getId()`/`getDatePosted()`; announcements assigned as array.
- Backups: `/mnt/DiskD/Workspace/Backups/ojs-jrdc/2026-11-06-pre-3.3/` (db-ojs35.sql.gz, ojs-jrdc-3.5.tar.gz).
- Verified: both themes render homepage + about/search/issue archive/login without fatal.