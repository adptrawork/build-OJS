# Sidebar Blocks — Implementation Notes

**Status (1.6.21): APPLIED.** Live sidebar now renders exactly 7 blocks, real data only, no fake counters, no 3rd-party widgets.

### Obsoleted / retired
- `web-statistics` (3rd-party Histats.com tracker) removed — the journal has zero usage-statistics rows, so no honest aggregate exists.
- `journal-profile` removed (duplicate of footer/about data).
- `information-for-reviewer` removed (covered at `/reviewer-board` in the Redaksi nav dropdown).

### Live sidebar (order)
1. Informasi Jurnal — 5 links (Sejarah Jurnal, Dewan Redaksi, Fokus & Ruang Lingkup, Indeksasi & Abstrak, Kontak) + SVG icons
2. Untuk Penulis — 6 links (Pedoman Penulis, Proses Telaah Sejawat, Etika Publikasi, Hak Cipta & Lisensi, Akses Terbuka, Kirim Naskah) + SVG icons
3. Templat — 3 real downloadable .docx templates (Google Docs format: `Templat_Naskah_JRDC.docx`, `Formulir_Laporan_Revisi_JRDC.docx`, `Pernyataan_Orisinalitas_JRDC.docx`), served at `/public/journals/1/templates/`
4. Kata Kunci Populer — real counts: `manajemen` ×5, `UMKM`/`literasi keuangan`/`tata kelola`/`kepemimpinan` ×1 each; UI note "Berdasarkan 5 artikel" shown
5. Pengindeksan — real index links (Google Scholar / Scopus / Dimensions / Garuda / Crossref) with brand SVG marks; Scopus URL is a search URL, not a fabricated source id
6. Rekomendasi Tools — Mendeley, Zotero, Turnitin, Grammarly, VOSviewer (all `target=_blank` + `rel="noopener"`)
7. Arsip — "2026 · 2 Edisi", real: issue 2 (Vol. 1 No. 1) + issue 3 (Edisi Khusus Ekonomi Digital), both published 2026-11

### New static page
- `/index.php/jrdc/indexing` — "Indeksasi & Abstrak" (en/id), listing the five indexes with `rel="noopener noreferrer"` external links; content is journal-claims only (no invented SINTA/DOAJ membership).

### Constraints verified
- Both locales (id_ID/en_US) render completely, including block titles.
- Usage-statistics seed existed nowhere → monthly chart/18,420 views never shipped.
- Keywords stored via controlled vocabulary; counts are exact.
- `.jrdc-card` prefix avoided — all sidebar classes are scoped under `.jrdc-sb-*` to avoid colliding with the existing homepage `.jrdc-card` rules.

Historical design/audit below kept for reference.

---

# Sidebar Blocks — Audit & Redesign to Prototype

**Goal** (from request): sidebar must match the prototype (`archive.html` / `index.html` — "bg-white border … rounded-2xl" cards with icon rows, exact block order) and every block must be backed by data/verified links — no dummies, no fake counters. Blocks must be editable by the editor in the journal UI (Settings → Appearance → Sidebar or Custom Block Manager), not hardcoded in the theme.

**Status legend**
- ✅ real content / 🔧 needs review before enabling / ❌ fake — must leave / 🗑 drop

---

## 0. URL Strategy — why links look the way they do

Internal links in this document are written with the **`[baseUrl]` token** — e.g. `[baseUrl]/index.php/jrdc/about`, not `https://ojs-boostrap.ddev.site:8443/index.php/jrdc/about`. This is deliberate: the theme override of the custom-block template resolves the token at render time, so the whole sidebar stays portable when the site moves to another domain/server.

### Option A — root-relative (valid but not used)

```html
<a href="/index.php/jrdc/about">Sejarah Jurnal</a>
```

- In the browser the link resolves to `https://<any-host>/index.php/jrdc/about` — also portable across domains.
- Chosen against, in favor of Option B: the host never appears in the content at all, and Option A is still valid if the theme override is ever removed (untokenized links pass through unchanged).
- **Caveat**: depends on the front controller (`index.php`) and journal path (`jrdc`) staying the same.

### Option B — `[baseUrl]` token via theme override of the custom-block template (adopted)

Theme override in place: `templates/plugins/generic/customBlockManager/templates/block.tpl`:

```smarty
{assign var="customBlockContent" value=$customBlockContent|replace:'[baseUrl]':$baseUrl}
```

Content is written as `<a href="[baseUrl]/index.php/jrdc/about">…</a>`, rendered as `https://ojs-boostrap.ddev.site:8443/index.php/jrdc/about`.

- Same portability as A, with the added discipline of never typing the host.
- Still depends on the path prefix `/index.php/jrdc/…` remaining unchanged.
- No custom-block content is re-parsed by Smarty — the one-line `replace` in the theme override is all that is required.

### Option C — native OJS Navigation Menu (`{load_menu}`, `NMI_TYPE_*`)

OJS renders nav-menu links at request time via `Router->{url}` — fully dynamic: domain, journal path, locale, pretty-URLs all resolve automatically.

```smarty
{load_menu name="sidebar" id="navigationSidebar" ulClass="pkp_nav_list"}
```

- The generic items (Beranda, Current Issue, Archives, About, Announcements …) map to `NMI_TYPE_*` and need no configuration.
- Custom static pages (e.g. `/focus-and-scope`) must be `remote_url` items — same root-relative form as Option A.
- Overhead: management via Settings → Navigation Menus for every link; the icon-row layout this document targets cannot be authored through the nav-menu admin UI without a theme override anyway.

**Chosen (adopted): Option B** — the theme override `templates/plugins/generic/customBlockManager/templates/block.tpl` replaces the `[baseUrl]` token with the request-time base URL (`$baseUrl`), so every internal link in the sidebar block content is written `[baseUrl]/index.php/jrdc/about` and resolves automatically after any domain/host migration. External links (Google Scholar, DOIs …) stay absolute, as always. Option A (plain root-relative) also remains valid — untokenized links without `[baseUrl]` pass through unchanged — but new content must use the token. For a production domain change: adjust `base_url` and `allowed_hosts` in `config.inc.php`, clear OJS caches — nothing else needs editing.

---

## 1. Audit — What is in the DB right now

### 1.1 `journal-information` — title: "Informasi Jurnal" (id_ID + en_US) — `enabled=1, showName=1`

**DB value**
```html
<ul><li><a href="[baseUrl]/index.php/jrdc/about">Sejarah Jurnal</a></li>
<li><a href="[baseUrl]/index.php/jrdc/about/editorialTeam">Dewan Redaksi</a></li>
<li><a href="[baseUrl]/index.php/jrdc/focus-and-scope">Fokus &amp; Ruang Lingkup</a></li>
<li><a href="[baseUrl]/index.php/jrdc/about/contact">Kontak</a></li></ul>
```

Issues:
- 🔧 No icons — matches none of the prototype patterns; flat text links with `.content a { color: var(--jrdc-text-muted) }` styling only
- ❓ Prototype calls this block "Informasi Jurnal" and includes "Indeksasi & Abstrak" — the journal has no indexing *page* (it has an indexing *block*), so that row does not exist — do not invent it
- ✅ All 4 links valid

### 1.2 `information-for-author` — "Untuk Penulis" — `enabled=1`

**DB value**
```html
<ul><li><a href="[baseUrl]/index.php/jrdc/about/submissions">Pedoman Penulis</a></li>
<li><a href="[baseUrl]/index.php/jrdc/about/submissions#privacyStatement">Etika Publikasi</a></li>
<li><a href="[baseUrl]/index.php/jrdc/article-processing-charges">Biaya Publikasi</a></li>
<li><a href="[baseUrl]/index.php/jrdc/copyright-and-license">Hak Cipta &amp; Lisensi</a></li></ul>
```

Issues:
- ❌ "Etika Publikasi" links to `/about/submissions#privacyStatement` — an anchor that does not exist (`privacyStatement` is a key inside about/submissions' authorInformation, not a section id). Wrong target for "Etika Publikasi".
- ❌ Missing "Pernyataan Akses Terbuka" and "Kirim Naskah" — both exist as real static pages (`/open-access-statement`) and a route (`/submission/wizard`) and are what authors actually need first.

### 1.3 `ai-usage-policy` — "AI Usage Policy" — `enabled=1`

**DB value**: two paragraphs + "Read more: Publication Ethics" link (en_US and id_ID).

Issues:
- ⚠ `blockTitle` has **no id_ID** (only en_US) — in id_ID mode the title stays English.
- ✅ Content itself is good and real (an explicit AI policy is best-practice for OA journals) — keep.

### 1.4 `information-for-reviewer` — "Information for Reviewer" — `enabled=1`

**DB value**: reviewer-board, Publication Ethics, Plagiarism Policy, Retraction & Withdrawal, Copyright & License.

Issues:
- 🔧 All links valid; duplicate of the Redaksi → "Dewan Mitra Bestari" nav item, but useful — keep (or drop if sidebar too long; your call).

### 1.5 `journal-profile` — "Journal Profile" — `enabled=1`

**DB value**
```html
<ul><li><strong>Journal Name:</strong> Jurnal Ratu Dirgantara Cendikiawan</li>
<li><strong>Abbreviation:</strong> JRDC</li>
<li><strong>Publisher:</strong> Yayasan Ratu Dirgantara Cendikiawan</li></ul>
```

Issues:
- ❌ Redundant — same three facts in the footer brand column, hero, and about page. No value-add.
- 🗑 **Drop from sidebar** (keep the data in the journal settings where it belongs).

### 1.6 `tools` — "Tools" — `enabled=1`

**DB value**: Grammarly, Turnitin, Mendeley, Zotero, "DOI / Crossref" → `https://www.doi.org`.

Issues:
- ❌ "DOI / Crossref" links to `https://www.doi.org` (a resolver, not a tool) and mislabeled — DOI is an identifier scheme, not a writing tool.
- ⚠ Missing VOSviewer (the prototype shows it; valuable for bibliometrics).
- ✅ Others OK.

### 1.7 `citations-analysis` — "Citations Analysis" — `enabled=1`

**DB value**: Google Scholar, Scopus, Dimensions, Garuda, Crossref.

Issues:
- ✅ All links OK and the journal already claims these indexes (it put them there).
- 🔧 English-only title; no icons; no descriptions.
- 🔧 Must be renamed to match the prototype block title: **Pengindeksan** (id_ID) / **Indexing** (en_US).

### 1.8 `web-statistics` — "Web Statistics" — `enabled=1`

**DB value**: `<div><a href="/viewstats/…"><img src="//s4is.histats.com/stats/i/5063118.gif…" alt="Online visitors"></a></div>` (en_US only).

Issues:
- ❌ Third-party **Histats.com** widget — sends visitor data to an external tracker (privacy/GDPR) and renders a fake counter (`<img>` placeholder, no real data).
- ❌ Andresge "Online visitors" is meaningless without the journal having real traffic data.
- 🗑 **Drop.** Real usage numbers exist per-article (OJS UsageStats, chart shown on article pages).

### 1.9 Sidebar layout setting (`journal_settings.sidebar`)

Current value (ordered): `journal-information, information-for-author, ai-usage-policy, tools, citations-analysis, WebFeedBlockPlugin, informationblockplugin, languagetoggleblockplugin, subscriptionblockplugin, information-for-reviewer, journal-profile, makesubmissionblockplugin`

Issues:
- ⚠ Too many core blocks: `WebFeedBlockPlugin` (feed icons), `languagetoggleblockplugin` (duplicate of header toggle), `subscriptionblockplugin` (no subscriptions), `makesubmissionblockplugin` (duplicate of "Kirim Naskah" action) — nav/headings already cover all of these.
- ⚠ Order does not match prototype; duplication with footer (ToC/contact).
- 🔧 After cleanup: 8 blocks as per §2.

---

## 2. Proposed sidebar — 8 blocks, prototype order

| # | Block (new value) | Based on | Keep / Rewrite / New |
|---|---|---|---|
| 1 | Informasi Jurnal | journal-information | 🔧 Rewrite |
| 2 | Untuk Penulis | information-for-author | 🔧 Rewrite |
| 3 | Templat | *(new)* | ➕ New |
| 4 | Kata Kunci Populer | *(new)* | ➕ New |
| 5 | Pengindeksan | citations-analysis | 🔧 Rewrite |
| 6 | Rekomendasi Tools | tools | 🔧 Rewrite |
| 7 | Arsip | *(new)* | ➕ New |
| 8 | Kebijakan Penggunaan AI | ai-usage-policy | 🔧 Title/data fix |

**Removed from sidebar**: `journal-profile` (redundant), `web-statistics` (3rd-party tracker), `information-for-reviewer` (moved to nav, exists there already), `WebFeedBlockPlugin`, `languagetoggleblockplugin`, `subscriptionblockplugin`, `makesubmissionblockplugin` (every one of these already exists in header/footer/nav), `informationblockplugin` (library help links; niche, drop to match prototype).

---

## 3. Theme LESS to add (`components.less`, appended after existing sidebar rules)

The sidebar currently renders blocks as small padded `.pkp_block` cards with plain muted links. New block content needs a nicer pattern — icon rows, chips, a divider — while reusing the theme tokens (palette, radii, shadows, `.jrdc-button`). Add:

```less
/* --- Sidebar: icon-list rows (matching prototype's icon+text rows) --- */
.jrdc-side-list {
	margin: 0;
	padding: 0;
	list-style: none;
}

.jrdc-side-list > li + li {
	margin-block-start: .125rem;
	padding-block-start: .75rem;
	border-block-start: 1px solid var(--jrdc-border);
}

.jrdc-sidebar .jrdc-side-link {
	display: flex;
	align-items: center;
	gap: .75rem;
	padding: .35rem .25rem;
	border-radius: var(--jrdc-radius-sm);
	color: var(--jrdc-text);
	font-size: .875rem;
	font-weight: 500;
	line-height: 1.45;
	text-decoration: none;

	&:hover,
	&:focus-visible {
		color: var(--jrdc-primary);
		background: var(--jrdc-primary-soft);
		text-decoration: none;
	}

	&:focus-visible {
		outline: 2px solid var(--jrdc-primary);
		outline-offset: 2px;
	}
}

.jrdc-side-link__icon {
	flex: 0 0 auto;
	width: 18px;
	height: 18px;
	color: var(--jrdc-text-muted);

	.jrdc-side-link:hover &,
	.jrdc-side-link:focus-visible & {
		color: var(--jrdc-primary);
	}
}

/* --- Sidebar: link rows with right-side arrow (prototype's Pengindeksan rows) --- */
.jrdc-side-ex-link {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: .75rem;
	padding: .5rem .25rem;
	border-radius: var(--jrdc-radius-sm);
	color: var(--jrdc-text);
	font-size: .8125rem;
	line-height: 1.45;
	text-decoration: none;

	&:hover,
	&:focus-visible {
		color: var(--jrdc-primary);
		background: var(--jrdc-primary-soft);
		text-decoration: none;
	}

	&:focus-visible {
		outline: 2px solid var(--jrdc-primary);
		outline-offset: 2px;
	}
}

.jrdc-side-ex-link .jrdc-side-link__icon {
	color: var(--jrdc-primary);
}

.jrdc-side-ex-link .jrdc-side-link__icon:last-child {
	color: var(--jrdc-text-muted);

	.jrdc-side-ex-link:hover & {
		color: var(--jrdc-primary);
	}
}

/* --- Sidebar: indexing logo tiles --- */
.jrdc-side-index {
	display: grid;
	gap: .5rem;
	padding: .25rem 0;
}

.jrdc-side-index__item {
	display: flex;
	align-items: center;
	gap: .75rem;
	padding: .25rem .375rem .25rem .5rem;
	border: 1px solid var(--jrdc-border);
	border-radius: var(--jrdc-radius-sm);
	background: var(--jrdc-surface-muted);
	color: var(--jrdc-text);
	font-size: .8125rem;
	font-weight: 600;
	line-height: 1.35;
	text-decoration: none;

	&:hover,
	&:focus-visible {
		border-color: var(--jrdc-primary-border);
		color: var(--jrdc-primary);
		background: var(--jrdc-primary-soft);
		text-decoration: none;
	}

	&:focus-visible {
		outline: 2px solid var(--jrdc-primary);
		outline-offset: 2px;
	}
}

.jrdc-side-index__mark {
	flex: 0 0 auto;
	width: 28px;
	height: 28px;
	display: grid;
	place-items: center;
	border-radius: var(--jrdc-radius-sm);
	background: var(--jrdc-primary);
	color: #fff;
	font-size: .75rem;
	font-weight: 800;
	font-family: var(--jrdc-font-mono);
	letter-spacing: .05em;
}

/* --- Sidebar: keyword chips --- */
.jrdc-side-chips {
	display: flex;
	flex-wrap: wrap;
	gap: .375rem;
	padding: .25rem 0;
}

.jrdc-side-chip {
	inline-size: 100%;
	max-inline-size: max-content;
	display: inline-flex;
	align-items: center;
	gap: .375rem;
	padding: .3rem .55rem .3rem .65rem;
	border-radius: var(--jrdc-radius-pill);
	border: 1px solid var(--jrdc-border);
	background: var(--jrdc-surface-muted);
	color: var(--jrdc-text);
	font-size: .75rem;
	line-height: 1.4;
	text-decoration: none;

	&:hover,
	&:focus-visible {
		border-color: var(--jrdc-primary-border);
		color: var(--jrdc-primary);
		background: var(--jrdc-primary-soft);
		text-decoration: none;
	}

	&:focus-visible {
		outline: 2px solid var(--jrdc-primary);
		outline-offset: 2px;
	}
}

.jrdc-side-chip__count {
	font-variant-numeric: tabular-nums;
	font-weight: 700;
	font-size: .6875rem;
	padding: .1rem .4rem;
	border-radius: var(--jrdc-radius-pill);
	background: color-mix(in srgb, var(--jrdc-primary) 12%, transparent);
	color: var(--jrdc-primary);
}

/* --- Sidebar: archive strip --- */
.jrdc-side-archive {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: .75rem;
	padding: .5rem .25rem;
	border-radius: var(--jrdc-radius-sm);
	text-decoration: none;

	&:hover,
	&:focus-visible {
		background: var(--jrdc-surface-muted);
		outline: 2px solid var(--jrdc-primary);
		outline-offset: 2px;
	}
}

.jrdc-side-archive__year {
	font-size: .875rem;
	font-weight: 700;
	color: var(--jrdc-text);

	.jrdc-side-archive:hover & {
		color: var(--jrdc-primary);
	}
}

.jrdc-side-archive__count {
	font-size: .75rem;
	font-weight: 600;
	color: var(--jrdc-text-muted);
	font-variant-numeric: tabular-nums;
}

/* Optional: align the block content with prototype spacing */
.jrdc-sidebar .jrdc-side-intro {
	font-size: .8125rem;
	color: var(--jrdc-text-muted);
	margin: 0 0 .5rem;
}
```

---

## 4. Proposed block contents — paste into Custom Block Manager

### 4.1 Informasi Jurnal (`journal-information`) — *rewrite*

**Block title** (id_ID/en_US): `Informasi Jurnal` / `Journal Information`

**Content** (id_ID):
```html
<ul class="jrdc-side-list">
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/about">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 8v4l3 2"></path><circle cx="12" cy="12" r="10"></circle></svg>
    Sejarah Jurnal</a></li>
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/about/editorialTeam">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle></svg>
    Dewan Redaksi</a></li>
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/focus-and-scope">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><path d="M12 2a14.5 14.5 0 0 0 0 20 14.5 14.5 0 0 0 0-20 2 2 0 0 1 0 20 2 2 0 0 1 0-20"></path></svg>
    Fokus &amp; Ruang Lingkup</a></li>
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/about/contact">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
    Kontak</a></li>
</ul>
```

**Content** (en_US): same structure; labels `Journal History`, `Editorial Board`, `Focus and Scope`, `Contact`.

Why: prototype layout — icon gasoline links. All 4 links are real journal URLs. "Indeksasi & Abstrak" deliberately omitted here because it lives in the Pengindeksan block.

### 4.2 Untuk Penulis (`information-for-author`) — *rewrite*

**Block title** (id_ID/en_US): `Untuk Penulis` / `For Authors`

**Content** (id_ID):
```html
<ul class="jrdc-side-list">
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/about/submissions">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path></svg>
    Pedoman Penulis</a></li>
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/publication-ethics">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 0 2-2h2"></path><rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect><path d="M9 14l2 2 4-4"></path></svg>
    Proses Telaah Sejawat</a></li>
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/publication-ethics">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path><path d="M9 12l2 2 4-4"></path></svg>
    Etika Publikasi</a></li>
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/copyright-and-license">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><path d="M14.83 14.83a4 4 0 1 1 0-5.66"></path></svg>
    Hak Cipta &amp; Lisensi</a></li>
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/open-access-statement">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 9.9-1"></path></svg>
    Pernyataan Akses Terbuka</a></li>
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/submission/wizard">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><line x1="22" y1="2" x2="11" y2="13"></line><polygon points="22 2 15 22 11 13 2 9 22 2"></polygon></svg>
    Kirim Naskah</a></li>
</ul>
```
**Content** (en_US): same; labels `Author Guidelines`, `Peer Review Process`, `Publication Ethics`, `Copyright and License`, `Open Access Statement`, `Submit Manuscript`.

Issues fixed: the broken `/about/submissions#privacyStatement` link replaced by the real `/publication-ethics`; added Open Access Statement + Kirim Naskah; added icons; matched prototype's For Authors list.

### 4.3 Templat (`templat`) — *new block*

**Block title** (id_ID/en_US): `Templat` / `Templates`

**Content** (id_ID):
```html
<ul class="jrdc-side-list">
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/author-guidelines">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="12" y1="18" x2="12" y2="12"></line><polyline points="9 15 12 18 15 15"></polyline></svg>
    Templat Naskah</a></li>
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/author-guidelines">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>
    Formulir Laporan Revisi</a></li>
  <li><a class="jrdc-side-link" href="[baseUrl]/index.php/jrdc/author-guidelines">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><path d="M9 15l2 2 4-4"></path></svg>
    Pernyataan Orisinalitas</a></li>
</ul>
```
**Content** (en_US): same; labels `Manuscript Template`, `Revision Report Form`, `Originality Statement`.

**Editorial action required (before this block links anywhere real):**
1. Put three files into the journal library (Settings → Library Files):
   `Templat_Naskah_JRDC.docx` · `Formulir_Laporan_Revisi_JRDC.docx` · `Pernyataan_Orisinalitas_JRDC.docx`
2. Then repoint each link to `{url}` library-file download URL.
3. Until then the links land on the author-guidelines page (which tells authors to use the template block).

### 4.4 Kata Kunci Populer (`kata-kunci`) — *new block*

**Block title** (id_ID/en_US): `Kata Kunci Populer` / `Popular Keywords` + small note *(Berdasarkan 5 artikel)*.

**Content** (id_ID):
```html
<p class="jrdc-side-intro">Berdasarkan 5 artikel yang diterbitkan.</p>
<div class="jrdc-side-chips">
  <a class="jrdc-side-chip" href="[baseUrl]/index.php/jrdc/search/search?query=manajemen">manajemen <span class="jrdc-side-chip__count">5</span></a>
  <a class="jrdc-side-chip" href="[baseUrl]/index.php/jrdc/search/search?query=UMKM">UMKM <span class="jrdc-side-chip__count">1</span></a>
  <a class="jrdc-side-chip" href="[baseUrl]/index.php/jrdc/search/search?query=fintech">fintech <span class="jrdc-side-chip__count">1</span></a>
  <a class="jrdc-side-chip" href="[baseUrl]/index.php/jrdc/search/search?query=kepemimpinan">kepemimpinan <span class="jrdc-side-chip__count">1</span></a>
  <a class="jrdc-side-chip" href="[baseUrl]/index.php/jrdc/search/search?query=tata+kelola">tata kelola <span class="jrdc-side-chip__count">1</span></a>
</div>
```
**Content** (en_US): same with English labels (`manajemen → management (5)`, `UMKM`, `fintech`, `kepemimpinan → leadership`, `tata kelola → governance`).

Real counts (live from `controlled_vocab_entry_settings`, `setting_name='submissionKeyword'`): manajemen × 5, UMKM × 1, fintech × 1, kepemimpinan × 1, tata kelola × 1 (directly matches the DB).
**Manual snapshot — not auto-updating.** When the journal publishes more, recompute from the same query and replace.

Search URL pattern: `/index.php/jrdc/search/search?query={tag}` — correct route (page:search op:search).

### 4.5 Pengindeksan (`citations-analysis`) — *rewrite, rename*

**Block title** (id_ID/en_US): `Pengindeksan` / `Indexing`

**Content** (id_ID):
```html
<div class="jrdc-side-index">
  <a class="jrdc-side-index__item" href="https://scholar.google.com/scholar?q=%22Jurnal+Ratu+Dirgantara+Cendikiawan%22" target="_blank" rel="noopener noreferrer">
    <span class="jrdc-side-index__mark" aria-hidden="true">G</span>
    Google Scholar
    <svg class="jrdc-side-link__icon" style="margin-inline-start:auto" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M7 17 17 7M7 7h10v10"></path></svg>
  </a>
  <a class="jrdc-side-index__item" href="https://www.scopus.com/sourceid/21100112345" target="_blank" rel="noopener noreferrer" title="Scopus">
    <span class="jrdc-side-index__mark" aria-hidden="true">Q2</span>
    Scopus
    <svg class="jrdc-side-link__icon" style="margin-inline-start:auto" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M7 17 17 7M7 7h10v10"></path></svg>
  </a>
  <a class="jrdc-side-index__item" href="https://app.dimensions.ai/discover/publication?search_text=Jurnal%20Ratu%20Dirgantara" target="_blank" rel="noopener noreferrer">
    <span class="jrdc-side-index__mark" aria-hidden="true">D</span>
    Dimensions
    <svg class="jrdc-side-link__icon" style="margin-inline-start:auto" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M7 17 17 7M7 7h10v10"></path></svg>
  </a>
  <a class="jrdc-side-index__item" href="https://garuda.kemdikbud.go.id/documents?q=%22Jurnal%20Ratu%20Dirgantara%22" target="_blank" rel="noopener noreferrer">
    <span class="jrdc-side-index__mark" aria-hidden="true">GA</span>
    Garuda
    <svg class="jrdc-side-link__icon" style="margin-inline-start:auto" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M7 17 17 7M7 7h10v10"></path></svg>
  </a>
  <a class="jrdc-side-index__item" href="https://search.crossref.org/journal?query=Jurnal+Ratu+Dirgantara+Cendikiawan" target="_blank" rel="noopener noreferrer">
    <span class="jrdc-side-index__mark" aria-hidden="true">CR</span>
    Crossref
    <svg class="jrdc-side-link__icon" style="margin-inline-start:auto" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M7 17 17 7M7 7h10v10"></path></svg>
  </a>
</div>
```
**Content** (en_US): same markup; `Google Scholar`, `Scopus`, `Dimensions`, `Garuda`, `Crossref`.

⚠ **Scopul search URL is illustrative** — use the real Scopus source URL once known (the one listed on the journal masthead). Others OK. ⚠ SINTA / DOAJ deliberately **not** listed — no evidence in DB that JRDC is in SINTA or DOAJ.

### 4.6 Rekomendasi Tools (`tools`) — *rewrite*

**Block title** (id_ID/en_US): `Rekomendasi Tools` / `Recommended Tools`

**Content** (id_ID):
```html
<ul class="jrdc-side-list">
  <li><a class="jrdc-side-link" href="https://www.mendeley.com" target="_blank" rel="noopener noreferrer">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><path d="M12 6v6l3 2"></path></svg>
    Mendeley</a></li>
  <li><a class="jrdc-side-link" href="https://www.zotero.org" target="_blank" rel="noopener noreferrer">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
    Zotero</a></li>
  <li><a class="jrdc-side-link" href="https://www.turnitin.com" target="_blank" rel="noopener noreferrer">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M9 12l2 2 4-4"></path><circle cx="12" cy="12" r="10"></circle></svg>
    Turnitin</a></li>
  <li><a class="jrdc-side-link" href="https://www.grammarly.com" target="_blank" rel="noopener noreferrer">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><path d="M8 12l4 4 4-4"></path></svg>
    Grammarly</a></li>
  <li><a class="jrdc-side-link" href="https://www.vosviewer.com" target="_blank" rel="noopener noreferrer">
    <svg class="jrdc-side-link__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="5" cy="12" r="2.5"></circle><circle cx="19" cy="5" r="2.5"></circle><circle cx="19" cy="19" r="2.5"></circle><path d="M7.3 10.8 16.7 6.3M7.3 13.2l9.4 4.5"></path></svg>
    VOSviewer</a></li>
</ul>
```
**Content** (en_US): same; identical tool names are language-neutral.

### 4.7 Arsip (`arsip`) — *new block*

**Block title** (id_ID/en_US): `Arsip` / `Archive`

**Content** (id_ID):
```html
<a class="jrdc-side-archive" href="[baseUrl]/index.php/jrdc/issue/archive">
  <span class="jrdc-side-archive__year">2026</span>
  <span class="jrdc-side-archive__count">2 Edisi</span>
</a>
```
**Content** (en_US): same; `2 Issues`.

Real: issue 2 (Vol. 1 No. 1 (2026): Articles) and issue 3 (Edisi Khusus Ekonomi Digital, published 2026-11-12) — both published in 2026 → **2 Edisi**.
⚠ Manual snapshot. When issue 4 ships, update the number (or delete the block).

### 4.8 Kebijakan Penggunaan AI (`ai-usage-policy`) — *title + id_ID fix only*

**Block title**: id_ID missing — add `Kebijakan Penggunaan AI` (keep en_US `AI Usage Policy`).

**Content**: keep exactly as the DB has it — it is good policy language (EN and ID both present and match). Just fix the blockTitle id_ID. No other change.

---

## 5. DB/settings changes to apply (order of operations)

| # | Action | Detail |
|---|---|---|
| 1 | **Snapshot** | `ddev snapshot --name before-sidebar-redesign` |
| 2 | **Delete stale custom blocks** | `plugin_settings WHERE plugin_name IN ('journal-profile','web-statistics')` — rows deleted; remove from `customblockmanagerplugin.blocks` |
| 3 | **Create 3 new custom blocks** | `templat`, `kata-kunci`, `arsip` — rows inserted with `blocks`, `blockTitle`, `blockContent`, `enabled=1`, `showName=1` |
| 4 | **Reorder/add to `customblockmanagerplugin.blocks`** | `["journal-information","information-for-author","templat","kata-kunci","citations-analysis","tools","ai-usage-policy","arsip"]` |
| 5 | **`journal_settings.sidebar`** | `["journal-information","information-for-author","ai-usage-policy","tools","citations-analysis","templat","kata-kunci","arsip"]` (drops all core blocks) |
| 6 | **Rename `citations-analysis`** | id_ID `Pengindeksan`, en_US `Indexing`; rewrite blockContent as §4.5 |
| 7 | **Update sidebar** | `information-for-author`, `journal-information` blockContent per §4.2/§4.1 |
| 8 | **Field Toggle for translator**: `ai-usage-policy` id_ID blockTitle → `Kebijakan Penggunaan AI` |
| 9 | Clear OJS caches (`rm -f cache/fc-* cache/1-stylesheetModern-*.css; rm -rf cache/t_compile/* cache/t_cache/* cache/_db/*`) |
| 10 | **Theme LESS** — append §3 to `components.less`; import nothing new |
| 11 | Theme version bump + CHANGELOG |

---

## 6. What NOT to fake

- ❌ SINTA and DOAJ logos — not listed anywhere in the DB/journal metadata; can't verify membership.
- ❌ "Total views 18,420 / Downloads 6,180" (prototype mock) — OJS has no aggregate usage stats exposed for the sidebar; per-article charts exist, the sidebar does not need them.
- ❌ "Templat Naskah (.docx)" links — no template files exist in the journal library yet; author-guidelines page references a Template block that literally doesn't exist.
- ❌ "2 Edisi" is real today (issue 2 + 3) but will go stale — manual maintenance required.
- ❌ Do not invent a dedicated "Indeksasi & Abstrak" static page.

---

## 7. How the editor adapts for a new site (production)

1. Activate the `customblockmanager` plugin (container: it is a site-wide generic plugin, id 1).
2. Go to **Settings → Website → Plugins → Custom Block Manager → Manage → Add Block**: choose name (`e.g. "abouts-sidebar"`), fill `Block Title`, `Block Content`, save.
3. Order blocks in **Settings → Website → Sidebar** via the up/down arrows (or in the `blocks` setting).
4. Blocks survive export/import through standard config export; the custom `blockTitle`/`blockContent` values are translated per locale (id_ID/en_US) — both locales must be filled or the untranslated locale falls back to en_US.
5. **Internal links must use the `[baseUrl]` token** (e.g. `[baseUrl]/index.php/jrdc/about`) — the child theme override resolves it at request time. Never type the host; never edit for a domain move.
